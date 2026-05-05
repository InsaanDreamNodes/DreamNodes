#!/bin/bash

# ==========================================
# Dream Nodes Premium VPS Setup (v5 PRO)
# Interactive Menu + IP Hide + Custom Cmds
# ==========================================

# ===== Colors =====
ORANGE="\e[38;5;208m"
CYAN="\e[38;5;51m"
GREEN="\e[38;5;82m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RED="\e[38;5;196m"
BLUE="\e[38;5;75m"
PURPLE="\e[38;5;135m"
RESET="\e[0m"
BOLD="\e[1m"
DIM="\e[2m"

# ===== Show Logo + Menu =====
show_logo() {
    clear
    echo -e "${ORANGE}"
    cat << "LOGO"
$$$$$$$\                                              $$\   $$\                 $$\                     
$$  __$$\                                             $$$\  $$ |                $$ |                    
$$ |  $$ | $$$$$$\   $$$$$$\   $$$$$$\  $$$$$$\$$$$\  $$$$\ $$ | $$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$$\ 
$$ |  $$ |$$  __$$\ $$  __$$\  \____$$\ $$  _$$  _$$\ $$ $$\$$ |$$  __$$\ $$  __$$ |$$  __$$\ $$  _____|
$$ |  $$ |$$ |  \__|$$$$$$$$ | $$$$$$$ |$$ / $$ / $$ |$$ \$$$$ |$$ /  $$ |$$ /  $$ |$$$$$$$$ |\$$$$$$\  
$$ |  $$ |$$ |      $$   ____|$$  __$$ |$$ | $$ | $$ |$$ |\$$$ |$$ |  $$ |$$ |  $$ |$$   ____| \____$$\ 
$$$$$$$  |$$ |      \$$$$$$$\ \$$$$$$$ |$$ | $$ | $$ |$$ | \$$ |\$$$$$$  |\$$$$$$$ |\$$$$$$$\ $$$$$$$  |
\_______/ \__|       \_______| \_______|\__| \__| \__|\__|  \__| \______/  \_______| \_______|\_______/ 
LOGO
    echo -e "${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "          ${CYAN}${BOLD}High Performance  •  Secure  •  Reliable Infrastructure${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
}

show_menu() {
    echo -e "   ${BOLD}${ORANGE}Select an option:${RESET}"
    echo ""
    echo -e "   ${BOLD}${GREEN} 1.${RESET}  ${YELLOW}Starting Setup${RESET}          ${DIM}${GRAY}— System update, firewall, SSH hardening${RESET}"
    echo -e "   ${BOLD}${GREEN} 2.${RESET}  ${YELLOW}VPS Machine Making${RESET}       ${DIM}${GRAY}— IP Hide + MOTD + Full Anonymity${RESET}"
    echo -e "   ${BOLD}${GREEN} 3.${RESET}  ${YELLOW}Add New Commands${RESET}         ${DIM}${GRAY}— Install dreamfetch & dream tools${RESET}"
    echo -e "   ${BOLD}${RED} 4.${RESET}  ${YELLOW}Clear All${RESET}                ${DIM}${GRAY}— Remove everything DreamNodes installed${RESET}"
    echo -e "   ${BOLD}${GRAY} 5.${RESET}  ${YELLOW}Exit${RESET}                     ${DIM}${GRAY}— Leave the installer${RESET}"
    echo ""
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -ne "   ${ORANGE}${BOLD}>>> ${RESET}"
}

# ===== Spinner =====
spinner() {
    local pid=$1
    local msg=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 10 ))
        printf "\r   ${CYAN}${spin:$i:1}${RESET}  ${msg}..."
        sleep 0.1
    done
    printf "\r   ${GREEN}✔${RESET}  ${msg}   \n"
}

# ===== Step Header =====
step() {
    echo ""
    echo -e "   ${BOLD}${CYAN}[$1]${RESET} ${GREEN}$2${RESET}"
}

# ===== Done Banner =====
done_banner() {
    echo ""
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "   ${GREEN}${BOLD}✅  $1${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
    echo -ne "   ${GRAY}Press Enter to return to menu...${RESET}"
    read -r
}

