#!/bin/bash


# Google Chrome
function chromeBookmarks() {

	# Check whether google-chrome/Default folder exists in ~/.config folder or not
	if [ -d "${HOME}/.config/google-chrome" -a -d "${HOME}/.config/google-chrome/Default" ]; then
		file_path=$(find "${HOME}/.config/google-chrome/Default" -iname "Bookmarks")
		browserlist+=("--chrome")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" ]; then
			echo "Currently there are no bookmarks for Google Chrome" >&2
			return
		else
			echo -e "## Google Chrome\n" >>  "${location}/bookmarks.md"
		
			echo "---" >> "${location}/bookmarks.md"
			contents=$(cat "${file_path}")
			contents=$(echo "$contents" | grep -w "\"url\":" | tr -s " " " " | cut -d " " -f3 )
			contents=$(echo "$contents" | awk '{print "-",$0}' | sed 's/\"//g')
			echo "$contents" >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Google Chrome not found for ${USER} user" >&2
	fi
}	

# Mozilla Firefox
function firefoxBookmarks() {

	# Check whether .mozilla/firefox folder exists or not
	if [ -d "${HOME}/.mozilla" -a -d "${HOME}/.mozilla/firefox" ]; then
		file_path=$(find "${HOME}/.mozilla/firefox/" -iname "places.sqlite")
		browserlist+=("--firefox")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" ]; then
			echo "Currently there are no bookmarks for Mozilla Firefox" >&2
			return
		else
			echo -e "## Mozilla Firefox\n" >>  "${location}/bookmarks.md"
			echo "---" >> "${location}/bookmarks.md"
			query="select p.url from moz_places as p, moz_bookmarks as b where p.id = b.fk;"
			bk=$(sqlite3 "${file_path}" "${query}" )
			echo "$bk" | awk '{print "-",$0}' >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Mozilla Firefox not found for ${USER} user" >&2
	fi
}

# Brave Browser
function braveBookmarks() {

	# Check whether BraveSoftware/Brave-Browser folder exists in ~/.config folder or not
	if [ -d "${HOME}/.config/BraveSoftware" -a -d "${HOME}/.config/BraveSoftware/Brave-Browser" ]; then
		file_path=$(find "${HOME}/.config/BraveSoftware/Brave-Browser" -iname "Bookmarks")
		browserlist+=("--brave")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" ]; then
			echo "Currently there are no bookmarks for Brave Browser" >&2
			return
		else
			echo -e "## Brave Browser\n" >>  "${location}/bookmarks.md"
			echo "---" >> "${location}/bookmarks.md"
			contents=$(cat "${file_path}")
			contents=$(echo "$contents" | grep -w "\"url\":" | tr -s " " " " | cut -d " " -f3 )
			contents=$(echo "$contents" | awk '{print "-",$0}' | sed 's/\"//g')
			#append to bookmarks.md
			echo "$contents" >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Brave Browser not found for ${USER} user" >&2
	fi
}	

# Chromium
function chromiumBookmarks() {

	# Check whether chromium/Default folder exists in ~/.config folder or not
	if [ -d "${HOME}/.config/chromium" -a -d "${HOME}/.config/chromium/Default" ]; then
		file_path=$(find "${HOME}/.config/chromium/Default" -iname "Bookmarks")
		browserlist+=("--chromium")
		icons=$(find "${HOME}/.config/chromium/Default" -iname "Favicons")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" -a -z "$icons" ]; then
			echo "Currently there are no bookmarks for Chromium" >&2
			return
		else
			echo -e "## Chromium\n" >>  "${location}/bookmarks.md"
			echo "---" >> "${location}/bookmarks.md"
			contents=$(cat "${file_path}")
			contents=$(echo "$contents" | grep -w "\"url\":" | tr -s " " " " | cut -d " " -f3)
			contents=$(echo "$contents" | awk '{print "-",$0}' | sed 's/\"//g')
			echo "$contents" | awk '{print "-",$0}' >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Chromium not found for ${USER} user" >&2
	fi
}

function edgeBookmarks() {

	# Check whether Microsoft/Edge folder exists in ~/.config folder or not
	if [ -d "${HOME}/.config/microsoft-edge" -a -d "${HOME}/.config/microsoft-edge/Default" ]; then
		file_path=$(find "${HOME}/.config/microsoft-edge/Default" -iname "Bookmarks")
		browserlist+=("--edge")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" ]; then
			echo "Currently there are no bookmarks for Microsoft Edge" >&2
			return
		else
			echo -e "## Microsoft Edge\n" >>  "${location}/bookmarks.md"
			echo "---" >> "${location}/bookmarks.md"
			contents=$(cat "${file_path}")
			contents=$(echo "$contents" | grep -w "\"url\":" | tr -s " " " " | cut -d " " -f3)
			contents=$(echo "$contents" | awk '{print "-",$0}' | sed 's/\"//g')
			echo "$contents" >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Microsoft Edge not found for ${USER} user" >&2
	fi
}

function operaBookmarks() {
	# Check whether opera folder exists in ~/.var/app folder or not
	if [ -d "${HOME}/.var/app/com.opera.Opera/config/" -a -d "${HOME}/.var/app/com.opera.Opera/config/opera/" ]; then
		file_path=$(find "${HOME}/.var/app/com.opera.Opera/config/opera/" -iname "Bookmarks")
		browserlist+=("--opera")
		# if the file does not exists then there are no bookmarks
		if [ -z "$file_path" ]; then
			echo "Currently there are no bookmarks for Opera" >&2
			return
		else
			echo -e "## Opera\n" >>  "${location}/bookmarks.md"
			echo "---" >> "${location}/bookmarks.md"
			contents=$(cat "${file_path}")
			contents=$(echo "$contents" | grep -w "\"url\":" | tr -s " " " " | cut -d " " -f3)
			contents=$(echo "$contents" | awk '{print "-",$0}' | sed 's/\"//g')
			echo "$contents" >> "${location}/bookmarks.md"
			echo -e "\n" >> "${location}/bookmarks.md"
		fi
	else
		echo "Opera not found for ${USER} user" >&2
	fi
}

