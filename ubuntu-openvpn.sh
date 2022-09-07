#!/bin/bash
clear;

# VARIABLES
EXTERNAL_IP=$(hostname  -I | cut -f1 -d' ');
echo -n "ENTER HOSTNAME [Example: ovpnserver]: "; read HOSTNAME;
echo -n "ENTER VPN LAN [Example: 10.10.10.0]: "; read VPN_LAN;
echo -n "ENTER VPN PORT [Example: 54321]: "; read VPN_PORT;
echo -n "ENTER COUNT VPN CLIENTS [Example: 5]: "; read CCOUNT;

# HOSTNAME
echo 127.0.0.1 localhost > /etc/hosts;
echo 127.0.0.1 $HOSTNAME >> /etc/hosts;
echo $HOSTNAME > /etc/hostname;

# OPENVPN setup
timedatectl set-timezone Europe/Moscow;
apt update -y;
sudo DEBIAN_FRONTEND=noninteractive apt install openssl easy-rsa openvpn -y;
make-cadir /etc/openvpn/easy-rsa;
mv /etc/openvpn/easy-rsa/vars /etc/openvpn/easy-rsa/vars.bak
cat << EOF > /etc/openvpn/easy-rsa/vars
set_var EASYRSA_REQ_COUNTRY "COUNTRY"
set_var EASYRSA_REQ_PROVINCE "PROVINCE"
set_var EASYRSA_REQ_CITY "CITY"
set_var EASYRSA_REQ_ORG "HOSTNAME"
set_var EASYRSA_REQ_EMAIL "HOSTNAME"
set_var EASYRSA_REQ_OU "HOSTNAME"
set_var EASYRSA_ALGO "ec"                      
set_var EASYRSA_DIGEST "sha512"
EOF
sed -i "s%HOSTNAME%$HOSTNAME%g" /etc/openvpn/easy-rsa/vars;
echo -n "ENTER COUNTRY CODE [Example: RU]: "; read COUNTRY_CODE; sed -i "s%COUNTRY%$COUNTRY_CODE%g" /etc/openvpn/easy-rsa/vars;
echo -n "ENTER COUNTRY NAME [Example: Moscow]: "; read COUNTRY_NAME; 
sed -i "s%PROVINCE%$COUNTRY_NAME%g" /etc/openvpn/easy-rsa/vars;
sed -i "s%CITY%$COUNTRY_NAME%g" /etc/openvpn/easy-rsa/vars;
cd /etc/openvpn/easy-rsa;
sudo /etc/openvpn/easy-rsa/easyrsa init-pki;
sudo /etc/openvpn/easy-rsa/easyrsa build-ca nopass;
sudo /etc/openvpn/easy-rsa/easyrsa gen-req $HOSTNAME nopass
sudo /etc/openvpn/easy-rsa/easyrsa gen-dh;
cd /etc/openvpn/easy-rsa && openvpn --genkey --secret ta.key;
mkdir /etc/openvpn/$HOSTNAME;
cp /etc/openvpn/easy-rsa/pki/private/$HOSTNAME.key  /etc/openvpn/$HOSTNAME/;
cp /etc/openvpn/easy-rsa/pki/private/ca.key  /etc/openvpn/$HOSTNAME/;
cp /etc/openvpn/easy-rsa/pki/dh.pem  /etc/openvpn/$HOSTNAME/;
cp /etc/openvpn/easy-rsa/ta.key  /etc/openvpn/$HOSTNAME/;
cp /etc/openvpn/easy-rsa/pki/reqs/$HOSTNAME.req /etc/openvpn/$HOSTNAME/;

sudo /etc/openvpn/easy-rsa/easyrsa import-req /etc/openvpn/$HOSTNAME/$HOSTNAME.req server;
sudo /etc/openvpn/easy-rsa/easyrsa sign-req server $HOSTNAME;
cp /etc/openvpn/easy-rsa/pki/issued/$HOSTNAME.crt /etc/openvpn/$HOSTNAME/;
cp /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/$HOSTNAME;

