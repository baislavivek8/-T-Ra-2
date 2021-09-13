#!/bin/bash
cd /root
set +e

echo "--- Installing Useful Packages ---"

#Installing useful packages
yum -y install joe tcpdump mtr zsh wget gdb perl vixie-cron logrotate
echo "--- Insure All Packages Are Up To Date  ---"
#yum -y update

echo "--- Setting Password Policies                                            ---"
echo "--- Per recommendations from http://wiki.centos.org/HowTos/OS_Protection ---"
echo "Passwords will expire every 180 days"
perl -npe 's/PASS_MAX_DAYS\s+99999/PASS_MAX_DAYS 180/' -i /etc/login.defs
echo "Passwords may only be changed once a day"
perl -npe 's/PASS_MIN_DAYS\s+0/PASS_MIN_DAYS 1/g' -i /etc/login.defs

echo "--- Setting Additional OS Policies/Securities                            ---"
echo "--- Per recommendations from http://wiki.centos.org/HowTos/OS_Protection ---"
# Now that we've restricted the login options for the server, lets kick off all the idle folks. To do this, we're going to use a bash variable in /etc/profile. There are some reasonably trivial ways around this of course, but it's all about layering the security.
echo "Idle users will be removed after 15 minutes"
echo "readonly TMOUT=900" >> /etc/profile.d/os-security.sh
echo "readonly HISTFILE" >> /etc/profile.d/os-security.sh
chmod +x /etc/profile.d/os-security.sh

# In some cases, administrators may want the root user or other trusted users to be able to run cronjobs or timed scripts with at. In order to lock these down, you will need to create a cron.deny and at.deny file inside /etc with the names of all blocked users. An easy way to do this is to parse /etc/passwd. The script below will do this for you.
echo "Locking down Cron"
touch /etc/cron.allow
chmod 600 /etc/cron.allow
awk -F: '{print $1}' /etc/passwd | grep -v root > /etc/cron.deny
echo "Locking down AT"
touch /etc/at.allow
chmod 600 /etc/at.allow
awk -F: '{print $1}' /etc/passwd | grep -v root > /etc/at.deny


echo "--- Installing LSM (Linux Socket Monitor) ---"
wget -O /usr/local/src/lsm-current.tar.gz http://www.rfxn.com/downloads/lsm-current.tar.gz
tar -C /usr/local/src/ -zxvf /usr/local/src/lsm-current.tar.gz
cd /usr/local/src/lsm-0.*
./install.sh
cd /root
rm -Rf /usr/local/src/lsm-*
sed -i 's/root/'$ADMINEMAIL/ /usr/local/lsm/conf.lsm
/usr/local/sbin/lsm -g


echo "--- Making changes to /etc/sysctl.conf ---"

echo 'net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_synack_retries = 2' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.rp_filter = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.rp_filter = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.secure_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.accept_source_route = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.send_redirects = 0' >> /etc/sysctl.conf

/sbin/sysctl net.ipv4.tcp_syncookies=1
/sbin/sysctl net.ipv4.tcp_synack_retries=2
/sbin/sysctl net.ipv4.conf.all.rp_filter=1
/sbin/sysctl net.ipv4.conf.default.rp_filter=1
/sbin/sysctl net.ipv4.conf.all.accept_redirects=0
/sbin/sysctl net.ipv4.conf.all.secure_redirects=0
/sbin/sysctl net.ipv4.conf.all.accept_source_route=0
/sbin/sysctl net.ipv4.conf.all.send_redirects=0
/sbin/sysctl net.ipv4.conf.default.send_redirects=0


echo "--- Securing the SSH Daemon ---"
echo "Backing up previous SSHd configurations"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo "adding user to server for sudoers permissions"
groupadd admin
groupadd dev
groupadd superadmin
groupadd dbTeam
#sudoers file appending 
echo "backing up sudoers file"
cp /etc/sudoers /etc/sudoers.bak
echo appending sudoers file 
/bin/cat << EOL >> /etc/sudoers
Cmnd_Alias CAMEROONSECURITY = ALL, !/bin/sudo su, !/bin/su, !/bin/su -, !/usr/bin/passwd root, !/sbin/halt, !/sbin/shutdown, !/sbin/poweroff, !/usr/sbin/visudo -f /etc/sudoers, !/usr/bin/vim /etc/sudoers, !/usr/bin/nano /etc/sudoers, !/usr/sbin/visudo -f sudoers, !/usr/bin/vim sudoers, !/usr/bin/nano sudoers, !/bin/bash, !/usr/sbin/usermod -aG wheel [a-zA-Z0-9]*, !/usr/sbin/usermod -G wheel [a-zA-Z0-9]*