# ============================================================
# OPTION 1 — Starting Setup
# ============================================================
run_starting_setup() {
    show_logo
    echo -e "   ${BOLD}${GREEN}» Starting Setup${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""

    step "1/7" "Updating system packages..."
    (apt-get update -y && apt-get upgrade -y) > /tmp/dn_log 2>&1 &
    spinner $! "Updating packages"

    step "2/7" "Installing essential tools..."
    (apt-get install -y curl wget git htop net-tools unzip ufw fail2ban neofetch bc) >> /tmp/dn_log 2>&1 &
    spinner $! "Installing tools"

    step "3/7" "Configuring UFW Firewall..."
    (
        ufw default deny incoming
        ufw default allow outgoing
        ufw allow ssh
        ufw allow 80/tcp
        ufw allow 443/tcp
        ufw --force enable
    ) >> /tmp/dn_log 2>&1 &
    spinner $! "Configuring firewall"

    step "4/7" "Enabling Fail2Ban..."
    (systemctl enable fail2ban && systemctl start fail2ban) >> /tmp/dn_log 2>&1 &
    spinner $! "Starting Fail2Ban"

    step "5/7" "Hardening SSH config..."
    (
        sed -i 's/#PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
        sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
        sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/g' /etc/ssh/sshd_config
        systemctl restart ssh 2>/dev/null || true
    ) >> /tmp/dn_log 2>&1 &
    spinner $! "Hardening SSH"

    step "6/7" "Setting timezone to Asia/Kolkata..."
    (timedatectl set-timezone Asia/Kolkata) >> /tmp/dn_log 2>&1 &
    spinner $! "Setting timezone"

    step "7/7" "Setting custom DreamNodes bash prompt..."
    (
        grep -q "DreamNodes-prompt" ~/.bashrc || cat >> ~/.bashrc << 'PROMPTEOF'

# DreamNodes-prompt
PS1="\[\033[1;36m\]╭─\[\033[1;34m\]DreamNodes\[\033[0m\]@\[\033[1;32m\]\h\[\033[0m\] \[\033[1;33m\]\w\[\033[0m\]\n\[\033[1;36m\]╰─\[\033[1;35m\]➤\[\033[0m\] "
PROMPTEOF
    ) >> /tmp/dn_log 2>&1 &
    spinner $! "Setting bash prompt"

    done_banner "Starting Setup complete! Reconnect SSH to see new prompt."
}

