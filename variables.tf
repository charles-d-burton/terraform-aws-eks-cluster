variable "cluster_name" {
  type        = "string"
  default     = "eks-test"
  description = "name the test cluster"
}

variable "fleet_size" {
  type        = "string"
  description = "Number of worker nodes to create"
  default     = "2"
}

variable "key_name" {
  type        = "string"
  description = "Name of the ssh key to assign to worker nodes"
  default     = "test"
}

variable "local_ip" {
  type        = "string"
  description = "your IP address, should replace with VPN soonish"
  default     = "206.196.145.163/32"
}

variable "private_subnets" {
  type        = "list"
  description = "List of subnet cidr blocks"
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "public_subnets" {
  type        = "list"
  description = "List of subnet cidr blocks"
  default     = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
}

variable "region" {
  type        = "string"
  description = "self-explanatory"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = "string"
  description = "CIDR Block for whole VPC"
  default     = "10.10.0.0/16"
}
