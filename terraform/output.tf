output "instance_details" {
  sensitive = true
  value = [
    for index, instance in oci_core_instance.vm : {
      name      = instance.display_name
      public_ip = instance.public_ip
      password  = random_password.shadowsocks_password[index].result
      ss = join("",
        ["ss://",base64encode(
          join("",[
            "chacha20-ietf-poly1305:",
            random_password.shadowsocks_password[index].result
            ]
          )),
          "@",
          instance.public_ip,
      ":8388"]) # see https://shadowsocks.org/doc/sip002.html TODO paratermize cipher, port here
    }
  ]
}
