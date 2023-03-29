if [ "$#" = "1" ]				#checking if only 1 cmd line arg is entered
then
	echo "Enter string to search for:"
	read str
else
	str=$2
fi

grep -rn "$str" "$1" | cut -d: -f1,2		#searching for str and using cut to not print the line and only the line number

if [ "${PIPESTATUS[0]}" != "0" ]		#checking exit status of grep
then
	echo "String not found."
fi
