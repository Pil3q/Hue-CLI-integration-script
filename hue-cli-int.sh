#!/bin/bash
command="${1}"
if [ $# -lt 1 ]; then
    echo "Hey, you need to provide the command"
    echo "Remember to use quotes '' if your command take any arguments"
    echo "Example: hue 'terraform plan'"
    echo "Watch out for custom aliases"
    exit 2
elif [ $# -ne 1 ] && [ $2 = "DEBUG" ]; then
    quiet=""
elif [ $# -eq 1 ]; then
    quiet="-s -o /dev/nul"
else
    echo "Easy tiger - looks like you are trying to pass to many arguments"
    echo "Only command in quotes is allowed"
    echo "If you need more details add DEBUG as a second argument, but that is it"
    exit 2
fi

living_room_small_id="4"
living_room_side_id="1"
living_room_main_id="8"

hue_ip="${HUE_IP}"
if [ -z $hue_ip ]
then
  echo "You need to provide hue ip, you can set env variable HUE_IP or edit the script"
  exit 1
fi

api_token="${HUE_API}"
if [ -z $api_token ]
then
  echo "You need to provide api token, you can set env variable HUE_API or edit the script"
  exit 1
fi

red_colour='{"on":true, "sat":254, "bri":254,"hue": 65535}'
green_colour='{"on":true, "sat":254, "bri":254,"hue": 25555}'
white_colour='{"on":true, "sat":12, "bri":254,"hue": 39354}'

living_green() {
    curl -H "Content-Type: application/json" -X PUT -d "$green_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_side_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$green_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_small_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$green_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_main_id/state
}
living_red() {
    curl -H "Content-Type: application/json" -X PUT -d "$red_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_side_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$red_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_main_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$red_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_small_id/state
}
living_white() {
    curl -H "Content-Type: application/json" -X PUT -d "$white_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_side_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$white_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_small_id/state
    curl -H "Content-Type: application/json" -X PUT -d "$white_colour" $quiet --insecure https://$hue_ip/api/$api_token/lights/$living_room_main_id/state
}

if $command ; then
    living_green
    sleep 3s
    living_white
else
    living_red
    sleep 3s
    living_white
fi