Cmnd_Alias CAMEROONDBSECURITY = CAMEROONSECURITY, !/usr/sbin/useradd, !/usr/sbin/userdel, !/usr/sbin/groupadd, !/usr/sbin/groupdel, !/usr/sbin/usermod, !/usr/sbin/groupmod
%dbTeam ALL=(ALL) NOPASSWD: CAMEROONDBSECURITY
%admin ALL=(ALL)  NOPASSWD: CAMEROONSECURITY
%dev ALL=(ALL) NOPASSWD: CAMEROONDBSECURITY
%superadmin ALL=(ALL) ALL
EOL

/bin/cat << EOM > /etc/motd
############################################################################################################
############################################################################################################
##                                                                                                        ##
##                    ALERT! You are entering into a secured area!                                        ##
##     Your IP, Login Time, Username has been noted and has been sent to the server administrator!        ##
##    This service is restricted to authorized users only. All activities on this system are logged.      ##
##Unauthorized access will be fully investigated and reported to the appropriate law enforcement agencies ##
##                                                                                                        ##
##                                       Server Administrator                                             ##
##                                          Support Team                                                  ##                                          ############################################################################################################
############################################################################################################
EOM


systemctl restart sshd

##################################################################################################

if [ $(id -u) -eq 0 ]; then
        username=harshit
        password=harshit
        yum install perl -y
        rpm -qa perl
        if [ $? -eq 0 ]; then
                echo "perl exists!"
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m  -G superadmin  -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi
#######################################################################################################
if [ $(id -u) -eq 0 ]; then
        username=vivek
        password=vivek
        rpm -qa perl
        if [ $? -eq 0 ]; then
                echo "perl exists!"
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m  -G admin -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi
###########################################################################################################
if [ $(id -u) -eq 0 ]; then
        username=satya
        password=satya
        rpm -qa perl
        if [ $? -eq 0 ]; then
                echo "perl exists!"
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m  -G admin -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi
###########################################################################################################
if [ $(id -u) -eq 0 ]; then
        username=shubham
        password=shubham
        rpm -qa perl
        if [ $? -eq 0 ]; then
                echo "perl exists!"
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m  -G admin  -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi

############################## SSH service allow pass auth #######################################################
if [ $(id -u) -eq 0 ]; then
        username=shubham_t
        password=shubham_t
        rpm -qa perl
        if [ $? -eq 0 ]; then
                echo "perl exists!"
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m  -G wheel  -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi
##############################################################################################################
passwd --expire vivek
passwd --expire harshit
passwd --expire shubham
passwd --expire shubham_t
passwd --expire satya
#############################################################################################################
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "Banner /etc/motd" >> /etc/ssh/sshd_config

[ $? -eq 0 ] && echo "file has been appended" || echo "Failed to append!"
systemctl restart sshd
[ $? -eq 0 ] && echo "service has been started" || echo "service has been not started"

yum insatll java-1.8.0-openjdk-devel -y  
cd /tmp/
mkdir /data
wget https://package-repository-skilrock.s3.ap-south-1.amazonaws.com/jboss-4.2.2.GA.tar.gz
cp -p /tmp/jboss-4.2.2.GA.tar.gz  /data/
useradd -s /sbin/nologin jboss
cd /data/
tar -xzvf jboss-4.2.2.GA.tar.gz
chown -R jboss:jboss /data/jboss-4.2.2.GA
echo " " > /etc/systemd/system/jboss.service
/bin/cat << EOM > /etc/systemd/system/jboss.service
[Unit]
Description=Jboss Using No Login User

[Service]
User=jboss
ExecStart=/data/jboss-4.2.2.GA/bin/run.sh -b 0.0.0.0
ExecStop=/data/jboss-4.2.2.GA/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOM
chmod 755  /etc/systemd/system/jboss.service
systemctl daemon-reload
systemctl start jboss
systemctl enable jboss