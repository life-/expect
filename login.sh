#!/bin/bash
#----------------------------------------
#   Desc: ssh login script
#   Date: 2014-02-14
#   Author: elmer
#----------------------------------------

if [ $# != 1 ];then
        echo "Usage: $0 ip pwd" 
        exit 1
fi

expects() 
{
    expect -c "spawn $1;
    set timeout 3600
    for {} {1} {} {
        expect {
            \"yes/no)?\" { send \"yes\r\" }
            \"assword\"  { send \"$2\r\" }
            \"\[#$>]\" { break }
            \"failed\" { exit 1}
            timeout { exit 1}
        }
    }
    interact;";
}

hostname="$1"
username="root"
password="$2"

expects "ssh -l$username -p22 $hostname" "$password"
