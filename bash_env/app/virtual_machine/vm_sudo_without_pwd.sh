#!/bin/bash

bash_script_i
echo

function enable_golbal_sudo_without_pwd() {
    echo "# Enabled global sudo without password for ${USER}"

    sudoers_file="/etc/sudoers.d/${USER}_nopasswd_all"
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee ${sudoers_file} 
    sudo chmod 0440 ${sudoers_file}    
}

function disable_golbal_sudo_without_pwd() {
    echo "# Disabled global sudo without password for ${USER}"

    sudoers_file="/etc/sudoers.d/${USER}_nopasswd_all"
    if [[ -f ${sudoers_file} ]]; then
        sudo rm -f ${sudoers_file}
        echo "# Removed ${sudoers_file}"
    else
        echo "# No such file: ${sudoers_file}"
    fi
}

echo
bash_script_o
