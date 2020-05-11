#!/bin/bash

# Flush old rules
#=========================================================
iptables -F

# Default action if no other rules match
#========================================================= 
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP


# Allow loopback traffic
#=========================================================
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j DROP

#Allow outbound connections originating on the local machine:
#=========================================================
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT


# Allow return traffic for outbound connections originating on the local machine:
#=========================================================
iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT


# Allow incoming connections [This is mostly what you edit]
#========================================================= 
# Ex: Open port for SSH:
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT


# Ex: Open port for DNS:
iptables -A INPUT -p udp --dport 53 -m state --state NEW -j ACCEPT