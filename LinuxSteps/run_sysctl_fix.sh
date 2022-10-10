#!/bin/bash
# Run as sudo ./run_sysctl_fix.sh.

if [ "$EUID" -ne 0 ]
  then echo "Run as sudo. Exiting. sudo ./run_sysctl_fix.sh"
  exit
fi

# cat run_sysctl_fix.sh | awk -F '-w' {' print $2 '} | awk NF (save this to /etc/sysctl.conf)
echo Making a Copy of /etc/sysctl.conf in /tmp/systl.conf
cp /etc/sysctl.conf /tmp/sysctl.conf
###### Gavin List ######
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
# Ignore Broadcast ICMP Echo Requests			
sysctl -w net.ipv4.icmp_echo_ignore_all=1	
# Prevent Spoofing Attacks
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
# Do not accept IP source route packets (we are not a router)
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv4.conf.default.send_redirects=0 
sysctl -w net.ipv4.conf.all.send_redirects=0
# Turn on TCP SYN Cookie Protection
sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.tcp_synack_retries=2
# Accept ICMP redirects only for gateways listed in our default GW list
sysctl -w net.ipv4.conf.all.secure_redirects=0 				
sysctl -w net.ipv4.conf.default.secure_redirects=0
# Logging of Martian Packets Enabled
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1
# Do not accept ICMP Redirects
sysctl -w net.ipv4.conf.default.accept_redirects=0			
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sysctl -w net.ipv6.conf.ens33.disable_ipv6=1
sysctl -w net.ipv6.conf.all.accept_ra=0
sysctl -w net.ipv6.conf.default.accept_ra=0
sysctl -w net.ipv6.conf.all.accept_redirects=0 
sysctl -w net.ipv6.conf.default.accept_redirects=0
###### Gavin List ######
# Amanda Add-On
# Restrict Unprivileged Access to Kernel Syslog
sysctl -w kernel.dmesg_restrict=1
# Assassination 
sysctl -w net.ipv4.tcp_rfc1337=1
# Reload
sysctl -p