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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.54.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.54.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.openvpn_ip](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/eip) | resource |
| [aws_iam_instance_profile.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ssm_s3_access](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_policy) | resource |
| [aws_iam_role.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ssm_role_policy01](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_role_policy02](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_s3_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/instance) | resource |
| [aws_route53_record.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/route53_record) | resource |
| [aws_s3_bucket.ansible_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.ansible_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_object.openvpn_playbook](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/s3_object) | resource |
| [aws_security_group.openvpn_mgmt](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/security_group) | resource |
| [aws_security_group.openvpn_user](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/security_group) | resource |
| [aws_ssm_association.openvpnas](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_association) | resource |
| [aws_ssm_parameter.certificate_email](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_admin_password](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_admin_user](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_dns](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_add_req](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_base_dn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_bind_dn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_bind_pw](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_realm](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.openvpnas_ldap_server](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/ssm_parameter) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/3.6.2/docs/resources/id) | resource |
| [aws_ami.openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.iam_role](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.openvpn_ec2_assume](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_s3_access](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_creation"></a> [admin\_creation](#input\_admin\_creation) | Do you wish to create a local admin account | `bool` | `false` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | openvpnas local admin account password | `string` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | openvpnas local admin account name | `string` | `"admin"` | no |
| <a name="input_adminaccess_cidr"></a> [adminaccess\_cidr](#input\_adminaccess\_cidr) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The ID of the AMI to run otherwise will default to AWS AmazonLinux 2 | `string` | `""` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID number, needed for implementing IAM permissions | `string` | n/a | yes |
| <a name="input_certificate_email"></a> [certificate\_email](#input\_certificate\_email) | email address to link the letsencrypt SSL certificate | `string` | n/a | yes |
| <a name="input_clientaccess_cidr"></a> [clientaccess\_cidr](#input\_clientaccess\_cidr) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_configure_ldap"></a> [configure\_ldap](#input\_configure\_ldap) | Do you wish to enable LDAP configuration | `bool` | `false` | no |
| <a name="input_configure_letsencrypt"></a> [configure\_letsencrypt](#input\_configure\_letsencrypt) | Do you wish to enable Letsencrupt | `bool` | `false` | no |
| <a name="input_custom_suffix"></a> [custom\_suffix](#input\_custom\_suffix) | enter a suffix which will be tagged to all created objects, if not set a random one will be assigned | `string` | `null` | no |
| <a name="input_environment_tag"></a> [environment\_tag](#input\_environment\_tag) | Define the type of environment | `string` | `""` | no |
| <a name="input_instance_disk_encrypted"></a> [instance\_disk\_encrypted](#input\_instance\_disk\_encrypted) | Encrypt the EBS volumes | `bool` | `true` | no |
| <a name="input_instance_disk_type"></a> [instance\_disk\_type](#input\_instance\_disk\_type) | Data disk type defaults to "gp2" disk type | `string` | `"gp2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | default instance type of the openvpnas appliance. | `string` | `"t3a.large"` | no |
| <a name="input_ldap_add_req"></a> [ldap\_add\_req](#input\_ldap\_add\_req) | openvpnas ssh username for logging into the appliance | `string` | `"memberOf=CN=Dom VPN User,OU=Security Groups,DC=ad,DC=example,DC=org"` | no |
| <a name="input_ldap_base_dn"></a> [ldap\_base\_dn](#input\_ldap\_base\_dn) | openvpnas ssh username for logging into the appliance | `string` | `"OU=Regions,DC=ad,DC=example,DC=org"` | no |
| <a name="input_ldap_bind_dn"></a> [ldap\_bind\_dn](#input\_ldap\_bind\_dn) | openvpnas ssh username for logging into the appliance | `string` | `"CN=svc_openvpnas,OU=Service Accounts,DC=ad,DC=example,DC=org"` | no |
| <a name="input_ldap_bind_pw"></a> [ldap\_bind\_pw](#input\_ldap\_bind\_pw) | openvpnas ssh username for logging into the appliance | `string` | n/a | yes |
| <a name="input_ldap_realm"></a> [ldap\_realm](#input\_ldap\_realm) | openvpnas ssh username for logging into the appliance | `string` | `"EXAMPLE"` | no |
| <a name="input_ldap_server"></a> [ldap\_server](#input\_ldap\_server) | openvpnas ssh username for logging into the appliance | `string` | `"127.0.0.1"` | no |
| <a name="input_openvpnas_dns"></a> [openvpnas\_dns](#input\_openvpnas\_dns) | FQDN of the openvpnas appliance | `string` | n/a | yes |
| <a name="input_project_tag"></a> [project\_tag](#input\_project\_tag) | Project code name or name | `string` | `""` | no |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | Pubic subnet ID where you wish to deploy the openvpnas appliance | `string` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Route 53 Zone name | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 Bucket name where ansible scripts will be stored | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Keyname for EC2 instance | `string` | `""` | no |
| <a name="input_ssm_playbook_location"></a> [ssm\_playbook\_location](#input\_ssm\_playbook\_location) | Playbook directory location which is uploaded to S3 | `string` | `""` | no |
| <a name="input_subdomain_ttl"></a> [subdomain\_ttl](#input\_subdomain\_ttl) | Route 53 TTL time | `number` | `"60"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_openvpnas_eip"></a> [openvpnas\_eip](#output\_openvpnas\_eip) | n/a |
| <a name="output_openvpnas_mgmt_secgrpid"></a> [openvpnas\_mgmt\_secgrpid](#output\_openvpnas\_mgmt\_secgrpid) | n/a |
| <a name="output_openvpnas_user_secgrpid"></a> [openvpnas\_user\_secgrpid](#output\_openvpnas\_user\_secgrpid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
