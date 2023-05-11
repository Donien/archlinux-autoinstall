# Usage

**DO NOT RUN IN PRODUCTION!!!**  
**THIS IS STILL WORK IN PROGRESS!!!**

Booting from an Arch Linux iso you can append the boot parameter `script=https://some.server/path/to/your/script`.  
This causes your live environment to fetch that script file and execute it at startup.  

If you use the url to this script, Arch Linux should be installed auto**magic**ally.  

You can savely test this in a VM (with no important disks attatched).  
Make sure to keep an eye on your boot priority. This script will rerun again and again if you boot using this boot parameter.
