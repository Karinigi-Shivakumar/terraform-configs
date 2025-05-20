variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-south1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
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
  description = "public subnet name"
  type        = string
  default     = "public-subnet"
}

variable "private_subnet_name" {
  description = "private subnet name"
  type        = string
  default     = "private-subnet"
}


variable "public_vm_name" {
  description = "Name of the public VM"
  type        = string
  default     = "public-vm"
}

variable "private_vm_name" {
  description = "Name of the private VM"
  type        = string
  default     = "private-vm"
}

variable "machine_type" {
  description = "Machine type for both VMs"
  type        = string
  default     = "e2-medium"
}

variable "nat_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = "nat-gateway"
}

variable "gcs_bucket_name" {
  type    = string
  default = "gcp-terraform-statefile-backup"
}
