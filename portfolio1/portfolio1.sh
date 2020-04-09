#!/bin/bash

#Random number generator
function gen_rand ()
{
    #find difference or range (maximum - minumum), add 1 to difference
    range=$((($2-$1)+1));
    #generate random number and assing to var rand_num
    rand_num=$RANDOM;
    #mod rand_num with range and assing value to rand_num variable 
    let "rand_num %= $range";
    #add 1 to rand_num derived from above equation and assing value to rand_num var
    rand_num=$(($rand_num+$1));
}

#Display Game title 
echo -e "\n\n\n\t\t\t***********************************"
sleep 1s
echo -e "\t\t\t*************Guess Age*************"
sleep 1s
echo -e "\t\t\t***********************************"
#Display welsome note and instruction
echo -e "\t Welcome to Guess Age, In this game you are required to guess\n\t person age between 30 and 80,with each right guess you will earn 10 points\n\n"
#To quit user need to type quite
    echo -e "\t\t\t\t\t\t\t\t Type Quit to end\n\n\n\n\n"
#REgular expression to check if input is number
VarCheck='^[0-9]+$'
#variable to hold total points user secured
TotalPoint=0;
#start a unconditional while loop
while ( true ) do
#Taske user input
    read -p "Please guess age: " PlayerInput
    echo  -e "\n\n"
# Break loop and quit game if user type "Quit" OR "quit"
    if [ "$PlayerInput" = 'quit'  ] || [ "$PlayerInput" = 'Quit' ]; 
        then 
            break
    else
#Check againt defined regex variable "VarCheck" to see if user input is a number
        if ! [[ "$PlayerInput" =~ $VarCheck ]]; then
            echo -e "Please enter numbers only\n"
        else 
#if input is number, use RANDOM function to generate number between 30 and 80
            gen_rand 30 80
#if Player guess matches, echo following statement and add 10 to TotalPoint variable
            if [ "$PlayerInput" -eq "$rand_num" ]; then
                echo -e "Weldone, your guess is right. You earned 10 points\n"
                TotalPoint+=10
#sleep for 1 second
                sleep 1s
#If player guess is greater, echo following statement
            elif [ "$PlayerInput" -gt "$rand_num" ]; then 
                echo -e "Hmm thats not right, your guess is too high\n"
                sleep 1s
#If player guess is smaller, echo following statement
            elif [ "$PlayerInput" -lt "$rand_num" ]; then
                echo -e "Hmm thats not right, your guess is too low\n"
                sleep 1s
            fi
        fi
    fi
            
done
#display good bye message on screen
echo -e -n "\tGOOD"
sleep 1s
echo " BYE"
sleep 1s
#display final score on screen
echo -e "\t\t\t Total Score $TotalPoint"



