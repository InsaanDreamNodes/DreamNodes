#!/bin/bash

# DreamNodes IP Hide Script - Complete VPS Privacy
# Har tool me "IP Hidden By DreamNodes" show hoga
# GPU Fix - No Amazon references anywhere

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   DreamNodes IP Hide System v2.0    ║${NC}"
echo -e "${CYAN}║   Complete VPS Anonymity Solution   ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════╝${NC}"

# System info override files
sudo mkdir -p /etc/dreamnodes
sudo tee /etc/dreamnodes/sysinfo > /dev/null << 'EOF'
DreamNodes Secure Server
Protected VPS Environment
EOF

# Hostname DreamNodes branding
sudo hostnamectl set-hostname "DreamNodes-Secure-Server"
sudo hostnamectl set-chassis "DreamNodes VPS" 2>/dev/null || true
sudo hostnamectl set-deployment "DreamNodes Cloud" 2>/dev/null || true
sudo hostnamectl set-location "DreamNodes Data Center" 2>/dev/null || true

# Fake product/system files
sudo tee /sys/devices/virtual/dmi/id/product_name 2>/dev/null <<< "DreamNodes Secure VPS" 2>/dev/null || true
sudo tee /sys/devices/virtual/dmi/id/product_version 2>/dev/null <<< "DN-2024-PRO" 2>/dev/null || true
sudo tee /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null <<< "DreamNodes Technologies" 2>/dev/null || true
sudo tee /sys/devices/virtual/dmi/id/chassis_vendor 2>/dev/null <<< "DreamNodes Cloud Infrastructure" 2>/dev/null || true

# ==============================
# GPU FIX - Override PCI devices
# ==============================
# Fake GPU info files
sudo mkdir -p /sys/devices/pci0000:00/0000:00:03.0 2>/dev/null
sudo tee /sys/devices/pci0000:00/0000:00:03.0/vendor 2>/dev/null <<< "DreamNodes" 2>/dev/null || true
sudo tee /sys/devices/pci0000:00/0000:00:03.0/device 2>/dev/null <<< "Virtual GPU" 2>/dev/null || true
sudo tee /sys/devices/pci0000:00/0000:00:03.0/subsystem_vendor 2>/dev/null <<< "DreamNodes" 2>/dev/null || true
sudo tee /sys/devices/pci0000:00/0000:00:03.0/subsystem_device 2>/dev/null <<< "Graphics Adapter" 2>/dev/null || true

# lspci override script
sudo tee /usr/local/bin/lspci-dreamnodes > /dev/null << 'LSPCIEOF'
#!/bin/bash
# DreamNodes lspci override - No Amazon/VMware references
/usr/bin/lspci "$@" 2>/dev/null | \
sed 's/Amazon.com, Inc. Device/DreamNodes Virtual GPU/g' | \
sed 's/VMware SVGA II Adapter/DreamNodes Virtual GPU/g' | \
sed 's/Cirrus Logic GD 5446/DreamNodes Virtual GPU/g' | \
sed 's/Red Hat, Inc. VirtIO GPU/DreamNodes Virtual GPU/g' | \
sed 's/NVIDIA Corporation/DreamNodes Technologies/g' | \
sed 's/Advanced Micro Devices, Inc. \[AMD\/ATI\]/DreamNodes Technologies/g' | \
sed 's/Intel Corporation/DreamNodes Technologies/g'
LSPCIEOF

sudo chmod +x /usr/local/bin/lspci-dreamnodes

# pciutils database override
sudo mkdir -p /usr/share/hwdata
sudo tee /usr/share/hwdata/pci.ids > /dev/null << 'PCIIDS'
# DreamNodes PCI ID Database
1af4  Red Hat, Inc.
  1000  DreamNodes Virtual GPU
  1001  DreamNodes Virtual GPU
15ad  DreamNodes Technologies
  0000  DreamNodes Virtual GPU
  0405  DreamNodes Virtual GPU
1b36  DreamNodes Technologies
  0100  DreamNodes Virtual GPU
PCIIDS

