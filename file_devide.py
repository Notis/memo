#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys

# Functions ======================================================

def readadress(infile, addrcount):
    k = 0
    i = 0
    stroka = ""
    try: 
        with open(infile) as f:
         for line in f:
             # Do something with 'line'
             if "EMAIL:" in line:
                 l = line.replace("EMAIL:","").replace("\n","")
              
                 if i < addrcount:
                     stroka = (stroka + l + ",")
                     i=i+1
                 else:    
                     i=0
                     stroka = stroka[:-1]
                     stroka = stroka + "\n--" + str(k) + "--\n"
                     k=k+1
        if stroka[-1] == ",":
            return(stroka[:-1])
    #       print ("y")
        else:
            return stroka
    except IOError: 
        print("Error: File does not appear to exist.")
    return 0 

#-------------------------------------------------------------------

# write file  ==============================================================

def writefile(outfile, data):
    with open(outfile, "w") as f:
        f.write(data + "\n")

    return 0

#-------------------------------------------------------------------
def help_print():
    head = "\nДля работы нужен адресный vcf файл с полем MAIL:\n\n"
    head = head + "\t file_devide.py имя_vcf_файла количество адресов_на_секцию имя_выходного_файла\n"
    head = head + "\t в случае отсуствия последних двух параметров деление идет по 30 адресов и выводится в stdout\n"
    return head
#-------------------------------------------------------------------

# count test  ======================================================
def ctest(arg):
    try:
        num = int(arg)
        err = "\n"
    except ValueError:
        err = "неверно введено количество адресов, установленно значение 30\n"
        num=30
    return err, num
 



#-------------------------------------------------------------------


# MAIN =============================================================

openfile=""
mailcount=30
outfile=""

# print(sys.argv)

if len(sys.argv) == 1:
        print (help_print() + "\n\nОтсутствует имя vcf файла.\n")
elif len(sys.argv) == 2:
    ss = readadress(sys.argv[1],30)
#    ss=sys.argv[1]
    print(ss)
elif len(sys.argv) == 3:
    err, mailcount = ctest(sys.argv[2])
    ss = readadress(sys.argv[1],mailcount)
    print(ss)
    if err != "\n":
        print(help_print() + err)
elif len(sys.argv) == 4:
    err, mailcount = ctest(sys.argv[2])
    ss = readadress(sys.argv[1],mailcount)
    if err != "\n":
         print(help_print() + err)
         print(ss)
    else:
         writefile(sys.argv[3],ss)
         print("\nФайл: ",sys.argv[3], " записан.")
else:
    print(help_print() + "\n\nERR!! Слишком много переменных.\n")

    



#===================================================================  
