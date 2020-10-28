sleep 60
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer
ps aux | grep /var/lib/dpkg/lock | awk {'print $2'} | sudo xargs kill -9
sudo lsof | grep /var/lib/dpkg/lock | awk {'print $2'} | sudo xargs kill -9
sudo lsof | grep /usr/bin/dpkg | awk {'print $2'} | sudo xargs kill -9
sudo rm -f /var/lib/dpkg/lock
ps aux | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9
ps aux | grep apt | awk {'print $2'} | xargs sudo kill -9
ps aux | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9
sudo lsof | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9
sudo rm -f /var/cache/apt/archives/lock
sudo dpkg — configure -a
sudo apt-get install -y software-properties-common unattended-upgrades
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get -y update
sudo apt-get -y install certbot python3-certbot-dns-route53
sudo service openvpnas stop
sudo certbot certonly --dns-route53 --non-interactive --agree-tos --email ${certificate_email} -d ${subdomain_name} --pre-hook 'service openvpnas stop' --post-hook 'service openvpnas start'
sudo ln -s -f /etc/letsencrypt/live/${subdomain_name}/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt
sudo ln -s -f /etc/letsencrypt/live/${subdomain_name}/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key
sudo ln -s -f /etc/letsencrypt/live/${subdomain_name}/chain.pem /usr/local/openvpn_as/etc/web-ssl/ca.crt
sudo service openvpnas start

SCRIPTS="/usr/local/openvpn_as/scripts/"
%{ if ${ldap_enabled} == true }
sudo $SCRIPTS/sacli --key "auth.module.type" --value "ldap" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.name" --value ${ldap_name} ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.server.0.host" --value ${ldap_server} ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.bind_dn" --value "${ldap_bind_dn}" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.bind_pw" --value '${ldap_password}' ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.users_base_dn" --value "${ldap_base_dn}" ConfigPut
sudo $SCRIPTS/sacli --key "auth.ldap.0.uname_attr" --value sAMAccountName ConfigPut
%{ if ${ldap_memberof_filter} != "" }
sudo $SCRIPTS/sacli --key "auth.ldap.0.add_req" --value "${ldap_memberof_filter}" ConfigPut
%{ endif }
%{ endif }
sudo $SCRIPTS/sacli --key vpn.client.tls_version_min --value 1.2 ConfigPut
sudo $SCRIPTS/sacli --key vpn.client.tls_version_min_strict --value true ConfigPut
sudo $SCRIPTS/sacli --key vpn.server.tls_version_min --value 1.2 ConfigPut
sudo $SCRIPTS/sacli --key cs.tls_version_min --value 1.2 ConfigPut
sudo $SCRIPTS/sacli --key cs.tls_version_min_strict --value true ConfigPut
sudo $SCRIPTS/sacli --key vpn.client.config_text --value 'cipher AES-256-CBC' ConfigPut
sudo $SCRIPTS/sacli --key vpn.server.config_text --value 'cipher AES-256-CBC' ConfigPut
sudo $SCRIPTS/sacli --key "cs.openssl_ciphersuites" --value 'EECDH+CHACHA20:EECDH+AES256:!EECDH+AES128:!RSA:!3DES:!MD5:!RC4' ConfigPut
!ECDHE-RSA-AES256-SHA:!ECDHE-RSA-AES256-SHA3
sudo $SCRIPTS/sacli -u ${openvpn_user} -k type -v user_connect UserPropPut
sudo $SCRIPTS/sacli -u ${openvpn_user} --new_pass '${openvpn_password}' SetLocalPassword
sudo service openvpnas stop
sudo service openvpnas start
