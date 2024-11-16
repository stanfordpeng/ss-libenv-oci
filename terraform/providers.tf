
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "oci" {
   auth = "APIKey"
   region = var.region
   tenancy_ocid = "${var.tenancy_ocid}"
   user_ocid = "${var.user_ocid}"
   fingerprint = "${var.fingerprint}"
   private_key_path = "${var.private_key_path}"
}