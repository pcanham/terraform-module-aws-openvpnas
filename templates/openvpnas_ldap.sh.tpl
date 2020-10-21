sudo service openvpnas start
SCRIPTS="/usr/local/openvpn_as/scripts/"
sudo $SCRIPTS/sacli --key "auth.module.type" --value "ldap" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.name" --value ${ldap_name} ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.server.0.host" --value ${ldap_server} ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.bind_dn" --value "${ldap_bind_dn}" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.bind_pw" --value '${ldap_password}' ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.users_base_dn" --value "${ldap_base_dn}" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.uname_attr" --value sAMAccountName ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.add_req" --value "${ldap_memberof_filter}" ConfigPut
sudo service openvpnas restart