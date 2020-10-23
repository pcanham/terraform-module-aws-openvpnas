# Apply our DSC via SSM
resource "aws_ssm_association" "openvpnas" {
  name             = "Unknown Method, ansible or shell script"
  association_name = "openvpnas"

  targets {
    key    = "InstanceIds"
    values = [aws_instance.openvpn[0].id]
  }



}
