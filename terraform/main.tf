# Data source to fetch the Canonical Ubuntu 22.04 Minimal image
# data "oci_core_images" "ubuntu_image" {
#   compartment_id = var.compartment_id
#   operating_system = "Canonical Ubuntu"
#   operating_system_version = "22.04"
#   sort_by                 = "TIMECREATED"
#   sort_order              = "DESC"
# }

resource "random_password" "shadowsocks_password" {
  count = var.vm_count
  length           = 16
  special          = false
  upper            = true
  lower            = true
  numeric           = true
}

resource "oci_core_instance" "vm" {
  count = var.vm_count

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.E2.1.Micro"

  source_details {
    source_type          = "image"
    source_id            = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaam2u3tmydcym62uwotchxgxhdzkkswpir7hv77t2ihjbthswubuna"
    boot_volume_size_in_gbs = "50" # minimum boot volume size
  }

  create_vnic_details {
    subnet_id = var.subnet_id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data           = base64encode(templatefile(var.bootstrap_script_path, {
        shadowsocks_password = random_password.shadowsocks_password[count.index].result
    }))
  }
}