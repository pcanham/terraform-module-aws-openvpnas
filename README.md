## Util
Applications used within this repo to help with CHANGELOG creation and also checking files within the repo

- [git-chglog](https://github.com/git-chglog/git-chglog)
- [semtag](https://github.com/pnikosis/semtag)
- [pre-commit](https://pre-commit.com/)

### pre-commit
Additional applications will need to be installed to your machine if you wish to use pre-commit they are;
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/tfsec/tfsec)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [ansible-lint](https://ansible-lint.readthedocs.io/en/latest/)

## Notes
- OpenVPN does not support the use of AWS SSM, this is why we have moved away from the appliance and installing it to our own EC2 instance so we have more flexibility on our deployment options.

## Terraform Inputs and Outputs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_creation | Do you wish to create a local admin account | `bool` | `false` | no |
| admin\_password | openvpnas local admin account password | `string` | n/a | yes |
| admin\_user | openvpnas local admin account name | `string` | n/a | yes |
| adminaccess\_cidr | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| ami\_id | The ID of the AMI to run otherwise will default to AWS AmazonLinux 2 | `string` | `""` | no |
| aws\_account\_id | AWS Account ID number, needed for implementing IAM permissions | `any` | n/a | yes |
| certificate\_email | email address to link the letsencrypt SSL certificate | `any` | n/a | yes |
| clientaccess\_cidr | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| configure\_ldap | Do you wish to enable LDAP configuration | `bool` | `false` | no |
| configure\_letsencrypt | Do you wish to enable Letsencrupt | `bool` | `false` | no |
| environment\_tag | Define the type of environment | `string` | `""` | no |
| instance\_type | default instance type of the openvpnas appliance. | `string` | `"t3.large"` | no |
| ldap\_add\_req | openvpnas ssh username for logging into the appliance | `string` | `"memberOf=CN=Dom VPN User,OU=Security Groups,DC=ad,DC=example,DC=org"` | no |
| ldap\_base\_dn | openvpnas ssh username for logging into the appliance | `string` | `"OU=Regions,DC=ad,DC=example,DC=org"` | no |
| ldap\_bind\_dn | openvpnas ssh username for logging into the appliance | `string` | `"CN=svc_openvpnas,OU=Service Accounts,DC=ad,DC=example,DC=org"` | no |
| ldap\_bind\_pw | openvpnas ssh username for logging into the appliance | `any` | n/a | yes |
| ldap\_realm | openvpnas ssh username for logging into the appliance | `string` | `"EXAMPLE"` | no |
| ldap\_server | openvpnas ssh username for logging into the appliance | `string` | `"127.0.0.1"` | no |
| openvpnas\_dns | FQDN of the openvpnas appliance | `any` | n/a | yes |
| project\_tag | Project code name or name | `string` | `""` | no |
| public\_subnet\_id | Pubic subnet ID where you wish to deploy the openvpnas appliance | `any` | n/a | yes |
| route53\_zone\_name | Route 53 Zone name | `any` | n/a | yes |
| s3\_bucket\_name | S3 Bucket name where ansible scripts will be stored | `any` | n/a | yes |
| ssh\_key | SSH Keyname for EC2 instance | `string` | `""` | no |
| ssh\_port | n/a | `number` | `22` | no |
| ssm\_playbook\_location | Playbook directory location which is uploaded to S3 | `string` | `""` | no |
| subdomain\_ttl | Route 53 TTL time | `string` | `"60"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| vpc\_id | AWS VPC ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| openvpnas\_eip | n/a |
| openvpnas\_mgmt\_secgrpid | n/a |
| openvpnas\_user\_secgrpid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