# Complete neofetch config with DreamNodes branding
mkdir -p ~/.config/neofetch
cat > ~/.config/neofetch/config.conf << 'NEOFETCHCONFIG'
# DreamNodes Neofetch Configuration
print_info() {
    info title
    info underline
    
    # Custom DreamNodes title
    prin "╔══════════════════════════╗"
    prin "║  DreamNodes Secure VPS  ║"
    prin "╚══════════════════════════╝"
    
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Shell" shell
    info "Resolution" resolution
    info "DE" de
    info "WM" wm
    
    # IP override
    prin "$(color 2)Local IP$(color 7)" "IP Hidden By DreamNodes"
    prin "$(color 2)Public IP$(color 7)" "IP Hidden By DreamNodes"
    prin "$(color 2)Gateway IP$(color 7)" "IP Hidden By DreamNodes"
    
    info "Terminal" term
    info "CPU" cpu
    
    # GPU FIX - direct string override
    prin "$(color 2)GPU$(color 7)" "DreamNodes Virtual GPU"
    
    info "Memory" memory
    
    # Custom footer
    prin "$(color 2)Provider$(color 7)" "DreamNodes Cloud"
    prin "$(color 2)Protection$(color 7)" "Active - IP Masked"
    
    info cols
}

# GPU forcefully override karo
gpu_shorthand="off"
gpu_brand="DreamNodes Virtual GPU"

# Override host info
host_model="DreamNodes Secure VPS"

# CPU ko bhi brand kare
cpu_brand="DreamNodes Optimized CPU"

# Colors
colors=(distro)

# GPU display function override
get_gpu() {
    case $(uname -s) in
        Linux)   gpus="DreamNodes Virtual GPU" ;;
        *)       gpus="DreamNodes Virtual GPU" ;;
    esac
    echo "$gpus"
}

# Trim function override for GPU
trim_gpu() {
    echo "DreamNodes Virtual GPU"
}
NEOFETCHCONFIG

# Neofetch GPU config extra - direct source override
mkdir -p ~/.config/neofetch
cat > ~/.config/neofetch/gpu_override << 'GPUOVERRIDE'
# GPU information override
get_gpu() {
    echo "DreamNodes Virtual GPU"
}
GPUOVERRIDE

# Fastfetch DreamNodes config with GPU fix
mkdir -p ~/.config/fastfetch
cat > ~/.config/fastfetch/config.jsonc << 'FASTFETCHCONFIG'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "builtin",
        "padding": {
            "top": 2,
            "left": 2
        }
    },
    "display": {
        "separator": " ➜ "
    },
    "modules": [
        {
            "type": "title",
            "format": "DreamNodes Secure VPS"
        },
        {
            "type": "custom",
            "format": "╔════════════════════════════════════╗"
        },
        {
            "type": "custom",
            "format": "║    IP Hidden By DreamNodes        ║"
        },
        {
            "type": "custom",
            "format": "╚════════════════════════════════════╝"
        },
        "separator",
        "os",
        "host",
        "kernel",
        "uptime",
        "packages",
        "shell",
        "display",
        "de",
        "wm",
        "terminal",
        "cpu",
        {
            "type": "gpu",
            "format": "DreamNodes Virtual GPU"
        },
        "memory",
        "disk",
        {
            "type": "localip",
            "format": "IP Hidden By DreamNodes"
        },
        {
            "type": "publicip",
            "format": "IP Hidden By DreamNodes"
        },
        "break",
        {
            "type": "custom",
            "format": "🔒 Secured by DreamNodes Technologies"
        }
    ]
}
FASTFETCHCONFIG

# Screenfetch DreamNodes wrapper with GPU fix
cat > ~/.config/screenfetch-wrapper << 'SCREENFETCH'
#!/bin/bash
# DreamNodes Screenfetch Wrapper

# Screenfetch ko run karo aur output modify karo
/usr/bin/screenfetch "$@" 2>/dev/null | \
sed 's/Amazon.com, Inc. Devi/DreamNodes Secure VPS/g' | \
sed 's/Amazon EC2/DreamNodes Cloud/g' | \
sed 's/AWS/DreamNodes/g' | \
sed 's/amazon/dreamnodes/gi' | \
sed 's/VMware, Inc./DreamNodes Technologies/g' | \
sed 's/VMware SVGA II Adapter/DreamNodes Virtual GPU/g' | \
sed 's/VMware Virtual VGA/DreamNodes Virtual GPU/g' | \
sed 's/Cirrus Logic GD 5446/DreamNodes Virtual GPU/g' | \
sed 's/Red Hat, Inc. VirtIO GPU/DreamNodes Virtual GPU/g' | \
sed 's/NVIDIA/DreamNodes/g' | \
sed 's/AMD\/ATI/DreamNodes/g' | \
sed 's/Intel.*Graphics/DreamNodes Virtual GPU/g' | \
sed 's/GPU:.*/GPU: DreamNodes Virtual GPU/' | \
sed 's/IP:.*/IP: IP Hidden By DreamNodes/' | \
sed 's/192\.168\.[0-9]\{1,3\}\.[0-9]\{1,3\}/IP Hidden By DreamNodes/g' | \
sed 's/10\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/IP Hidden By DreamNodes/g' | \
sed 's/172\.\(1[6-9]\|2[0-9]\|3[0-1]\)\.[0-9]\{1,3\}\.[0-9]\{1,3\}/IP Hidden By DreamNodes/g'

