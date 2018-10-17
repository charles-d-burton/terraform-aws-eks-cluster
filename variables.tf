variable "cluster_name" {
  type        = "string"
  default     = "eks-test"
  description = "name the test cluster"
}

variable "local_ip" {
  type        = "string"
  description = "your IP address, should replace with VPN soonish"
  default     = "206.196.145.163/32"
}