cat << EOF > /etc/openvpn/$HOSTNAME.conf
port VPN_PORT
proto udp
dev tun0
ca vpnserver-name/ca.crt #CHANGE
cert vpnserver-name/vpnserver-name.crt
key vpnserver-name/vpnserver-name.key
dh vpnserver-name/dh.pem
server VPN_LAN 255.255.255.0
ifconfig-pool-persist vpnserver-name/ipp.txt
tls-auth vpnserver-name/ta.key 0
cipher AES-256-CBC
auth SHA256
user nobody
group nogroup
status vpnserver-name/openvpn-status.log
log-append vpnserver-name/openvpn.log
verb 2
mute 20
max-clients 5
;tun-mtu 1500
;fragment 1400
;tun-mtu-extra 32
;mssfix
sndbuf 524288
rcvbuf 524288
txqueuelen 1000
fast-io
keepalive 10 120
tls-server
persist-key
persist-tun
float
chroot /etc/openvpn
push "sndbuf 524288"
push "rcvbuf 524288"
;push "route 10.0.XX.0 255.255.255.0"
;push "route 10.XX.XX.0 255.255.255.0"
push "dhcp-option DNS 8.8.8.8"
push "redirect-gateway def1 bypass-dhcp"
daemon
EOF
sed -i "s%VPN_PORT%$VPN_PORT%g" /etc/openvpn/$HOSTNAME.conf;
sed -i "s%vpnserver-name%$HOSTNAME%g" /etc/openvpn/$HOSTNAME.conf;
sed -i "s%VPN_LAN%$VPN_LAN%g" /etc/openvpn/$HOSTNAME.conf;

mkdir /etc/openvpn/tmp;
mv /etc/openvpn/client/ /etc/openvpn/clients;
cd /etc/openvpn/easy-rsa;

for i in {1..$CCOUNT};
do 
	sudo /etc/openvpn/easy-rsa/easyrsa gen-req client$i nopass; 
	sudo /etc/openvpn/easy-rsa/easyrsa sign-req client client$i;
done;

cp /etc/openvpn/easy-rsa/pki/private/client* /etc/openvpn/clients/;
cp /etc/openvpn/easy-rsa/pki/reqs/client* /etc/openvpn/clients/;
cp /etc/openvpn/easy-rsa/pki/issued/client* /etc/openvpn/clients/;
cp /etc/openvpn/$HOSTNAME/ta.key /etc/openvpn/clients/;
cp /etc/openvpn/$HOSTNAME/ca.crt /etc/openvpn/clients/;
cp /etc/openvpn/$HOSTNAME/dh.pem /etc/openvpn/clients/;

cd /etc/openvpn/clients/
cat << EOF >  /etc/openvpn/clients/client1.conf
;auth-user-pass
client
proto udp
dev tun
remote EXTERNAL_IP VPN_PORT
key-direction 1
cipher AES-128-CBC
auth SHA256
auth-nocache
;user nobody
;group nogroup
verb 2
mute 20
keepalive 10 120
persist-key
persist-tun
tun-mtu 1500
;fragment 1300
;tun-mtu-extra 32
mssfix
;log-append client1.log
float
resolv-retry infinite
;connect-retry 30
;ns-cert-type server
remote-cert-tls server
route-method exe
route-delay 5
nobind
EOF
sed -i "s%EXTERNAL_IP%$EXTERNAL_IP%g" /etc/openvpn/clients/client1.conf;
sed -i "s%VPN_PORT%$VPN_PORT%g" /etc/openvpn/clients/client1.conf;

for i in {1..10}; 
do mkdir client$i;
	sed s/client1/client$i/ < client1.conf > client$i/client$i.ovpn;
	echo "<ca>" >> client$i/client$i.ovpn;
	cat ca.crt >> client$i/client$i.ovpn;
	echo "</ca>" >> client$i/client$i.ovpn;
	echo "<cert>" >> client$i/client$i.ovpn;
	cat client$i.crt >> client$i/client$i.ovpn;
	echo "</cert>" >> client$i/client$i.ovpn;
	echo "<key>" >> client$i/client$i.ovpn;
	cat client$i.key >> client$i/client$i.ovpn;
	echo "</key>" >> client$i/client$i.ovpn;
	echo "<tls-auth>" >> client$i/client$i.ovpn;
	cat ta.key >> client$i/client$i.ovpn;
	echo "</tls-auth>" >> client$i/client$i.ovpn;
	echo "<dh>" >> client$i/client$i.ovpn;
	cat dh.pem >> client$i/client$i.ovpn;
	echo "</dh>" >> client$i/client$i.ovpn;
done;
rm /etc/openvpn/clients/*.crt;
rm /etc/openvpn/clients/*.key;
rm /etc/openvpn/clients/*.pem;
rm /etc/openvpn/clients/*.req;
echo "System reboot requered."
