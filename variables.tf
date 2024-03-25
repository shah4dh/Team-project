variable "vpc_name" {
  description = "Name of the VPC to place cluster in"
  type        = string
  default     = "eks-vpc"
}

variable "cluster_name" {
  description = "Name you wish to give to your EKS cluster"
  type        = string
  default     = "the-cluster"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}