location="${HOME}/Documents/BrowseNGrab"

# Delete bookmarks.md if it exists
[ -f "${location}/bookmarks.md" ] && rm "${location}/bookmarks.md"
# Delete bookmarks.html if it exists
[ -f "${location}/bookmarks.html" ] && rm "${location}/bookmarks.html"


browserlist=()

# Print the usage help
print_usage() {
    echo "Usage: bng [option]"
    echo "Options:"
    echo "  -h, --help                Show help"
    echo "  -v, --version             Show version"
    echo "  -b, --bookmark            Collect all bookmarks from all browsers on the system"
    echo "  -ch, --chrome             Collect all bookmarks from Chrome browser"
    echo "  -br, --brave              Collect all bookmarks from Brave browser"
    echo "  -cr, --chromium           Collect all bookmarks from Chromium browser"
    echo "  -e, --edge                Collect all bookmarks from Microsoft Edge browser"
    echo "  -o, --opera               Collect all bookmarks from Opera browser"
    echo "  -f, --firefox             Collect all bookmarks from Firefox browser"
	echo "  -n, --nitk 			      login to NITK-NET"
	echo "  -n -s, --nitk --status          Display NITK-NET login status"
	echo "  -n -lo, --nitk --logout          Logout from NITK-NET"
	echo "  -n -c, --nitk --change          Change NITK-NET credentials"
}

if [ $# -lt 1 ]; then
    echo "Error: No arguments provided."
	print_usage
    exit 1
fi


# Handle bookmark collection for all browsers
handle_bookmark_collection() {
	# Delete bookmarks.md if it exists
	[ -f "${location}/bookmarks.md" ] && rm "${location}/bookmarks.md"
	# Delete bookmarks.html if it exists
	[ -f "${location}/bookmarks.html" ] && rm "${location}/bookmarks.html"
    echo "Collecting bookmarks from all browsers"
	# create the directory if it does not exist
	[ ! -d "${location}" ] && mkdir "${location}"
	# add all browser names to the array
    chromeBookmarks
    braveBookmarks
    chromiumBookmarks
    edgeBookmarks
    operaBookmarks
    firefoxBookmarks
}

# Handle specific browser bookmark collection
handle_browser_bookmark_collection() {
    browser=$1
	# Delete bookmarks.md if it exists
	[ -f "${location}/bookmarks.md" ] && rm "${location}/bookmarks.md"
	# Delete bookmarks.html if it exists
	[ -f "${location}/bookmarks.html" ] && rm "${location}/bookmarks.html"
	# create the directory if it does not exist
	[ ! -d "${location}" ] && mkdir "${location}"
    echo "Collecting bookmarks from $browser browser"
    # Handle the collection logic for the specified browser
    case $browser in
        "chrome")
            chromeBookmarks
			# add the browser name to the array	
            ;;
        "brave")
            braveBookmarks
			# add the browser name to the array
            ;;
        "chromium")
            chromiumBookmarks
			# add the browser name to the array
            ;;
        "edge")
            edgeBookmarks
			# add the browser name to the array
            ;;
        "opera")
            operaBookmarks
			# add the browser name to the array
            ;;
        "firefox")
            firefoxBookmarks
			# add the browser name to the array
            ;;
        *)
            echo "Error: Invalid browser option: $browser"
            ;;
    esac
}

# Process the options
while [[ $# -gt 0 ]]; do
    case $1 in
        -h | --help)
            print_usage
            exit 0
            ;;
        -v | --version)
            echo "Version 1.0"
            exit 0
            ;;
        -b | --bookmark)
            handle_bookmark_collection
            ;;
        -ch | --chrome)
            handle_browser_bookmark_collection "chrome" 
            ;;
        -br | --brave)
            handle_browser_bookmark_collection "brave" 
            ;;
        -cr | --chromium)
            handle_browser_bookmark_collection "chromium" 
            ;;
        -e | --edge)
            handle_browser_bookmark_collection "edge"
            ;;
        -o | --opera)
            handle_browser_bookmark_collection "opera" 
            ;;
        -f | --firefox)
            handle_browser_bookmark_collection "firefox" 
            ;;
        -n | --nitk)
			case $2 in
				-s | --status)
					./usr/bin/connect_nitk.sh -s
					exit 0
					;;
				-c | --change)
					./usr/bin/connect_nitk.sh -c
					exit 0
					;;
				-lo | --logout)
					./usr/bin/connect_nitk.sh -lo
					exit 0
					;;
				*)	
					bash -c './usr/bin/connect_nitk.sh'
					exit 0
					;;
			esac
			;;
	esac
	shift
done

# run python script script.py with location and --browser name flags from browser_list
python3 /usr/bin/script.py "${location}" "${browserlist[@]}"

# If bookmarks.md exists then output it's path
[ -f "${location}/bookmarks.md" ] && printf %"$COLUMNS"s | tr " " "-" && echo "bookmarks.md created at ${location}"

# If bookmarks.html exists then output it's path
[ -f "${location}/bookmarks.html" ] && printf %"$COLUMNS"s | tr " " "-" && echo "exportable bookmarks.html created at ${location}"