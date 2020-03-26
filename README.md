# CLI HUE integration
## What is it?
This script will integrate the exit codes of shell commands and turn green lights for 3s for the success and red lights for 3s for the failure and switch back to the bright white
## What do I need to use it?
You need
1. Philips Hue lights
2. Hue server 
3. Be connected to the same network as your Hue server.
4. You also need to know your Hue server IP address and generate API key. You can do it by following instructions [here](https://developers.meethue.com/develop/get-started-2/)
5. You need to get the ID of lights you want to change (also in the guide above)
## So how do I install it?
Copy the `hue-cli-int.sh` file to the directory of your choice. Add the appropriate permissions by executing `chmod +x hue-cli-int.sh`.
Add the following to your bash profile (usually in `~/.bashrc` or `~/.zshrc`):
```bash
alias hue="sh ~/YOUR-PATH-HERE/hue-cli-int.sh"
export HUE_IP="YOUR-HUE-IP"
export HUE_API="YOUR-HUE-ACCESS KEY"
```
Those will create the environment variable available in your terminal sessions and the alias for executing the script. Once you got that you are good to go.
Then you need to adjust the script to reflect your set up, mine was 3 different lights in one of the rooms, but you can use more or less and parametrise script. Variables youu need to edit in `hue-cli-int.sh` are:
```bash
living_room_small_id="4"
living_room_side_id="1"
living_room_main_id="8"
```
## How do I use it?
Simply execute `hue "command of your choice"`. If the command has 0 exit code lights will go green, and if any different code will be provided the they will turn red. You can provide commands with arguments as long as you use quotes `""`. Unfortunatelly you cannot use your custom aliases.
## What if it goes wrong?
If for some reason things are not going your way try to run `hue "command of your choice" DEBUG`. Once you run this the API response will be outputted which should give you some more visibility
## Guidance to customizing
If we look at the colour variable in the script
```bash
red_colour='{"on":true, "sat":254, "bri":254,"hue": 65535}'
```
We can se that we can modify the following:
1. "on" - true or false - light turn on/off
2. "sat" - 0 - 254 - saturation
3. "bri" - 0 - 254 - brightness
4. "hue" - 0 - 65535 - colour
You can of course move around the api calls to tailor behaviour to your needs, edit sleep time etc.