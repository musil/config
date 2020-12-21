#/bin/bash
yum update -y
yum -y install wget mc bzip2 mailx git
yum -y install epel-release
yum -y install psmisc
yum -y  install yum-utils


mkdir -p /root/.ssh
chmod 700 /root/.ssh

cat << EOF >> /root/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpoRKNVYjObh13Y3on9WnKckYKuBNr+t/ZWf0LaV3oN SMU ed25519-key-20200423
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDi5nhmfg3CugLv4qnN0nhed2MaBp6efc6Gpkv8FpmGnSfln0RWfGU5wx895iMjis1we7keivP4p5e1o8uXr6/p6p9TYM7EU3GqLoRxHGK54XACi3k51FtqRR/Ut5u4Nls2S/k1Fi7N9+l39CvNusncfKtp+PeNebn89BHDWMBJf+7wnTVw+1s70wfA3ytlGjWZelzLP3VV/lZvP4WnHsFwsXuIMwRsrvDhc7kMg3gbaou8PMEkks7ms/rGB5VbIH4YPVqH7Hc7gLClOkEU+TATunAhqK/k8PazO/901Zb8sE34YGKbth9CU3WYghG2qjGWLEfsdOdKPdynmGRYjXlb ansible@dc5.cz
EOF



yum install -y open-vm-tools
systemctl enable vmtoolsd
systemctl start vmtoolsd
systemctl status vmtoolsd



yum install chrony -y
systemctl enable chronyd
mv -f /etc/chrony.conf /etc/chrony.conf.orig-smu
cat <<EOF> /etc/chrony.conf
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 192.168.99.10 iburst
server 10.20.10.10 iburst
server 10.2.5.10 iburst
# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift
# Allow the system clock to be stepped in the first three updates
# if its offset is larger than 1 second.
makestep 1.0 3
# Enable kernel synchronization of the real-time clock (RTC).
rtcsync
# Specify directory for log files.
logdir /var/log/chrony
EOF


systemctl start chronyd

timedatectl set-timezone Europe/Prague

chronyc ntpdata
systemctl restart chronyd
timedatectl
chronyc sources
chronyc makestep




mv -f /etc/resolv.conf /etc/resolv.conf.orig-smu
cat << EOF > /etc/resolv.conf
search lab int.dc5.cz
nameserver 10.20.10.11
nameserver 10.10.10.11
nameserver 192.168.99.11
nameserver 10.2.5.11
EOF
cat /etc/resolv.conf

cp -f /etc/rsyslog.conf /etc/rsyslog.orig-smu
cat << EOF >> /etc/rsyslog.conf
*.*       @10.20.55.44:514
EOF
service rsyslog restart


yum -y install http://10.20.10.44:5000/dc5monitor/check_mk/agents/check-mk-agent-1.5.0p21-1.noarch.rpm
systemctl enable check_mk.socket
systemctl restart check_mk.socket
firewall-cmd --add-port=6556/tcp --permanent
firewall-cmd --reload

yum install logrotate -y
cat << EOF > logrotate.conf
# see "man logrotate" for details
# rotate log files weeekly
weekly
# keep 4 weeks worth of backlogs
rotate 4
# create new (empty) log files after rotating old ones
create
# use date as a suffix of the rotated file
dateext
# uncomment this if you want your log files compressed
compress
# RPM packages drop log rotation information into this directory
include /etc/logrotate.d
# system-specific logs may be also be configured here.
EOF

logrotate /etc/logrotate.conf --force
