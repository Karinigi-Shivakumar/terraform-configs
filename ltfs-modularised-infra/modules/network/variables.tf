variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "region" {
  description = "Region where the VPC and subnets will be created"
  type        = string
  default     = "asia-south1"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR range for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_name" {
  description = "Public subnet name"
  type        = string
  default     = "public-subnet"
}

variable "private_subnet_name" {
  description = "Private subnet name"
  type        = string
  default     = "private-subnet"
}

variable "nat_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = "nat-gateway"
}

