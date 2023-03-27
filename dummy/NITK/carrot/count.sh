x="y"
while [[ "$x" == "y" || "$x" == "yes" ]]		#checking if input is yes/y
do

	echo "Enter a number between 1 and 10:"
	read n

	if (($n<1 || $n>10))				#checking if input is b/w 1 and 10
	then
		echo "Error-Out of bounds"
		exit 1
	else
		for ((i=$n ;i>0 ;i--))
		do
			echo $i
			sleep 1s			#waits 1 sec and then prints next number in countdown
		done
		echo "Blast Off!"
	fi
	echo "Do you want to try again?(y/yes/n/no)"
	read x 
done
