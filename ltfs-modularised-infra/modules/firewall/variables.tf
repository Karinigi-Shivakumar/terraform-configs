variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-south1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

