
echo "# Bookmarks" |cat > Bookmarks.md
search=$1
chrome()
{
    if [ ! -d "${HOME}/.config/google-chrome" ];
    then
        echo "Chrome is not present on this system."

    else
        echo "### Chrome" >> Bookmarks.md
        address=${HOME}/.config/google-chrome/Default/Bookmarks
        if [[ $search == "" ]];then
            jq -r ' .roots.bookmark_bar.children[] | "- \(.url)" ' $address >> Bookmarks.md
        else
            jq -r ' .roots.bookmark_bar.children[] | "- \(.url)" ' $address | grep $search >> Bookmarks.md
        fi
        if [[ $? == 0 ]];then
            echo "Chrome bookmarks saved"
        else    
            echo "No bookmarks found on Chrome"
        fi
    fi

}

brave()
{
    if [ ! -d "${HOME}/.config/BraveSoftware" ];
    then
        echo "Brave is not present on this system."

    else
        echo "### Brave" >> Bookmarks.md
        address=${HOME}/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
        if [[ $search == "" ]];then
            jq -r ' .roots.bookmark_bar.children[] | "- \(.url)" ' $address >> Bookmarks.md
        else
            jq -r ' .roots.bookmark_bar.children[] | "- \(.url)" ' $address | grep $search >> Bookmarks.md
        fi
        if [[ $? == 0 ]];then
            echo "Brave bookmarks saved"
        else    
            echo "No bookmarks found on Brave"
        fi
    fi

}



chrome
brave
