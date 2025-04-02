## Why choose Oracle Cloud?
It provides 2 always free vm.

## Prerequisite
1. Create Oracle Cloud Infrastructure(OCI) account: https://docs.oracle.com/en/cloud/get-started/subscriptions-cloud/csgsg/get-oracle-com-account.html
2. Create a VCN and public subnet using VCN Creation Wizard or manually: https://docs.oracle.com/en-us/iaas/base-database/doc/vcn-and-subnets.html#DBSCB-GUID-569678E5-6B7F-4440-A437-771DB1DA5EC8
3. Edit the Security List of the subnet and open dest port 8388 with source ip to be 0.0.0.0/0

## Install tfenv to manage terraform version

refer to link [here](https://github.com/tfutils/tfenv)

I choose `brew install tfenv` as I use Macbook

## install terrform

- check the installable version:
    ```
    tfenv list-remote
    1.11.0-alpha20241106
    1.10.0-rc1
    1.10.0-beta1
    ```

- install a stable version: in my case  it is 1.10.0-rc1

    ``` 
    tfenv install 1.10.0-rc1 
    ```
- use it
  ```
  tfenv use 1.10.0-rc1 
  ```
## Choose Auth Way


I choose [API Key Authentication](https://docs.oracle.com/en-us/iaas/Content/terraform/configuring.htm#api-key-auth) so you can either export below vars(see more details from the doc link):

- TF_VAR_tenancy_ocid="<oci tenancy id: ocid1xxxxxxx>"
- TF_VAR_user_ocid="<oci user id: ocid1xxxxxxxx>"
- TF_VAR_private_key_path="<oci private key path: ./xxxx.pem>"
- TF_VAR_fingerprint="<oci finger print: 09:4e:2f:75:90:03xxxxxxxx>"
- TF_VAR_compartment_id="<oci compartment id>"
- TF_VAR_subnet_id="<oci subnet id >"

or fill in the variable values in [common.tfvars](https://github.com/stanfordpeng/ss-libenv-oci/blob/main/terraform/tfvars/common.tfvars)

## Apply the code

```
cd terraform
terraform init # if first time
terraform plan -out=tfplan --var-file=tfvars/common.tfvars # tfvars/common.tfvars contains senstive info therefore it is masked. can replace it with your local private tfvar file which is not git tracked.
terraform apply "tfplan"
terraform output instance_details
```
Please wait for 5-10 mins before proceeding:

Grab ss from the instance_details value via `terraform output` command and copy to ss clients such as outline(iOS) or input the related details to other clients.


## debug
check cloud init log and shadowsocks-libev status:
```
sudo cat /var/log/cloud-init.log

sudo cat /etc/iptables/rules.v4
sudo systemctl status shadowsocks-libev
```

check file `/var/lib/cloud/instance/scripts/part-001` is correctly executed inside the file
