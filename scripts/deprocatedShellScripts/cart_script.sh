#!/bin/bash
###############################################################
# This script will compile the needed chrome cart data into csv
# files for the MG Campus
###############################################################
# 20200707 Hartgraves
# - Initial roll out of script
# 20200716 Hartgraves
# - Updated awk call to adjust for import requirements
# 20200716 Hartgraves
# - Updated directory and file structures
###############################################################
# Note this script requires files from GAM that are not provided
# in the repository
###############################################################
while true; do
	read -p "Please enter the building wanted (ES, MS, HS, OMTC, ALC): " Building
	if ([ "$Building" == "ES" ] || [ "$Building" == "MS" ] || [ "$Building" == "HS" ] || [ "$Building" == "OMTC" ] || [ "$Building" == "ALC" ]);
	then
		echo "You chose "$Building""
		read -p "Is this correct? y/n: " _Yn
		if [ "$_Yn" == "y" ];
		then
			read -p "Please enter the number of carts you want: " NumCarts
			if [ "$NumCarts" -gt 1 ];
			then
				counter=1
				mkdir carts
				cd carts
				mkdir $Building
				echo "Now going to get cart info and write cart files"
				sleep 3
				while [ "$counter" -le "$NumCarts" ];
				do
					cp ../needed_file/cart_template.csv "$Building"/"$Building"CB"$counter".csv # This line requires files from GAM
					cat ../needed_file/full.csv | grep -w ""$Building"CB"$counter"" | awk -F, '{print "echo -n "$1",;echo -n $(date -d @$(("$54" / 1000)) +%Y%m%d);echo -n ,"$1467","$468","$470",initial import,"$472","$470",chromebook,"; if (length($1467)>13) {print "echo "substr($1467,length($1467)-13,length($1467))}else{print "echo "$1467}}' | sh >> "$Building"/"$Building"CB"$counter".csv # This line requires files from GAM
					counter=$((counter+1))
				done
				exit
			else if [ "$NumCarts" -eq 1 ];
			then
				read -p "Please enter the cart name you want: " CartName
				read -p "You want information for cart "$CartName", is that correct? y/n: " YesNo
				if [ "$YesNo" == "y" ];
				then
					echo "Getting information for cart "$CartName" and writing to file 'single/"$CartName".csv'."
					sleep 3
					mkdir carts
					cd carts
					mkdir single
					cp ../needed_file/cart_template.csv single/"$CartName".csv # This line requires files from GAM
					cat ../needed_file/full.csv | grep -w ""$CartName"" | awk -F, '{print "echo -n "$1",;echo -n $(date -d @$(("$54" / 1000)) +%Y%m%d);echo -n ,"$1467","$468","$470",initial import,"$472","$470",chromebook,"; if (length($1467)>13) {print "echo "substr($1467,length($1467)-13,length($1467))}else{print "echo "$1467}}' | sh >> single/"$CartName".csv # This line requires files from GAM
					break
				fi
			fi
			fi
		fi
	fi
done
exit
