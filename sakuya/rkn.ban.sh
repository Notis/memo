#!/bin/sh

/sbin/iptables -A INPUT -s 5.61.16.0/21 -j DROP
/sbin/iptables -A INPUT -s 5.61.232.0/21 -j DROP
/sbin/iptables -A INPUT -s 79.137.157.0/24 -j DROP
/sbin/iptables -A INPUT -s 79.137.174.0/23 -j DROP
/sbin/iptables -A INPUT -s 79.137.183.0/24 -j DROP
/sbin/iptables -A INPUT -s 94.100.176.0/20 -j DROP
/sbin/iptables -A INPUT -s 95.163.32.0/19 -j DROP
/sbin/iptables -A INPUT -s 95.163.212.0/22 -j DROP
/sbin/iptables -A INPUT -s 95.163.216.0/22 -j DROP
/sbin/iptables -A INPUT -s 95.163.248.0/21 -j DROP
/sbin/iptables -A INPUT -s 128.140.168.0/21 -j DROP
/sbin/iptables -A INPUT -s 178.22.88.0/21 -j DROP
/sbin/iptables -A INPUT -s 178.237.16.0/20 -j DROP
/sbin/iptables -A INPUT -s 178.237.29.0/24 -j DROP
/sbin/iptables -A INPUT -s 185.5.136.0/22 -j DROP
/sbin/iptables -A INPUT -s 185.16.148.0/22 -j DROP
/sbin/iptables -A INPUT -s 185.16.244.0/23 -j DROP
/sbin/iptables -A INPUT -s 185.16.246.0/24 -j DROP
/sbin/iptables -A INPUT -s 185.16.247.0/24 -j DROP
/sbin/iptables -A INPUT -s 188.93.56.0/21 -j DROP
/sbin/iptables -A INPUT -s 194.186.63.0/24 -j DROP
/sbin/iptables -A INPUT -s 195.211.20.0/22 -j DROP
/sbin/iptables -A INPUT -s 195.218.168.0/24 -j DROP
/sbin/iptables -A INPUT -s 217.20.144.0/20 -j DROP
/sbin/iptables -A INPUT -s 217.69.128.0/20 -j DROP

