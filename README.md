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

## Choose Auth Way


I choose [API Key Authentication](https://docs.oracle.com/en-us/iaas/Content/terraform/configuring.htm#api-key-auth) so I will export below vars(see more details from the doc link):

export is not needed and instead tfvars are provided otherwise it will keep giving error:
```
│ Error: Can't set variable when applying a saved plan
│ 
│ The variable fingerprint cannot be set using the -var and -var-file options when applying a saved plan file, because it is neither ephemeral nor has it been declared during the plan
│ operation. To declare an ephemeral variable which is not saved in the plan file, use ephemeral = true.
╵
╷
│ Error: Can't set variable when applying a saved plan
│ 
│ The variable private_key_path cannot be set using the -var and -var-file options when applying a saved plan file, because it is neither ephemeral nor has it been declared during the
│ plan operation. To declare an ephemeral variable which is not saved in the plan file, use ephemeral = true.
╵
╷
│ Error: Can't set variable when applying a saved plan
│ 
│ The variable user_ocid cannot be set using the -var and -var-file options when applying a saved plan file, because it is neither ephemeral nor has it been declared during the plan
│ operation. To declare an ephemeral variable which is not saved in the plan file, use ephemeral = true.
╵
╷
│ Error: Can't set variable when applying a saved plan
│ 
│ The variable tenancy_ocid cannot be set using the -var and -var-file options when applying a saved plan file, because it is neither ephemeral nor has it been declared during the plan
│ operation. To declare an ephemeral variable which is not saved in the plan file, use ephemeral = true.
```
``` # unset when using TF_VAR_* and running apply otherwise it will error
export TF_VAR_tenancy_ocid=xxx
export TF_VAR_user_ocid=xxx
export TF_VAR_private_key_path=xxx
```


## Apply the code

```
cd terraform

terraform plan -out=tfplan --var-file=tfvars/common.tfvars # tfvars/common.tfvars contains senstive info therefore it is masked. can replace it with your local private tfvar file which is not git tracked.
terraform apply "tfplan"
terraform output instance_details
```
Please wait for 5-10 mins before proceeding:

Grab ss from the instance_details value and copy to ss clients such as outline(iOS) or input the related details to other clients.


## debug
check cloud init log and shadowsocks-libev status:
```
sudo cat /var/log/cloud-init.log

sudo cat /etc/iptables/rules.v4
sudo systemctl status shadowsocks-libev
```

check file /var/lib/cloud/instance/scripts/part-001 is correctly executed inside the file