# ============================================================
# OPTION 2 — VPS Machine Making (IP Hide System)
# ============================================================
run_vps_machine_making() {
    show_logo
    echo -e "   ${BOLD}${GREEN}» VPS Machine Making — IP Hide System v2.0${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""

    step "1/9" "Creating DreamNodes system directory..."
    (
        mkdir -p /etc/dreamnodes
        tee /etc/dreamnodes/sysinfo > /dev/null << 'EOF'
DreamNodes Secure Server
Protected VPS Environment
EOF
    ) &
    spinner $! "Creating system directory"

    step "2/9" "Setting hostname to DreamNodes-Secure-Server..."
    (
        hostnamectl set-hostname "DreamNodes-Secure-Server"
        hostnamectl set-chassis "DreamNodes VPS" 2>/dev/null || true
        hostnamectl set-deployment "DreamNodes Cloud" 2>/dev/null || true
        hostnamectl set-location "DreamNodes Data Center" 2>/dev/null || true
    ) &
    spinner $! "Setting hostname"

    step "3/9" "Overriding DMI/system identity files..."
    (
        tee /sys/devices/virtual/dmi/id/product_name <<< "DreamNodes Secure VPS" 2>/dev/null || true
        tee /sys/devices/virtual/dmi/id/product_version <<< "DN-2024-PRO" 2>/dev/null || true
        tee /sys/devices/virtual/dmi/id/sys_vendor <<< "DreamNodes Technologies" 2>/dev/null || true
        tee /sys/devices/virtual/dmi/id/chassis_vendor <<< "DreamNodes Cloud Infrastructure" 2>/dev/null || true
    ) &
    spinner $! "Overriding DMI identity"

    step "4/9" "Installing lspci GPU override..."
    (
        tee /usr/local/bin/lspci-dreamnodes > /dev/null << 'LSPCIEOF'
#!/bin/bash
/usr/bin/lspci "$@" 2>/dev/null | \
sed 's/Amazon.com, Inc. Device/DreamNodes Virtual GPU/g' | \
sed 's/VMware SVGA II Adapter/DreamNodes Virtual GPU/g' | \
sed 's/Cirrus Logic GD 5446/DreamNodes Virtual GPU/g' | \
sed 's/Red Hat, Inc. VirtIO GPU/DreamNodes Virtual GPU/g' | \
sed 's/NVIDIA Corporation/DreamNodes Technologies/g' | \
sed 's/Advanced Micro Devices, Inc. \[AMD\/ATI\]/DreamNodes Technologies/g' | \
sed 's/Intel Corporation/DreamNodes Technologies/g'
LSPCIEOF
        chmod +x /usr/local/bin/lspci-dreamnodes
    ) &
    spinner $! "Installing lspci override"

    step "5/9" "Setting up neofetch + fastfetch config..."
    (
        mkdir -p ~/.config/neofetch ~/.config/fastfetch

        cat > ~/.config/neofetch/config.conf << 'NEOFETCHCONFIG'
print_info() {
    info title
    info underline
    prin "╔══════════════════════════╗"
    prin "║  DreamNodes Secure VPS  ║"
    prin "╚══════════════════════════╝"
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Shell" shell
    info "Terminal" term
    info "CPU" cpu
    prin "$(color 2)GPU$(color 7)" "DreamNodes Virtual GPU"
    info "Memory" memory
    prin "$(color 2)Local IP$(color 7)" "IP Hidden By DreamNodes"
    prin "$(color 2)Public IP$(color 7)" "IP Hidden By DreamNodes"
    prin "$(color 2)Provider$(color 7)" "DreamNodes Cloud"
    prin "$(color 2)Protection$(color 7)" "Active - IP Masked"
    info cols
}
gpu_shorthand="off"
host_model="DreamNodes Secure VPS"
get_gpu() { echo "DreamNodes Virtual GPU"; }
NEOFETCHCONFIG

        cat > ~/.config/neofetch/gpu_override << 'GPUOVERRIDE'
get_gpu() { echo "DreamNodes Virtual GPU"; }
GPUOVERRIDE

        cat > ~/.config/fastfetch/config.jsonc << 'FASTFETCHCONFIG'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "display": { "separator": " ➜ " },
    "modules": [
        { "type": "title", "format": "DreamNodes Secure VPS" },
        { "type": "custom", "format": "╔════════════════════════════════════╗" },
        { "type": "custom", "format": "║    IP Hidden By DreamNodes        ║" },
        { "type": "custom", "format": "╚════════════════════════════════════╝" },
        "separator", "os", "host", "kernel", "uptime",
        "packages", "shell", "terminal", "cpu",
        { "type": "gpu", "format": "DreamNodes Virtual GPU" },
        "memory", "disk",
        { "type": "localip", "format": "IP Hidden By DreamNodes" },
        { "type": "publicip", "format": "IP Hidden By DreamNodes" },
        "break",
        { "type": "custom", "format": "🔒 Secured by DreamNodes Technologies" }
    ]
}
FASTFETCHCONFIG
    ) &
    spinner $! "Configuring neofetch/fastfetch"

    step "6/9" "Setting up screenfetch wrapper..."
    (
        mkdir -p ~/.config
        cat > ~/.config/screenfetch-wrapper << 'SCREENFETCH'
#!/bin/bash
/usr/bin/screenfetch "$@" 2>/dev/null | \
sed 's/Amazon.com, Inc. Devi/DreamNodes Secure VPS/g' | \
sed 's/Amazon EC2/DreamNodes Cloud/g' | \
sed 's/AWS/DreamNodes/g' | \
sed 's/VMware SVGA II Adapter/DreamNodes Virtual GPU/g' | \
sed 's/NVIDIA/DreamNodes/g' | \
sed 's/GPU:.*/GPU: DreamNodes Virtual GPU/' | \
sed 's/IP:.*/IP: IP Hidden By DreamNodes/' | \
sed 's/192\.168\.[0-9]\{1,3\}\.[0-9]\{1,3\}/IP Hidden By DreamNodes/g' | \
sed 's/10\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/IP Hidden By DreamNodes/g'
SCREENFETCH
        chmod +x ~/.config/screenfetch-wrapper
    ) &
    spinner $! "Setting up screenfetch wrapper"

    step "7/9" "Injecting shell functions into .bashrc + .zshrc..."
    (
        grep -q "DreamNodes IP Protection" ~/.bashrc || cat >> ~/.bashrc << 'BASHRCFUNCTIONS'

# ╔════════════════════════════════════╗
# ║   DreamNodes IP Protection v2.0  ║
# ╚════════════════════════════════════╝

alias neofetch='neofetch --config ~/.config/neofetch/config.conf --source ~/.config/neofetch/gpu_override 2>/dev/null'
alias fastfetch='fastfetch --config ~/.config/fastfetch/config.jsonc 2>/dev/null'
alias screenfetch='~/.config/screenfetch-wrapper 2>/dev/null'
alias lspci='/usr/local/bin/lspci-dreamnodes'

curl() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*ip-api*|*checkip*|*whatismyip*|*myip*)
            echo "IP Hidden By DreamNodes" ;;
        *metadata*|*169.254.169.254*)
            echo "DreamNodes Secure VPS - Metadata Protected" ;;
        *) command curl "$@" ;;
    esac
}
wget() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*checkip*|*whatismyip*)
            echo "IP Hidden By DreamNodes" ;;
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
    sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/inet IP Hidden By DreamNodes/g' | \
    sed 's/inet6 [a-f0-9:]*/inet6 IP Hidden By DreamNodes/g'
}
ip() {
    if [[ "$*" == *"addr"* ]] || [[ "$*" == *"address"* ]] || [[ "$*" == *" a"* ]]; then
        command ip "$@" 2>/dev/null | \
        sed 's/inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\/[0-9]*/inet IP Hidden By DreamNodes/g' | \
        sed 's/inet6 [a-f0-9:]*/inet6 IP Hidden By DreamNodes/g'
    else
        command ip "$@"
    fi
}
lshw() {
    command lshw "$@" 2>/dev/null | \
    sed 's/product:.*SVGA.*/product: DreamNodes Virtual GPU/g' | \
    sed 's/vendor:.*VMware.*/vendor: DreamNodes Technologies/g' | \
    sed 's/vendor:.*Amazon.*/vendor: DreamNodes Technologies/g'
}
glxinfo() {
    command glxinfo "$@" 2>/dev/null | \
    sed 's/OpenGL vendor string:.*/OpenGL vendor string: DreamNodes Technologies/g' | \
    sed 's/OpenGL renderer string:.*/OpenGL renderer string: DreamNodes Virtual GPU/g'
}
if [ -n "$SSH_CONNECTION" ]; then
    echo -e "\033[38;5;51m╔════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;5;51m║   \033[38;5;82mWelcome to DreamNodes Secure VPS\033[38;5;51m    ║\033[0m"
    echo -e "\033[38;5;51m║   \033[38;5;220mAll IPs Hidden By DreamNodes\033[38;5;51m        ║\033[0m"
    echo -e "\033[38;5;51m╚════════════════════════════════════════╝\033[0m"
