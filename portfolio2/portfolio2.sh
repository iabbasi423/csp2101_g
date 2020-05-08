#!/bin/bash
#defne internal field seperator, colour variable,and text formating variable.
IFS=","
red='\033[31m'
green='\033[32m'
clear='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)
#On line 10-23 Run loop to keep asking user to enter source file, till one provided
while true 
do
    read -p "Enter file name: " filename
    #if file does not exist display error in red colour and bold text.
    if ! [ -f "$filename" ]; then
        echo -e "${red}${bold}ERROR: ${clear}${normal}File not found. Please make sure that correct file name/path is entered."
    #if file is empty, display error message in red colour and bold text format.
    elif ! [ -s "$filename" ];then
        echo -e "${red}${bold}ERROR: ${clear}${normal}Source file is empty"
    #if file exist and is has data in it, break the loop
    else
        break
    fi
done
#Line 28-55, ask user to enter a destination file name or press Enter to select default
#If file name provided check if file already contain data. ASk user if they want to overwrite.
#If user choose to overwrite, write data into that file. If user choose "NO" then ask another file
#repeat by asking file name.
#if user provide file is empty write data to it.
#if user press enter, create a file "trangle.txt" if not already existed and write data to it.
while true
do
    echo -n "Please enter destination file name OR press Enter to choose default: " 
    read user_choice 
    #if user provided a file name
    if [ "$user_choice" ]; then
    #if file exist and has data 
        if [[ -f "$user_choice" ]] && [[ -e "$user_choice" ]]; then
        #display warning msg and ask if user want to overwrite by typing y or n.
            echo -e -n "${red}${bold}Warning!: ${normal}${clear}File contains data, do you want to overwrite it? Y/N: "
            read user_selection 
            #if user say yes overwrite file
            if [[ "$user_selection" == "Y" ]] || [[ "$user_selection" == "y" ]]; then
                dest_file=$user_choice 
                break
                #if user say no or enter invalid option repeat by asking name again
            elif [[ "$user_selection" == "N" ]] || [[ "$user_selection" == "n" ]]; then
                continue
            else
                echo "Invalid choice!"
                continue
            fi
            #if file does not exist or is empty, create file/write data to it.
        else
            dest_file=$user_choice 
            break
        fi
        #if user press enter eithout providing name, use default file name
    elif ! [ "$user_choice" ]; then
        dest_file="trangle.txt"
        break

    fi
done
    #dislay msg that tells users its being processed, wait 1 sec
    echo -e "${green}${bold}processing......${clear}"
    sleep 1
#at line 68-73, read first line and assing each entry seperated by coma to variable var1-var6
    counter=1
    while [ "$counter" -le 1 ] 
    do
        read var1 var2 var3 var4 var5 
        ((counter++))
    done < $filename
#delete first line 
#line 77-82 replace each coma with Var1-var6 respectivly on each line.
#line 83, wite data to destination file.
#line 84 desplay completion message.
sed -e '1d'\
    -e 's/^/'$var1': /'\
    -e 's/,/\t'$var2': /'\
    -e 's/,/\t'$var3': /'\
    -e 's/,/\t'$var4': /'\
    -e 's/,/\t'$var5': /'\
    -e 's/,/\t'$var6': /' $filename > $dest_file
echo -e "${green}${bold}Process complete...${clear}\nData written to `pwd`/$dest_file"