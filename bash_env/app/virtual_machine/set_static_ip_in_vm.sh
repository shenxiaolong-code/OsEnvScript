#!/bin/bash

bash_script_i
echo

default_static_vm_ip="192.168.0.100"

function set_temporary_static_ip() {
    local static_vm_ip="${1:-${default_static_vm_ip}}"  # Default static IP if not provided
    local current_ip="$(hostname -I)"
    [[ "${current_ip}" == "${static_vm_ip}"* ]] && {
        dumpinfo "Temporary static IP${red} ${static_vm_ip} ${blue}is already set."
        return
    }

    # auto check network card name（first non lo network card）
    vm_iface=$(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$' | head -n1)
    dumpinfo " set static ip ${static_vm_ip} on network card ${vm_iface}"

    dumpcmd "sudo ip addr flush dev ${vm_iface}"
    sudo ip addr flush dev "${vm_iface}"

    dumpcmd "sudo ip addr add ${static_vm_ip}/24 dev ${vm_iface}"
    sudo ip addr add ${static_vm_ip}/24 dev "${vm_iface}"
    
    # Ensure the gateway is set correctly, adjust as necessary for your network
    dumpcmd "sudo ip route add default via 192.168.0.1"    
    sudo ip route add default via 192.168.0.1

    echo
    dumpcmd "ip a | sed -n \"/${vm_iface}/,$p\""
    # ip a | sed -n '/enp0s3/,$p'
    ip a | sed -n "/${vm_iface}/,$p"
    echo "Static IP set to ${static_vm_ip} on interface ${vm_iface}"
}

function main_set_temporary_static_ip() {
    local current_ip="$(hostname -I)"
    [[ ${current_ip} != "192.168.0."* ]] && {
        # it is not LAN environement, return directly
        return
    }

    [[ "${current_ip}" != "${default_static_vm_ip}"* ]] && {
        dumpinfo "Setting temporary static IP ${default_static_vm_ip} for LAN VM..."
        set_temporary_static_ip "${default_static_vm_ip}" 1> /dev/null 2>&1
    }
}

# set_temporary_static_ip "192.168.0.100"
main_set_temporary_static_ip

echo
bash_script_o
