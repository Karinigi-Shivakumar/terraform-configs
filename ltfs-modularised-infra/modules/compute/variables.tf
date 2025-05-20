variable "project_id" {
  description = "GCP Project ID"
  type        = string
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

variable "vpc_id" {
  description = "VPC ID (Not used, subnets are used instead)"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}

variable "zone" {
  description = "Zone where the instances are deployed"
  type        = string
  default     = "asia-south1-a"
}

