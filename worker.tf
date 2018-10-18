resource "aws_iam_role" "demo_node" {
  name               = "${var.cluster_name}-worker"
  assume_role_policy = "${data.aws_iam_policy_document.worker_node_policy.json}"
}

resource "aws_iam_role_policy_attachment" "demo_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.demo_node.name}"
}

resource "aws_iam_role_policy_attachment" "demo_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.demo_node.name}"
}

resource "aws_iam_role_policy_attachment" "demo_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.demo_node.name}"
}

resource "aws_iam_instance_profile" "demo_node" {
  name = "terraform-eks-demo-worker"
  role = "${aws_iam_role.demo_node.name}"
}

resource "aws_security_group" "demo_node" {
  name        = "terraform-eks-demo-node-worker"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${module.vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "demo_node_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.demo_node.id}"
  source_security_group_id = "${aws_security_group.demo_node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo_node_ingress_cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo_node.id}"
  source_security_group_id = "${aws_security_group.demo_cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo_cluster_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.demo_cluster.id}"
  source_security_group_id = "${aws_security_group.demo_node.id}"
  to_port                  = 443
  type                     = "ingress"
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.demo.endpoint}' --b64-cluster-ca '${aws_eks_cluster.demo.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

module "worker_fleet" {
  source            = "./spot_fleet"
  fleet_size        = 2
  region            = "us-east-1"
  key_name          = "test"
  security_group_id = "${aws_security_group.demo_node.id}"
  env               = "test"
  vpc_id            = "${module.vpc.vpc_id}"
  userdata          = "${local.demo-node-userdata}"
  ami_id            = "${data.aws_ami.eks_worker.id}"
  service_name      = "${var.cluster_name}"
  subnet_ids        = ["${module.vpc.private_subnets}"]

  instance_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ]

  tags = "${
    map(
     "Name", "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.demo_node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

/* resource "aws_launch_configuration" "demo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.demo_node.name}"
  image_id                    = "${data.aws_ami.eks_worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = ["${aws_security_group.demo_node.id}"]
  user_data_base64            = "${base64encode(local.demo-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
} */

