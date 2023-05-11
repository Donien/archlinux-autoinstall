#!/usr/bin/bash

read -r -d '' user_config << EOF
{
    "config_version": "2.5.5",
    "debug": false,
    "harddrives": [
        "/dev/vda"
    ],
    "hostname": "archlinux",
    "bootloader": "grub-install",
    "keyboard-layout": "de-latin1",
    "nic": {
        "dhcp": true,
        "dns": null,
        "gateway": null,
        "iface": null,
        "ip": null,
        "type": "nm"
    },
    "no_pkg_lookups": false,
    "offline": false,
    "packages": [
        "openssh",
        "vim"
    ],
    "profile": {
        "path": "/usr/lib/python3.10/site-packages/archinstall/profiles/minimal.py"
    },
    "script": "guided",
    "silent": false,
    "sys-encoding": "utf-8",
    "sys-language": "en_US",
    "version": "2.5.5"
}
EOF

read -r -d '' user_disk_layout << EOF
{
    "/dev/vda": {
        "partitions": [
            {
                "boot": true,
                "encrypted": false,
                "filesystem": {
                    "format": "fat32"
                },
                "mountpoint": "/boot",
                "size": "203MiB",
                "start": "3MiB",
                "type": "primary",
                "wipe": true
            },
            {
                "encrypted": false,
                "filesystem": {
                    "format": "ext4",
                    "mount_options": []
                },
                "mountpoint": "/",
                "size": "100%",
                "start": "206MiB",
                "type": "primary",
                "wipe": true
            }
        ],
        "wipe": true
    }
}
EOF

# Prep
echo "$user_config"      > user_configuration.json
echo "$user_disk_layout" > user_disk_layout.json

# Actual install
archinstall --silent --config user_configuration.json --disk_layouts user_disk_layout.json

# Repair (passwords are not well implemented yet)
echo "root:root" | arch-chroot /mnt/archinstall chpasswd

# SSH
arch-chroot /mnt/archinstall systemctl enable sshd.service
echo "PermitRootLogin yes" >> /mnt/archinstall/etc/ssh/sshd_config


#
#    "nic": {
#        "dhcp": true,
#        "dns": null,
#        "gateway": null,
#        "iface": null,
#        "ip": null,
#        "type": "nm"
#    },
#
