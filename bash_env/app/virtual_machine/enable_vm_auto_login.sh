#!/bin/bash

bash_script_i
echo
# verified in VirtualBox 7.12 + ubuntu-22.04.5-live-server-amd64.iso (from https://releases.ubuntu.com/22.04/)

user_name=$(whoami)
echo "# Current username: $user_name"

# Check if this is a server environment (no gdm3)
if ! systemctl status gdm3 &>/dev/null; then
    echo "# gdm3 not found, configuring command-line auto-login (agetty)..."
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    # Backup existing override.conf if it exists
    if sudo test -f /etc/systemd/system/getty@tty1.service.d/override.conf; then
        backup_file="/etc/systemd/system/getty@tty1.service.d/override.conf.bak.$(date +%Y%m%d_%H%M%S)"
        echo "# Backing up existing override.conf to $backup_file"
        sudo cp /etc/systemd/system/getty@tty1.service.d/override.conf "$backup_file"
    fi
    sudo bash -c "cat > /etc/systemd/system/getty@tty1.service.d/override.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $user_name --noclear %I $TERM
EOF
    echo "# Written /etc/systemd/system/getty@tty1.service.d/override.conf"
    echo "# Run: sudo systemctl daemon-reload && sudo systemctl restart getty@tty1 to apply, or reboot the VM."
else
    echo "# gdm3 desktop environment detected. Please manually edit /etc/gdm3/custom.conf and add:" 
    echo "[daemon]"
    echo "AutomaticLoginEnable = true"
    echo "AutomaticLogin = $user_name"
    echo "# Then reboot the VM."
fi

echo
bash_script_o
