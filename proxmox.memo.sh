
#AUTHORIZE and get cookie and CSRF token
n=0 #clear file indexer
curl -k -d "username=root@pam&password=PAROLE" https://192.168.0.169:8006/api2/json/access/ticket | jq --raw-output '.data.ticket, .data.CSRFPreventionToken' | while read line ; do ((n++)) ; echo $line > $n.tmp ; done
# get info with only token
COOKIE="PVEAuthCookie=`cat 1.tmp`"; curl -k -b "$COOKIE" https://192.168.0.169:8006/api2/json

COOKIE="PVEAuthCookie=`cat 1.tmp`"; ; curl -k -b "$COOKIE" https://192.168.0.169:8006/api2/json

COOKIE="PVEAuthCookie=`cat 1.tmp`"; CSRF="CSRFPreventionToken: `cat 2.tmp`"; curl -k -b "$COOKIE" -H "$CSRF" -H "Content-Type: application/json"  -d '{userid:admin@pam}' https://192.168.0.169:8006/api2/json/access/users  | jq

#get centos image name
sudo pveam available --section system | grep 'centos-7' | awk '{ print $2 }'

# download centos image to local storage
sudo pveam download local $(sudo pveam available --section system | grep 'centos-7' | awk '{ print $2 }')
 


``` /etc/network/interfaces.new
+auto vmbr0
+iface vmbr0 inet static
+	address  192.168.0.170
+	netmask  24
+	gateway  192.168.0.1
+	bridge-ports none
+	bridge-stp off
+	bridge-fd 0
+#KAKAXA-bridge
```
