while true
do
	read -p "Enter a number in between 1 and 10: " num
	if [[ $num -gt 10 || $num -lt 1 ]]
	then
		echo "Error : The input is outside the required range."
		exit 1
	fi
	for(( n=num; n>=1; n--))
	do
		echo "$n"
	done
	echo "Blast Off!"
	echo "Do you want to run the script again?"
	read rep
	case "$rep" in
	y|Y|yes|YES)
		continue
		;;
	n|N|no|NO)
		exit 1
		;;
	*)
		exit 1
		;;
	esac
done
