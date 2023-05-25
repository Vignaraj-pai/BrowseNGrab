
#To check if exactly 1 command line argument has been provided.

if [ $# -ne 1 ]
then
	echo "Error : Please provide a URL as a command line argument."
	exit 1
fi

#To check whether the given URL is a valid one.

if ! curl --output /dev/null --silent --head --fail "$1"
then
	echo "Error : The given URL is invalid."
	exit 1
fi

#curl is used to download a particular web-page and its contents onto your local storage.

curl --silent "$1" > downloaded.html

echo "The web page contents of the given URL have been downloaded and saved to downloaded.html ."
