# UCF Hivestorm Linux Battle File
<pre>
<b style="color: red">DO NOT SHARE outside of UCF.</b>
Credits: Amanda, Gavin, Ravy, and Martin.
Want to add on? - Message Amanda in Discord.
Goals: Find more Easter Eggs to collect. What do we NOT have?
Sourque '21: https://sourque.com/ctf/hivestorm/hs21/
Sourque '20: https://sourque.com/ctf/hivestorm/hs20/
</pre>

# Forensic Questions
<pre>
sudo grep -irl ".m4b" /home   (i=case-insensitive, r=recursive, l=by file)
cd /home; ls *
sudo find . -name AesopsFables64kbps_librivox.m4b
sudo find /home -name *.jpg

Take a Screenshot of the Forensic Questions After. In case you need to reset the box. 
</pre>

# Backups
<pre>
mkdir /backups
tar -czf "/backups/etc-$(date).tar.gz" /etc
tar -czf "/backups/var-www-$(date).tar.gz" /var/www
</pre>

# APT/APT-GET Section
<pre>
1. APT has been updated | Samba has been updated | Firefox has been updated
Update software for points. sudo apt-get install firefox --only-upgrade

<b>1. Update /etc/apt/sources.list first.</b>
2. Then sudo apt-get update && sudo apt-get upgrade.
Be careful of sudo apt-get upgrade. Execute it at the beginning so you can revert the box if needed. After the forensic questions.

Fix /etc/apt/sources.list  (Look at /etc/apt/sources.list/d for malicious entries too.)
https://mirrors.ustc.edu.cn/repogen/ <- Check this out.
deb http://security.ubuntu.com/ubuntu/ trusty-security universe main multiverse restricted
deb http://security.ubuntu.com/ubuntu xenial-security main restricted
deb-src http://security.ubuntu.com/ubuntu xenial-security universe
deb-src http://security.ubuntu.com/ubuntu xenial-security multiverse

3. Automatically check for updates daily
ratchet@ubuntu:/etc/apt/apt.conf.d$ cat 10periodic 
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "1";
APT::Periodic::Unattended-Upgrade "1";
</pre>

# Remove Unnecessary Programs and Files Section
<pre>
1. Remove Unnecessary Programs
Use the programs.txt and find_prohibited_programs.sh to search for programs.
<b>find_prohibited_programs.sh</b> <a href="https://drive.google.com/file/d/14cZ5CVcRFsHtULIjdO1brtoDCLI9KgbO/view?usp=sharing">Google Drive find_prohibited_programs.sh</a>
<b>programs.txt</b> <a href="https://drive.google.com/file/d/1ZzSGHCvpv07SPIxOHFMPXL54_luw-fC5/view?usp=sharing">Google Drive programs.txt</a>
Maybe don't use purge if you need to bring it back from the dead.  
sudo apt-get remove samba
sudo purge samba

2. Remove Unnecessary Files (not business related)
<b>find_prohibited_files.sh</b> <a href="https://drive.google.com/file/d/1fUNjlsy7HT9_6fpFfTK4Hc0XNCsxtDUa/view?usp=sharing">Google Drive find_prohibited_files.sh</a>
</pre>

# PAM Password Policy Section /etc/pam.d
<pre>
1. Create Password Policy
View Password Policy doc: https://docs.google.com/document/d/1yAiBuiQqYci0FTy1iklKNm4F9RZxtpT4/edit

2. Disallow Null Password Authentication 
https://www.cyberciti.biz/tips/linux-or-unix-disable-null-passwords.html

common-auth | common-password 
sudo grep -nr "nullok" /etc/pam.d/ 2>/dev/null
pam_unix.so nullok obscure min=4 max=8 sha512 (change this if its md5, ty Gavin)
Remove nullok.
</pre>

# Firewall Section
<pre>
1. Enable UFW Firewall Protection
Set IPv6 to no in /etc/default/ufw 
Set ICMP to DROP in /etc/ufw/before.rules
sudo systemctl start ufw
sudo ufw reset
sudo ufw logging high
sudo ufw default deny incoming
sudo ufw default deny outgoing 
sudo ufw allow out 53
sudo ufw allow out http
sudo ufw allow out https
sudo ufw allow 22 (NOTE: Whatever the required service is, change this)
sudo ufw enable
</pre>

<b><u>Scorebot is on port OUT HTTPS 443.</u></b>

# User Section
<pre>
1. Change root password
sudo passwd root

2. Lock root Account
passwd -l root
chage -E0 root

3. Make sure the UID and GID of 0 exist for only root
id 0
cat /etc/passwd | grep 0:0

