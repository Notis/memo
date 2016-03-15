cat -n cisco-mac-table.txt | sort |uniq |awk '{print $3 "\;" $5}' | sed 's/\.//g;s/Fa0\///
