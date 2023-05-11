
if [ ! -f "login_details.txt" ];then
    echo "Enter username:"
    read user
    echo "Enter password:"
    read pass
    echo $user >> login_details.txt
    echo $pass >> login_details.txt
fi
 
user=$(sed '1q;d' login_details.txt)
pass=$(sed '2q;d' login_details.txt)

nmcli radio wifi on

until [ "$(nmcli -g connectivity general status)" == "portal" -o "$(nmcli -g connectivity general status)" == "full" ];
do
    sleep 2s
done

curl -d "mode=191&username=${user}&password=${pass}&a=1683813525441&producttype=0" -X POST https://nac.nitk.ac.in:8090/httpclient.html -s 1> /dev/null




    