4. Remove Unauthorized Users from sudo group
cat /etc/group | grep sudo 
sudo gpasswd -d qwark sudo
sudo gpasswd -d tapogee sudo

5. Add Authorized Users to sudo group if missing
cat /etc/group | grep sudo 
sudo usermod -aG sudo cynthia

6. Delete Users who are not in the README.md
deluser evilhacker

7. Delete Hidden Users (/home/evilhacker)
rm -R /home/evilhacker 
deluser evilhacker

8. Add Users who are in the README.md but NOT in /etc/passwd
adduser cynthia

9. Update User Passwords
sudo passwd qwark (manual). Script Process below.
</pre>
<pre>
#!/bin/bash
# Gavin Script
myuser="admin" #put the name of the admin user here
touch txt.txt; getent passwd {1000..60000} | cut -d: -f1 > txt.txt

#get all users but the myuser
systemUsersTrimmed=$(grep -vw "$myuser" txt.txt)
readarray -t systemUsersTrimmedArr <<<"$systemUsersTrimmed"

#set all the user passwords
for user in "${systemUsersTrimmedArr[@]}"; do
    echo "$user":"Sup3r5tr0ngP@55W0rd" | chpasswd
    chage -M 60 -m 10 -W 7 "$user"
done
</pre>
<pre>
10. Disable Shell Login for Users who shouldn't have bash (Example: irc, mail, news)
cat /etc/passwd | grep -i "/bin/bash" AND "/bin/sh" AND "/bin/zsh" etc
Change to /usr/sbin/nologin using vim /etc/passwd
</pre>

# SYSCTL Section /etc/sysctl.conf 
<pre>
<b>run_sysctl_fix.sh </b><a href="https://drive.google.com/file/d/154KZTFizXUALVu2WztxUlDo2iS-AyqZD/view?usp=sharing">Google Drive run_sysctl_fix.sh</a>
Execute this file. After run: cat run_sysctl_fix.sh | awk -F '-w' {' print $2 '} | awk NF
Save input to /etc/sysctl.conf.
</pre>
# LIGHTDM Section /etc/lightdm/lightdm.conf
<pre>
1. Disable Enumeration of System Users.
2. Disable guest account.

echo "
autologin-guest=false
autologin-user=NONE
allow-guest = false
greeter-hide-users=true
greeter-allow-guest=false
greeter-show-manual-login=true
xserver-allow-tcp=false" >> /etc/lightdm/lightdm.conf
</pre>

# LOGIN.DEFS Section /etc/login.defs
<pre>
1. Fix /etc/login.defs

PASS_MAX_DAYS	60
PASS_MIN_DAYS	10
PASS_WARN_AGE	7
ENCRYPT_METHOD  SHA512
LOGIN_RETRIES   3
LOG_OK_LOGINS   yes
</pre>

# File Permission Section
<pre>
Gavin List of chmods to do for system files:
#!/bin/bash
chmod -R 755 /etc/ssh
chmod -R 755 /etc/pam.d
chmod -R 755 /var/log
chmod -R 755 /etc/xinetd.d
chmod 400 /etc/cron.allow
chmod 000 /etc/shadow
chmod 400 /etc/shutdown.allow
chmod 400 /etc/cron.deny
chmod 600 /boot/grub/menu.lst
chmod 600 /etc/securetty
chmod 600 /etc/proftpd/ssl/proftpd.*
chmod 644 /etc/crontab
chmod 644 /etc/hosts.allow
chmod 644 /etc/hosts.deny
chmod 644 /etc/logrotate.conf
chmod 644 /etc/passwd
chmod 644 /etc/sysctl.conf
chmod 644 /etc/syslog.conf
chmod 644 /etc/udev/udev.conf
chmod 644 /etc/xinetd.conf
chmod 644 /var/log/lastlog
chmod 644 /var/log/messages
chmod 644 /var/log/wtmp
chmod 644 /etc/group
chmod 755 /etc/rc.d
chmod 755 /etc/security
chmod 755 /etc/sysconfig
</pre>
# SUID Files Section
<pre>
1. find / -perm -4000 2>/dev/null
https://github.com/Anon-Exploiter/SUID3NUM (favorite script)
chmod 00775 path
chmdo a-st path
</pre>
# Bad Actors Section
<pre>
1. w | ss -plunt | netstat -ln | lsof -i :80
See anyone? kill -9. | pkill -9 -t pts/3

2. Run linpeas.sh. Checks for priv-esc vulns. (thanks Ravy)
<b>LinPEAS:</b> <a href="https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS">linPEAS</a>

