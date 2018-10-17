terraform {
  backend "s3" {
    bucket         = "rs-terraform-state"
    key            = "us-east-1/test/eks"
    region         = "us-east-1"
    dynamodb_table = "rs-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

# Declare the data source
data "aws_availability_zones" "available" {}

#Get latest ami for workers
data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "aws_iam_policy_document" "master_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "worker_node_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
