#!/usr/bin/python


k=0
i=0
stroka=""
with open("abook.vcf") as f:
    for line in f:
        # Do something with 'line'
        if "EMAIL:" in line:
            l = line.replace("EMAIL:","").replace("\n","")

            if i < 30:
#                print(l)
                stroka = (stroka + l + ",")
                i=i+1
            else:    
                i=0
                print(stroka)
                print("---------------------------------------------------------------------------" , k)
                stroka=""
                k=k+1

            
            