3. Check Crontab for Backdoors
/etc/crontab
/etc/cron.daily/cracklib-runtime
crontab -l
crontab -e
/var/spool/cron/crontabs
rm /var/spool/cron/crontabs/* (if not needed)
Delete any suspicious entries

4. Miscellaneous Files
/etc/rc.local
ls -lah in ~ home directory Check the .profile, .bashrc, .bash_logout, etc.
history - may show something interesting
grep -Ril "nc -l" / 2>/dev/null
grep -Ril "authorized_keys" /home 2>/dev/null (Are these your keys)

5. Run pspy32 in the background.
https://github.com/DominicBreuker/pspy/blob/master/README.md 
See if any suspicious activity happens. It will tell you the PID. 
Pretty nice, keeps out junk.
</pre>

# Stopping Services
<pre>
sudo service --status-all
service ssh stop
sudo service ssh status
service ssh start

systemctl list-units --type=service
systemctl list-units --type=service --state=active
systemctl status cups.service
sudo systemctl status cups.service
sudo systemctl stop cups.service
sudo systemctl start cups.service
</pre>

# SSH Hardening
<pre>
1. Secure SSH /etc/ssh.d/sshd_config
Protocol 2
PermitRootLogin = no
PubkeyAuthentication = no (if not using it, you can yes or no)
PermitEmptyPasswords = no
UsePAM = yes
UseDNS = no
AllowTcpForwarding no
Banner /etc/issue.net
X11Forwarding no
ForceCommand = Don't need this. Can be malicious. Delete.
Notes:https://man.openbsd.org/sshd_config
Reload Service after Changes: sudo service ssh restart
</pre>

# PostgreSQL Hardening
<pre>
<b>Basic Commands:</b>
sudo -u postgres psql || sudo -i -u postgres
psql
\l (List Databases)
\s (Command History)
\u (List Users)
\c template1 (Switch to DB)
\dt (List tables)
SELECT * FROM table_name;
\q
</pre>
<pre>
<b>/etc/postgresql/postgresql.conf</b>
ssl = true                                          
password_encryption = on

<b>/etc/postgresql/pg_hba.conf</b>
# Database administrative login by Unix domain socket
local   all             postgres                                peer

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
#host    all             all             ::1/128                md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5

- Change md5 to scram-sha-256 (if possible)
- Make sure to allow only 127.0.0.1/32
- Comment out IPv6 line
- Reload Service After Changes: sudo service postgresql restart
</pre>

# Samba Hardening
<pre>
sudo pdbedit -L -v
usershare allow guests = no
<a href="https://github.com/fcaviggia/hardening-script-el6/blob/master/config/smb.conf">https://github.com/fcaviggia/hardening-script-el6/blob/master/config/smb.conf</a>
Don't know alot about this. Config located in /etc/smb.conf

(Points last year for Samba)
Samba SMB1 protocol is disabled
Samba encryption is required
</pre>

# Web Hardening
<pre>
Run line 19-90 Martin Script. Run for Apache, PHP, config. 
</pre>

# Firefox Settings
<pre>
Settings -> Privacy and Security -> 
<b>Login and Passwords:</b>
- Ask to save logins and passwords for websites: Unchecked
- Show alerts about passwords for breached websites: Checked
<b>Permissions:</b>
- Block Pop-up windows: Checked
- Warn you when websites try to install add-ons: Checked
<b>Security:</b>
- Block Dangerous and deceptive content: Checked
- Block Dangerous Downloads: Checked
<b>Cookies and Site Data</b>
- Delete cookies and site data when Firefox is closed: Checked
</pre>

# Antivirus
<pre>
sudo apt-get install clamav
sudo freshclam
sudo clamscan
</pre>


# Sudo /etc/sudoers (/etc/sudoers Visudo)
<code>
1. Insecure permissions on Shadow File
sudo cat /etc/sudoers
sudo visudo 

##SUDO:
Line structure: `[user/group] [Hosts]=([allowed users]:[allowed groups]) [All commands]`
use % when defining groups

eg: 
`root ALL=(ALL:ALL) ALL`
`%sudo ALL=(ALL:ALL) ALL`

`NOPASSWD` allows the specified user or group to run as any user or group WITHOUT password auth.

eg:
`%haxors ALL=(NOPASSWD:ALL) ALL`

allows everyone in the haxors group to run any command as any user without password auth.


`NOEXEC` prevents commands from exectuting other commands:
eg:

`[username]	ALL = NOEXEC: /usr/bin/less`

prevents the specified user from running commands in less using `!command` (could be dangerous)

