

arg=$#
#To check if any arguments were passed.
if [ $arg -eq 0 ]
then
	echo "Error : No arguments were passed."
	exit 1
fi

#To check if the first argument is a parameter.	

if [ ! -d "$1" ]
then
	echo "Error : $1 is not a directory."
	exit 1
fi

#To accept the entered string or prompt the user to enter a string.

if [ $arg -eq 1 ]
then
	read -p "Enter the string to be searched : " search
else
	search=""
	for ((num=2; num<=$arg; num++))
		do
			search="$search ${!num}"
		done
	search="${search:1}"
fi

#grep is used to recursively go through each file in the given directory and each of the sub-directories and gives a value if it present else remains empty.

grep_ans=$(grep -r -n "$search" "$1")

#We check whether grep_ans is empty or not using -z, and hence we can determine whether the required string was found or not.

if [ -z "$grep_ans" ]
then
	echo "The given string \"$search\" was not found in $1 or its sub-directories. "
else
	echo "$grep_ans"
fi

