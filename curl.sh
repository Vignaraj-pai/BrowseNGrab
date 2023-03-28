curl -o $1.txt "$1" 
res=$?
if [ "$res" != "0" ]
then
	echo "Not a valid URL"
else
	echo "Valid URL and saved to file"
fi

