
variable "image_id" {
  type = string
  default = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaam2u3tmydcym62uwotchxgxhdzkkswpir7hv77t2ihjbthswubuna"
}
# User-provided input variables
variable "vm_count" {
  type    = number
  default = 1
}

variable "region" {
  description = "region"
  type        = string
  default     = "ap-melbourne-1"
}
variable "availability_domain" {
  description = "availability_domain"
  type        = string
  default     = "umlC:AP-MELBOURNE-1-AD-1"
}
variable "compartment_id" {
  description = "compartment_id"
  type        = string
}
variable "subnet_id" {
  description = "The OCID of the subnet to create the VNIC in."
  type        = string
}
variable "ssh_public_key_path" {
  description = "ssh_public_key_path"
  type        = string
  default     = "~/.ssh/oracle.pub"
}
variable "bootstrap_script_path" {
  description = "bootstrap_script_path"
  type        = string
  default     = "./bootstrap.sh"
}
variable "tenancy_ocid" {
  type      = string
  sensitive = true
}

variable "user_ocid" {
  type      = string
  sensitive = true
}


variable "fingerprint" {
  type      = string
  sensitive = true
}

variable "private_key_path" {
  type      = string
  sensitive = true
}


