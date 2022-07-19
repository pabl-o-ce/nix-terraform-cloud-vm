# NixOS terraform cloud vm

## Variables of AWS
// working on
## Variables of Hetzner
// working on
## Variables of Linode
// working on

## Setup
Secrets variables use terraform.tfvars file:
```sh
touch ./terraform.tfvars
```
Add variable for AWS:
```sh
echo -e "access_key = \"<accessKey>\"
secret_key = \"<secretKey>\"
aws_region = \"<region>\"
ami_id = \"<amiId>\"
instance_type = \"<instanceType>\"" > ./terraform.tfvars
```
Add variable for Hetzner:
```sh
echo -e "hcloud_token = \"<hcloud_token>\"
location = \"<location>\"
image = \"<image>\"
server_type = \"<server_type>\"" > ./terraform.tfvars
```
Add variable for Linode:
```sh
```