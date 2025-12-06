#!/bin/bash
set -e

BASE_URL="https://raw.githubusercontent.com/DarenVejarano/Script-DNS/refs/heads/main"

apt update
apt install -y bind9 bind9utils bind9-dnsutils

wget -O /etc/bind/named.conf.options         $BASE_URL/named.conf.options
wget -O /etc/bind/named.conf.local           $BASE_URL/named.conf.local
wget -O /etc/bind/db.ufotable.cat            $BASE_URL/db.ufotable.cat
wget -O /etc/bind/db.estacions.ufotable.cat  $BASE_URL/db.estacions.ufotable.cat
wget -O /etc/bind/db.40.18.10.rev            $BASE_URL/db.40.18.10.rev

named-checkconf
named-checkzone ufotable.cat /etc/bind/db.ufotable.cat
named-checkzone estacions.ufotable.cat /etc/bind/db.estacions.ufotable.cat
named-checkzone 40.18.10.in-addr.arpa /etc/bind/db.40.18.10.rev

systemctl restart bind9
systemctl enable bind9

