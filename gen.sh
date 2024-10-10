#!/bin/bash

echo "Your password generator"

echo "Please enter the desired password length"

read PASS_LENGTH

if ! [[ $PASS_LENGTH =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number."
    exit 1
fi

passwords=()

for p in $(seq 1 3);
do
    passwords+=("$(openssl rand -base64 48 | cut -c1-$PASS_LENGTH )")
done

echo "Here are the generated passwords:"
printf "%s\n" "${passwords[@]}"

echo "Do you want to save the passwords into file? (y/n)"
read choice
if [ "$choice" = "y" ]; then

        for password in "${passwords[@]}"; do
            echo "$password" | ccrypt -e -K "$PASSPHRASE" > "passwords.txt.cpt"
        done

    echo "Passwords saved securely to passwords.txt.cpt"
       
elif [ "$choice" = "n" ]; then
     echo "Passwords not saved."
fi