fi
PS1="\[\033[1;36m\]╭─\[\033[1;34m\]DreamNodes\[\033[0m\]@\[\033[1;32m\]Secure-VPS\[\033[0m\] \[\033[1;33m\]\w\[\033[0m\]\n\[\033[1;36m\]╰─\[\033[1;35m\]➤\[\033[0m\] "
echo -e "\033[1;36m🔒 Active DreamNodes IP Protection | Type 'dreamfetch' for status\033[0m"
BASHRCFUNCTIONS

        if [ -f ~/.zshrc ]; then
            grep -q "DreamNodes IP Protection" ~/.zshrc || cat >> ~/.zshrc << 'ZSHRCFUNCTIONS'

# ╔════════════════════════════════════╗
# ║   DreamNodes IP Protection v2.0  ║
# ╚════════════════════════════════════╝

alias neofetch='neofetch --config ~/.config/neofetch/config.conf 2>/dev/null'
alias fastfetch='fastfetch --config ~/.config/fastfetch/config.jsonc 2>/dev/null'
alias screenfetch='~/.config/screenfetch-wrapper 2>/dev/null'
alias lspci='/usr/local/bin/lspci-dreamnodes'
curl() {
    case "$*" in
        *ifconfig.me*|*icanhazip*|*ipecho*|*ipinfo*|*ip-api*|*checkip*|*whatismyip*|*myip*)
            echo "IP Hidden By DreamNodes" ;;
        *) command curl "$@" ;;
    esac
}
hostname() {
    if [ "$1" = "-I" ] || [ "$1" = "-i" ]; then echo "IP Hidden By DreamNodes"
    else command hostname "$@"; fi
}
export PROMPT='%F{cyan}╭─%F{blue}DreamNodes%F{reset}@%F{green}Secure-VPS%F{reset} %F{yellow}%~%F{reset}
%F{cyan}╰─%F{magenta}➤%F{reset} '
ZSHRCFUNCTIONS
        fi
    ) &
    spinner $! "Injecting shell functions"

    step "8/9" "Installing systemd dreamnodes-ip-hide service..."
    (
        tee /etc/systemd/system/dreamnodes-ip-hide.service > /dev/null << 'SERVICEEOF'
[Unit]
Description=DreamNodes IP Hide Service
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'hostnamectl set-hostname DreamNodes-Secure-Server'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
SERVICEEOF
        systemctl daemon-reload
        systemctl enable dreamnodes-ip-hide.service 2>/dev/null
        systemctl start dreamnodes-ip-hide.service 2>/dev/null
    ) &
    spinner $! "Installing service"

    step "9/9" "Disabling AWS metadata + cloud-init..."
    (
        if command -v iptables &>/dev/null; then
            iptables -A OUTPUT -d 169.254.169.254 -j DROP 2>/dev/null || true
            iptables -A OUTPUT -d 169.254.170.2 -j DROP 2>/dev/null || true
        fi
        mkdir -p /etc/cloud 2>/dev/null
        tee /etc/cloud/cloud.cfg.d/99-dreamnodes.cfg > /dev/null << 'CLOUDCFG'
datasource_list: [ None ]
cloud_init_modules: []
cloud_config_modules: []
cloud_final_modules: []
CLOUDCFG
        if command -v cloud-init &>/dev/null; then
            touch /etc/cloud/cloud-init.disabled 2>/dev/null
        fi
        tee /etc/machine-info > /dev/null << 'MACHINEINFO'
CHASSIS="DreamNodes Secure VPS"
PRETTY_HOSTNAME="DreamNodes-Secure-Server"
ICON_NAME="computer-dreamnodes"
MACHINEINFO
    ) &
    spinner $! "Blocking AWS metadata"

    echo ""
    echo -e "${CYAN}  ╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}  ║                                                  ║${RESET}"
    echo -e "${CYAN}  ║${GREEN}${BOLD}      DreamNodes IP Hide System Active! 🔒      ${RESET}${CYAN}║${RESET}"
    echo -e "${CYAN}  ║${YELLOW}      All IPs & GPU Info Hidden              ${CYAN}      ║${RESET}"
    echo -e "${CYAN}  ║                                                  ║${RESET}"
    echo -e "${CYAN}  ╠══════════════════════════════════════════════════╣${RESET}"
    echo -e "${CYAN}  ║${RESET}  ${GREEN}✓${RESET} neofetch   ${GREEN}✓${RESET} fastfetch    ${GREEN}✓${RESET} screenfetch       ${CYAN}║${RESET}"
    echo -e "${CYAN}  ║${RESET}  ${GREEN}✓${RESET} ifconfig   ${GREEN}✓${RESET} ip addr      ${GREEN}✓${RESET} hostname -I       ${CYAN}║${RESET}"
    echo -e "${CYAN}  ║${RESET}  ${GREEN}✓${RESET} curl/wget  ${GREEN}✓${RESET} lspci        ${GREEN}✓${RESET} lshw              ${CYAN}║${RESET}"
    echo -e "${CYAN}  ║${RESET}  ${GREEN}✓${RESET} GPU: DreamNodes Virtual GPU                   ${CYAN}║${RESET}"
    echo -e "${CYAN}  ║${RESET}  ${GREEN}✓${RESET} AWS metadata blocked                          ${CYAN}║${RESET}"
    echo -e "${CYAN}  ╚══════════════════════════════════════════════════╝${RESET}"

    done_banner "VPS Machine Making complete! Re-login to activate."
}

