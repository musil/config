#
# LAB Kick start file
#
yum update -y
yum -y install wget mc bzip2 mailx git
yum -y install epel-release
yum -y install psmisc
yum -y  install yum-utils

echo "musil@sm-net.cz" > /root/.forward
chmod 644 /root/.forward 

mkdir -p /root/.ssh
chmod 700 /root/.ssh

cat << EOF >> /root/.ssh/authorized_keys
ssh-dss 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 SMU dsa-key-4096-20160106
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
search lab
nameserver 10.20.10.11
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
