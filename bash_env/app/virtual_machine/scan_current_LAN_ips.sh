#!/bin/bash

bash_script_i
echo

which nmap &>/dev/null  || {
    # Install nmap if not already installed
    echo "nmap is not installed. Installing nmap..."
    dumpcmd "sudo apt update && sudo apt install -y nmap"
    sudo apt update && sudo apt install -y nmap
    if [[ $? -ne 0 ]]; then
        echo "Failed to install nmap. Please check your package manager."
        return 1
    else
        echo "nmap installed successfully."
fi
}

dumpinfo "Scanning current LAN IPs ..."
dumpcmd "nmap -sn 192.168.0.0/24     # from machine ${red} $(hostname -I) ${end} "

# original command to scan LAN IPs
# nmap -sn 192.168.0.0/24 
# format and highlight the output
nmap -sn 192.168.0.0/24 | sed -E "s#^Nmap scan report#\nNmap scan report#g"  | sed -E "s#([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})#${s_green}\1${s_end}#g"

echo
bash_script_o
