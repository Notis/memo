#!/bin/bash
EXT_IP="10.24.1.36" # Он всё равно чаще всего один и тот же. внешний IP
INT_IP="192.168.0.109" # См. выше. внутренний IP шлюза
EXT_IF=eth1 # Внешний и внутренний интерфейсы.
INT_IF=eth0 # Для шлюза они вряд ли изменятся, поэтому можно прописать вручную.
LAN_IP=$1   # Локальный адрес сервера передаём скрипту первым параметром,
SRV_PORT=$2 # а тип сервера, в смысле какой порт (или набор портов) открывать - вторым
PORT_TYPE=$3

# Здесь желательно сделать проверку ввода данных, потому что операции достаточно серьёзные.
iptables -t nat -A PREROUTING --dst $EXT_IP -p $PORT_TYPE --dport $SRV_PORT -j DNAT --to-destination $LAN_IP
iptables -t nat -A POSTROUTING --dst $LAN_IP -p $PORT_TYPE --dport $SRV_PORT -j SNAT --to-source $INT_IP
iptables -t nat -A OUTPUT --dst $EXT_IP -p $PORT_TYPE --dport $SRV_PORT -j DNAT --to-destination $LAN_IP
iptables -I FORWARD 1 -i $EXT_IF -o $INT_IF -d $LAN_IP -p $PORT_TYPE -m $PORT_TYPE --dport $SRV_PORT -j ACCEPT