# ============================================================
# OPTION 3 — Add New Commands (dreamfetch + dream)
# ============================================================
run_add_commands() {
    show_logo
    echo -e "   ${BOLD}${GREEN}» Add New Commands${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""

    step "1/2" "Installing dreamfetch..."
    (
        cat << 'DREAMFETCH' > /usr/local/bin/dreamfetch
#!/bin/bash

ORANGE="\e[38;5;208m"
CYAN="\e[38;5;51m"
GREEN="\e[38;5;82m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RESET="\e[0m"
BOLD="\e[1m"

HOSTNAME=$(hostname)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
ARCH=$(uname -m)
SHELL_NAME=$(basename "$SHELL")
CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
CPU_CORES=$(nproc)
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
PACKAGES=$(dpkg -l 2>/dev/null | grep -c '^ii' || echo "N/A")

echo ""
echo -e "${ORANGE}  ██████╗ ██████╗ ███████╗ █████╗ ███╗   ███╗"
echo -e "  ██╔══██╗██╔══██╗██╔════╝██╔══██╗████╗ ████║"
echo -e "  ██║  ██║██████╔╝█████╗  ███████║██╔████╔██║"
echo -e "  ██║  ██║██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║"
echo -e "  ██████╔╝██║  ██║███████╗██║  ██║██║ ╚═╝ ██║"
echo -e "  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝${RESET}"
echo ""
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${BOLD}${GREEN}Dream Nodes — VPS System Specs${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Hostname:"   "$HOSTNAME"
printf "  ${CYAN}%-16s${RESET} %s\n"   "OS:"         "$OS"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Kernel:"     "$KERNEL"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Arch:"       "$ARCH"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Shell:"      "$SHELL_NAME"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Uptime:"     "$UPTIME"
printf "  ${CYAN}%-16s${RESET} %s\n"   "CPU:"        "$CPU_MODEL"
printf "  ${CYAN}%-16s${RESET} %s cores\n" "CPU Cores:"  "$CPU_CORES"
printf "  ${CYAN}%-16s${RESET} ${YELLOW}%sMB${RESET} used / %sMB total\n" "Memory:"     "$MEM_USED" "$MEM_TOTAL"
printf "  ${CYAN}%-16s${RESET} ${YELLOW}%s${RESET} used / %s total\n"   "Disk (/):"   "$DISK_USED" "$DISK_TOTAL"
printf "  ${CYAN}%-16s${RESET} %s\n"   "IP:"         "IP Hidden By DreamNodes"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Public IP:"  "IP Hidden By DreamNodes"
printf "  ${CYAN}%-16s${RESET} %s\n"   "Packages:"   "$PACKAGES"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${ORANGE}DreamNodes.in 💎  |  Secure • Private • Fast${RESET}"
echo ""
DREAMFETCH
        chmod +x /usr/local/bin/dreamfetch
    ) &
    spinner $! "Installing dreamfetch"

    step "2/2" "Installing dream (live monitor)..."
    (
        cat << 'DREAM' > /usr/local/bin/dream
#!/bin/bash

ORANGE="\e[38;5;208m"
CYAN="\e[38;5;51m"
GREEN="\e[38;5;82m"
YELLOW="\e[38;5;220m"
RED="\e[38;5;196m"
GRAY="\e[38;5;245m"
RESET="\e[0m"
BOLD="\e[1m"

bar() {
    local used=$1 total=$2 width=32
    local filled=$(( used * width / total ))
    local empty=$(( width - filled ))
    local pct=$(( used * 100 / total ))
    local b=""
    for ((i=0;i<filled;i++)); do b+="█"; done
    for ((i=0;i<empty;i++)); do b+="░"; done
    if   [ $pct -ge 90 ]; then echo -e "${RED}[${b}] ${pct}%${RESET}"
    elif [ $pct -ge 70 ]; then echo -e "${YELLOW}[${b}] ${pct}%${RESET}"
    else                        echo -e "${GREEN}[${b}] ${pct}%${RESET}"
    fi
}

clear
echo ""
echo -e "${ORANGE}${BOLD}  ⚡ Dream Nodes — Live Performance Monitor${RESET}"
echo -e "  ${GRAY}$(date '+%A, %d %B %Y  |  %H:%M:%S %Z')${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# CPU
CPU_IDLE=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{print $8}' | tr -d '%us,id,')
CPU_USED=$(awk "BEGIN {printf \"%.0f\", 100 - ${CPU_IDLE:-0}}")
echo -ne "  ${CYAN}${BOLD}CPU Usage    ${RESET} "
bar "${CPU_USED:-0}" 100
LOAD=$(uptime | awk -F'load average:' '{print $2}' | xargs)
echo -e "  ${GRAY}  Cores: $(nproc)  |  Load avg: ${LOAD}${RESET}"
echo ""

# RAM
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_CACHE=$(free -m | awk '/Mem:/ {print $6}')
echo -ne "  ${CYAN}${BOLD}RAM Usage    ${RESET} "
bar "$MEM_USED" "$MEM_TOTAL"
echo -e "  ${GRAY}  Used: ${MEM_USED}MB  |  Free: ${MEM_FREE}MB  |  Cached: ${MEM_CACHE}MB  |  Total: ${MEM_TOTAL}MB${RESET}"
echo ""

# DISK - each partition
echo -e "  ${CYAN}${BOLD}Disk Usage${RESET}"
while IFS= read -r line; do
    MOUNT=$(echo "$line" | awk '{print $6}')
    SIZE=$(echo "$line" | awk '{print $2}')
    USED_H=$(echo "$line" | awk '{print $3}')
    FREE_H=$(echo "$line" | awk '{print $4}')
    USED_KB=$(df "$MOUNT" | awk 'NR==2{print $3}')
    TOTAL_KB=$(df "$MOUNT" | awk 'NR==2{print $2}')
    PAD=$(printf '%-10s' "$MOUNT")
    echo -ne "  ${GRAY}  ${PAD}${RESET}  "
    bar "$USED_KB" "$TOTAL_KB"
    echo -e "  ${GRAY}           Used: ${USED_H}  |  Free: ${FREE_H}  |  Total: ${SIZE}${RESET}"
done < <(df -h --output=source,size,used,avail,pcent,target | grep -E '^/dev/' | head -4)
echo ""

# NETWORK
NET_IFACE=$(ip route 2>/dev/null | grep default | awk '{print $5}' | head -1)
if [ -n "$NET_IFACE" ]; then
    RX1=$(cat /sys/class/net/$NET_IFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    TX1=$(cat /sys/class/net/$NET_IFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    sleep 1
    RX2=$(cat /sys/class/net/$NET_IFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    TX2=$(cat /sys/class/net/$NET_IFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    RX_RATE=$(( (RX2-RX1)/1024 ))
    TX_RATE=$(( (TX2-TX1)/1024 ))
    echo -e "  ${CYAN}${BOLD}Network I/O${RESET}"
    echo -e "  ${GRAY}  Interface: ${NET_IFACE}  |  ${GREEN}↓ ${RX_RATE} KB/s${RESET}${GRAY}  |  ${YELLOW}↑ ${TX_RATE} KB/s${RESET}"
    echo ""
fi

# TOP PROCESSES
echo -e "  ${CYAN}${BOLD}Top 5 Processes${RESET} ${GRAY}(by CPU)${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
printf "  ${BOLD}%-8s %-12s %-8s %-8s %s${RESET}\n" "PID" "USER" "CPU%" "MEM%" "COMMAND"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=6 {
    cmd=$11; if(length(cmd)>30) cmd=substr(cmd,1,30)"..."
    printf "  %-8s %-12s %-8s %-8s %s\n", $2, $1, $3, $4, cmd
}'
echo ""

# UPTIME
echo -e "  ${CYAN}${BOLD}System Uptime${RESET}  $(uptime -p | sed 's/up //')"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${ORANGE}Dream Nodes — Premium Hosting Experience 💎${RESET}"
echo ""
DREAM
        chmod +x /usr/local/bin/dream
    ) &
    spinner $! "Installing dream monitor"

    echo ""
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "   ${GREEN}${BOLD}✅  Commands installed!${RESET}"
    echo ""
    echo -e "   ${YELLOW}dreamfetch${RESET}  ${GRAY}→  Full VPS specs, hostname, CPU, RAM, Disk, IP${RESET}"
    echo -e "   ${YELLOW}dream${RESET}       ${GRAY}→  Live monitor: CPU/RAM bars, disk, network speed, top procs${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
    echo -ne "   ${GRAY}Press Enter to return to menu...${RESET}"
    read -r
}

# ============================================================
# OPTION 4 — Clear All (Uninstall Everything)
# ============================================================
run_clear_all() {
    show_logo
    echo -e "   ${BOLD}${RED}» Clear All — Remove DreamNodes Installations${RESET}"
    echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
    echo -e "   ${YELLOW}⚠  Yeh sab kuch hatayega jo DreamNodes ne install kiya he.${RESET}"
    echo -ne "   ${BOLD}Confirm karo (yes/no): ${RESET}"
    read -r confirm
    if [[ "$confirm" != "yes" ]]; then
        echo -e "\n   ${GRAY}Cancelled. Returning to menu...${RESET}"
        sleep 1.5
        return
    fi
    echo ""

    step "1/8" "Removing custom commands (dreamfetch, dream)..."
    (
        rm -f /usr/local/bin/dreamfetch
        rm -f /usr/local/bin/dream
        rm -f /usr/local/bin/lspci-dreamnodes
    ) &
    spinner $! "Removing custom commands"

    step "2/8" "Removing neofetch/fastfetch/screenfetch configs..."
    (
        rm -rf ~/.config/neofetch
        rm -rf ~/.config/fastfetch
        rm -f ~/.config/screenfetch-wrapper
    ) &
    spinner $! "Removing fetch configs"

    step "3/8" "Cleaning .bashrc DreamNodes entries..."
    (
        sed -i '/DreamNodes IP Protection/,/echo -e.*DreamNodes IP Protection/d' ~/.bashrc 2>/dev/null || true
        sed -i '/DreamNodes-prompt/,/^$/d' ~/.bashrc 2>/dev/null || true
        # Remove all DreamNodes function blocks
        python3 - << 'PYEOF' 2>/dev/null || true
import re, os
path = os.path.expanduser("~/.bashrc")
with open(path, "r") as f:
    content = f.read()
# Remove DreamNodes blocks
content = re.sub(r'\n# [╔╚║].*?DreamNodes.*?(?=\n[^#\n]|\Z)', '', content, flags=re.DOTALL)
with open(path, "w") as f:
    f.write(content)
PYEOF
    ) &
    spinner $! "Cleaning .bashrc"

    step "4/8" "Cleaning .zshrc DreamNodes entries..."
    (
        if [ -f ~/.zshrc ]; then
            sed -i '/DreamNodes IP Protection/,/export PROMPT.*DreamNodes/d' ~/.zshrc 2>/dev/null || true
        fi
    ) &
    spinner $! "Cleaning .zshrc"

    step "5/8" "Removing systemd service..."
    (
        systemctl stop dreamnodes-ip-hide.service 2>/dev/null || true
        systemctl disable dreamnodes-ip-hide.service 2>/dev/null || true
        rm -f /etc/systemd/system/dreamnodes-ip-hide.service
        systemctl daemon-reload 2>/dev/null || true
    ) &
    spinner $! "Removing systemd service"

    step "6/8" "Restoring hostname..."
    (
        hostnamectl set-hostname "ubuntu" 2>/dev/null || true
        rm -f /etc/machine-info 2>/dev/null || true
    ) &
    spinner $! "Restoring hostname"

    step "7/8" "Removing DreamNodes system files..."
    (
        rm -rf /etc/dreamnodes
        rm -f /etc/cloud/cloud.cfg.d/99-dreamnodes.cfg
        rm -f /etc/cloud/cloud-init.disabled 2>/dev/null || true
        rm -f /usr/share/hwdata/pci.ids 2>/dev/null || true
    ) &
    spinner $! "Removing system files"

    step "8/8" "Removing iptables rules..."
    (
        if command -v iptables &>/dev/null; then
            iptables -D OUTPUT -d 169.254.169.254 -j DROP 2>/dev/null || true
            iptables -D OUTPUT -d 169.254.170.2 -j DROP 2>/dev/null || true
        fi
    ) &
    spinner $! "Removing iptables rules"

    done_banner "Clear All done! All DreamNodes changes removed. Re-login to apply."
}

# ============================================================
# MAIN LOOP
# ============================================================
while true; do
    show_logo
    show_menu
    read -r choice

    case $choice in
        1) run_starting_setup ;;
        2) run_vps_machine_making ;;
        3) run_add_commands ;;
        4) run_clear_all ;;
        5)
            show_logo
            echo -e "   ${ORANGE}👋 Exiting Dream Nodes Installer. Goodbye!${RESET}"
            echo ""
            exit 0
            ;;
        *)
            echo ""
            echo -e "   ${RED}❌ Invalid option. Enter 1-5.${RESET}"
            sleep 1.2
            ;;
    esac
done