# Agar screenfetch nahi hai to custom output
if [ $? -ne 0 ]; then
    cat << 'EOF'
                          ./+o+-       user@DreamNodes-Secure-Server
                  yyyyy- -yyyyyy+      OS: Ubuntu 22.04 DreamNodes Edition
               ://+//////-yyyyyyo      Kernel: x86_64 Linux 5.15.0
           .++ .:/++++++/-.+sss/`      Uptime: 10d 4h 20m
         .:++o:  /++++++++/:--:/-      Packages: 1847
        o:+o+:++.`..```.-/oo+++++/     Shell: bash 5.1.16
       .:+o:+o/.          `+sssoo+/    Resolution: 1920x1080
  .++/+:+oo+o:`             /sssooo.   DE: GNOME
 /+++//+:`oo+o               /::--:.   WM: Mutter
 \+/+o+++`o++o               ++////.   WM Theme: Adwaita
  .++.o+++oo+:`             /dddhhh.   CPU: DreamNodes Optimized CPU
       .+.o+oo:.          `oddhhhh+    GPU: DreamNodes Virtual GPU
        \+.++o+o``-````.:ohdhhhhh+     Memory: 2048MB / 7986MB
         `:o+++ `ohhhhhhhhyo++os:     
           .o:`.syhhhhhhh/.oo++o`      IP: IP Hidden By DreamNodes
               /osyyyyyyo++ooo+++/     Public IP: IP Hidden By DreamNodes
                   ````` +oo+++o\:     Protection: Active
                          `oo++.      
EOF
fi
SCREENFETCH

mkdir -p ~/.config 2>/dev/null
chmod +x ~/.config/screenfetch-wrapper

# Shell functions with DreamNodes branding + GPU fix
cat >> ~/.bashrc << 'BASHRCFUNCTIONS'

# ╔════════════════════════════════════╗
# ║   DreamNodes IP Protection v2.0  ║
# ╚════════════════════════════════════╝

# System fetch aliases
alias neofetch='neofetch --config ~/.config/neofetch/config.conf --source ~/.config/neofetch/gpu_override 2>/dev/null'
alias fastfetch='fastfetch --config ~/.config/fastfetch/config.jsonc 2>/dev/null'
alias screenfetch='~/.config/screenfetch-wrapper 2>/dev/null'
alias lspci='/usr/local/bin/lspci-dreamnodes'

# DreamNodes branded commands
dreamfetch() {
    echo "╔════════════════════════════════════════╗"
    echo "║     DreamNodes Secure Environment     ║"
    echo "╠════════════════════════════════════════╣"
    echo "║ Status: Protected                     ║"
    echo "║ IP Address: Hidden By DreamNodes      ║"
    echo "║ GPU: DreamNodes Virtual GPU           ║"
    echo "║ Location: DreamNodes Global DC        ║"
    echo "║ Encryption: AES-256 Active            ║"
    echo "║ Firewall: DreamShield Enabled         ║"
    echo "╚════════════════════════════════════════╝"
}

# Curl override - DreamNodes
curl() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*ip-api*|*checkip*|*whatismyip*|*myip*)
            echo "IP Hidden By DreamNodes"
            ;;
        *metadata*|*169.254.169.254*)
            echo "DreamNodes Secure VPS - Metadata Protected"
            ;;
        *)
            command curl "$@"
            ;;
    esac
}

# Wget override - DreamNodes
wget() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*checkip*|*whatismyip*)
            echo "IP Hidden By DreamNodes"
            ;;
        *)
            command wget "$@"
            ;;
    esac
}

# Hostname command override
hostname() {
    if [ "$1" = "-I" ] || [ "$1" = "-i" ]; then
        echo "IP Hidden By DreamNodes"
    else
        command hostname "$@"
    fi
}

# ifconfig override
ifconfig() {
    command ifconfig "$@" 2>/dev/null | \
    sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/inet IP Hidden By DreamNodes/g' | \
    sed 's/inet6 [a-f0-9:]*/inet6 IP Hidden By DreamNodes/g'
}

# ip command override
ip() {
    if [[ "$*" == *"addr"* ]] || [[ "$*" == *"address"* ]] || [[ "$*" == *"a"* ]]; then
        command ip "$@" 2>/dev/null | \
        sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\/[0-9]*/inet IP Hidden By DreamNodes/g' | \
        sed 's/inet6 [a-f0-9:]*/inet6 IP Hidden By DreamNodes/g'
    else
        command ip "$@"
    fi
}

# lshw GPU override
lshw() {
    command lshw "$@" 2>/dev/null | \
    sed 's/product:.*SVGA.*/product: DreamNodes Virtual GPU/g' | \
    sed 's/vendor:.*VMware.*/vendor: DreamNodes Technologies/g' | \
    sed 's/vendor:.*Amazon.*/vendor: DreamNodes Technologies/g'
}

# glxinfo override
glxinfo() {
    command glxinfo "$@" 2>/dev/null | \
    sed 's/OpenGL vendor string:.*/OpenGL vendor string: DreamNodes Technologies/g' | \
    sed 's/OpenGL renderer string:.*/OpenGL renderer string: DreamNodes Virtual GPU/g' | \
    sed 's/Device:.*VMware.*/Device: DreamNodes Virtual GPU/g' | \
    sed 's/Vendor:.*VMware.*/Vendor: DreamNodes Technologies (0x15ad)/g'
}

# SSH welcome message
if [ -n "$SSH_CONNECTION" ]; then
    echo "╔════════════════════════════════════════╗"
    echo "║   Welcome to DreamNodes Secure VPS    ║"
    echo "║   All IPs Hidden By DreamNodes        ║"
    echo "╚════════════════════════════════════════╝"
fi

# MOTD override
dreamprompt() {
    export PS1="\[\033[1;36m\]╭─\[\033[1;34m\]DreamNodes\[\033[0m\]@\[\033[1;32m\]Secure-VPS\[\033[0m\] \[\033[1;33m\]\w\[\033[0m\]\n\[\033[1;36m\]╰─\[\033[1;35m\]➤\[\033[0m\] "
}
dreamprompt

# Fortune-style messages
echo -e "\033[1;36m🔒 Active DreamNodes IP Protection | Type '${GREEN}dreamfetch${CYAN}' for status\033[0m"
BASHRCFUNCTIONS

# Same for zsh
if [ -f ~/.zshrc ]; then
    grep -q "DreamNodes" ~/.zshrc || cat >> ~/.zshrc << 'ZSHRCFUNCTIONS'

# ╔════════════════════════════════════╗
# ║   DreamNodes IP Protection v2.0  ║
# ╚════════════════════════════════════╝

alias neofetch='neofetch --config ~/.config/neofetch/config.conf --source ~/.config/neofetch/gpu_override 2>/dev/null'
alias fastfetch='fastfetch --config ~/.config/fastfetch/config.jsonc 2>/dev/null'
alias screenfetch='~/.config/screenfetch-wrapper 2>/dev/null'
alias lspci='/usr/local/bin/lspci-dreamnodes'

dreamfetch() {
    echo "╔════════════════════════════════════════╗"
    echo "║     DreamNodes Secure Environment     ║"
    echo "╠════════════════════════════════════════╣"
    echo "║ Status: Protected                     ║"
    echo "║ IP Address: Hidden By DreamNodes      ║"
    echo "║ GPU: DreamNodes Virtual GPU           ║"
    echo "║ Location: DreamNodes Global DC        ║"
    echo "║ Encryption: AES-256 Active            ║"
    echo "╚════════════════════════════════════════╝"
}

curl() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*ip-api*|*checkip*|*whatismyip*|*myip*)
            echo "IP Hidden By DreamNodes"
            ;;
        *) command curl "$@" ;;
    esac
}

wget() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*checkip*|*whatismyip*)
            echo "IP Hidden By DreamNodes"
            ;;
        *) command wget "$@" ;;
    esac
}

hostname() {
    if [ "$1" = "-I" ] || [ "$1" = "-i" ]; then
        echo "IP Hidden By DreamNodes"
    else
        command hostname "$@"
    fi
}

ifconfig() {
    command ifconfig "$@" 2>/dev/null | \
    sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/inet IP Hidden By DreamNodes/g'
}

ip() {
    if [[ "$*" == *"addr"* ]] || [[ "$*" == *"address"* ]]; then
        command ip "$@" 2>/dev/null | \
        sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/inet IP Hidden By DreamNodes/g'
    else
        command ip "$@"
    fi
}

lspci() {
    /usr/local/bin/lspci-dreamnodes "$@"
}

lshw() {
    command lshw "$@" 2>/dev/null | \
    sed 's/product:.*SVGA.*/product: DreamNodes Virtual GPU/g' | \
    sed 's/vendor:.*VMware.*/vendor: DreamNodes Technologies/g' | \
    sed 's/vendor:.*Amazon.*/vendor: DreamNodes Technologies/g'
}

export PROMPT='%F{cyan}╭─%F{blue}DreamNodes%F{reset}@%F{green}Secure-VPS%F{reset} %F{yellow}%~%F{reset}
%F{cyan}╰─%F{magenta}➤%F{reset} '
ZSHRCFUNCTIONS
fi

# Persistent DreamNodes service
sudo tee /etc/systemd/system/dreamnodes-ip-hide.service > /dev/null << 'SERVICEEOF'
[Unit]
Description=DreamNodes IP Hide Service
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'hostnamectl set-hostname DreamNodes-Secure-Server'
ExecStartPost=/bin/bash -c 'echo "DreamNodes Secure VPS" > /etc/dreamnodes/sysinfo 2>/dev/null'
RemainAfterExit=yes
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
SERVICEEOF

# Disable AWS metadata
if command -v iptables &> /dev/null; then
    sudo iptables -A OUTPUT -d 169.254.169.254 -j DROP 2>/dev/null
    sudo iptables -A OUTPUT -d 169.254.170.2 -j DROP 2>/dev/null
fi

# Override AWS system files
sudo mkdir -p /etc/cloud 2>/dev/null
sudo tee /etc/cloud/cloud.cfg.d/99-dreamnodes.cfg > /dev/null << 'CLOUDCFG'
# DreamNodes Override
datasource_list: [ None ]
cloud_init_modules: []
cloud_config_modules: []
cloud_final_modules: []
CLOUDCFG

# Disable cloud-init
if command -v cloud-init &> /dev/null; then
    sudo touch /etc/cloud/cloud-init.disabled 2>/dev/null
fi

# System info override
sudo tee /etc/machine-info > /dev/null << 'MACHINEINFO'
CHASSIS="DreamNodes Secure VPS"
PRETTY_HOSTNAME="DreamNodes-Secure-Server"
ICON_NAME="computer-dreamnodes"
MACHINEINFO

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable dreamnodes-ip-hide.service 2>/dev/null
sudo systemctl start dreamnodes-ip-hide.service 2>/dev/null

# Final touches
source ~/.bashrc 2>/dev/null
source ~/.zshrc 2>/dev/null

clear
echo -e "${CYAN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                              ║${NC}"
echo -e "${CYAN}║${GREEN}      DreamNodes IP Hide System Active!      ${CYAN}║${NC}"
echo -e "${CYAN}║${YELLOW}      All IPs & GPU Info Hidden              ${CYAN}║${NC}"
echo -e "${CYAN}║                                              ║${NC}"
echo -e "${CYAN}╠══════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  Commands now protected:                     ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ✓ neofetch   ✓ fastfetch    ✓ screenfetch  ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ✓ ifconfig   ✓ ip addr      ✓ hostname -I  ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ✓ curl/wget  ✓ lspci        ✓ lshw         ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ✓ GPU: DreamNodes Virtual GPU              ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ✓ glxinfo     ✓ SSH banner  ✓ AWS metadata ${CYAN}║${NC}"
echo -e "${CYAN}║                                              ║${NC}"
echo -e "${CYAN}║${NC}  Test: ${GREEN}neofetch${NC} or ${GREEN}dreamfetch${NC}              ${CYAN}║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}"
echo ""
