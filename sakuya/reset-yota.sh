#!/bin/bash
## 15a9:002d
d1=`lsusb | grep "15a9:002d" | awk '{print $2}'`
d2=`lsusb | grep "15a9:002d" | awk '{print $4}' | sed 's/:/\ /g'`
/bin/ping -c 1 8.8.8.8 || /bin/ping -c 1 8.8.4.4 || /usr/local/sbin/usbreset /dev/bus/usb/$d1/$d2
