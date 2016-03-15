tail -n +2 /tmp/list.xml | grep ru | sed 's/{//;s/}//;s/"//g;s/ru,[0-9]*//g; /^\s*$/d ' | tail -n +11
