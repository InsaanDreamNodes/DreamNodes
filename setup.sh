#!/bin/bash
# ==========================================
# Dream Nodes Premium VPS Setup (v4 PRO)
# Interactive Menu Edition
# ==========================================

set -e

# ===== Colors =====
ORANGE="\e[38;5;208m"
CYAN="\e[38;5;51m"
GREEN="\e[38;5;82m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RED="\e[38;5;196m"
BLUE="\e[38;5;75m"
RESET="\e[0m"
BOLD="\e[1m"

# ===== Clear + Show Logo =====
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
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "       ${CYAN}${BOLD}High Performance • Secure • Reliable Infrastructure${RESET}"
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
}

# ===== Show Main Menu =====
show_menu() {
    echo -e "  ${BOLD}${GREEN}1.${RESET}  ${YELLOW}Starting Setup${RESET}          ${GRAY}— Initial VPS configuration & hardening${RESET}"
    echo -e "  ${BOLD}${GREEN}2.${RESET}  ${YELLOW}VPS Machine Making${RESET}       ${GRAY}— Install Dream Nodes Premium MOTD${RESET}"
    echo -e "  ${BOLD}${GREEN}3.${RESET}  ${YELLOW}Add New Commands${RESET}         ${GRAY}— Install dreamfetch & dream tools${RESET}"
    echo -e "  ${BOLD}${RED}4.${RESET}  ${YELLOW}Exit${RESET}                     ${GRAY}— Leave the installer${RESET}"
    echo ""
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -ne "  ${ORANGE}${BOLD}>>> ${RESET}"
}

# ===== Option 1: Starting Setup =====
run_starting_setup() {
    echo ""
    echo -e "${CYAN}${BOLD}[1/6]${RESET} ${GREEN}Updating system packages...${RESET}"
    apt-get update -y && apt-get upgrade -y

    echo -e "${CYAN}${BOLD}[2/6]${RESET} ${GREEN}Installing essential tools...${RESET}"
    apt-get install -y curl wget git htop net-tools unzip ufw fail2ban neofetch

    echo -e "${CYAN}${BOLD}[3/6]${RESET} ${GREEN}Configuring UFW Firewall...${RESET}"
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw --force enable

    echo -e "${CYAN}${BOLD}[4/6]${RESET} ${GREEN}Enabling Fail2Ban...${RESET}"
    systemctl enable fail2ban
    systemctl start fail2ban

    echo -e "${CYAN}${BOLD}[5/6]${RESET} ${GREEN}Configuring SSH security...${RESET}"
    sed -i 's/#PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
    sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
    sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/g' /etc/ssh/sshd_config
    systemctl restart ssh 2>/dev/null || true

    echo -e "${CYAN}${BOLD}[6/6]${RESET} ${GREEN}Setting timezone to Asia/Kolkata...${RESET}"
    timedatectl set-timezone Asia/Kolkata

    echo ""
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${GREEN}✅ Starting Setup complete!${RESET}"
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ===== Option 2: VPS Machine Making (Original MOTD Installer) =====
run_vps_machine_making() {
    echo ""
    echo -e "${CYAN}🔧 Installing Dream Nodes Premium MOTD...${RESET}"

    # Remove all old MOTD
    echo -e "${YELLOW}🧹 Removing old MOTD completely...${RESET}"
    chmod -x /etc/update-motd.d/* 2>/dev/null || true
    rm -f /etc/motd
    rm -f /var/run/motd
    rm -f /run/motd.dynamic

    if [ -f /etc/default/motd-news ]; then
        sed -i 's/ENABLED=1/ENABLED=0/g' /etc/default/motd-news
    fi

    # Configure PAM
    echo -e "${YELLOW}⚙  Configuring PAM...${RESET}"
    cp /etc/pam.d/sshd /etc/pam.d/sshd.bak 2>/dev/null || true
    cp /etc/pam.d/login /etc/pam.d/login.bak 2>/dev/null || true
    sed -i '/pam_motd.so/d' /etc/pam.d/sshd
    sed -i '/pam_motd.so/d' /etc/pam.d/login
    echo "session optional pam_exec.so stdout /etc/update-motd.d/00-DreamNodes" >> /etc/pam.d/sshd
    echo "session optional pam_exec.so stdout /etc/update-motd.d/00-DreamNodes" >> /etc/pam.d/login

    # Create MOTD Script
    echo -e "${YELLOW}✨ Creating Dream Nodes MOTD...${RESET}"
    cat << 'EOF' > /etc/update-motd.d/00-DreamNodes
#!/bin/bash

ORANGE="\e[38;5;208m"
CYAN="\e[38;5;51m"
GREEN="\e[38;5;82m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RESET="\e[0m"

NodesNAME=$(hostname)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERC=$((MEM_USED * 100 / MEM_TOTAL))

DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
IP=$(hostname -I | awk '{print $1}')
USERS=$(who | wc -l)
PROCS=$(ps -e --no-headers | wc -l)

echo ""
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

echo -e "${GREEN}🚀 Welcome to Dream Nodes Datacenter${RESET}"
echo -e "${CYAN}High Performance • Secure • Reliable Infrastructure${RESET}"
echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

printf "${CYAN}%-18s${RESET} %s\n" "Hostname:"   "$NodesNAME"
printf "${CYAN}%-18s${RESET} %s\n" "OS:"         "$OS"
printf "${CYAN}%-18s${RESET} %s\n" "Kernel:"     "$KERNEL"
printf "${CYAN}%-18s${RESET} %s\n" "Uptime:"     "$UPTIME"
printf "${CYAN}%-18s${RESET} %s\n" "CPU Usage:"  "$CPU"
printf "${CYAN}%-18s${RESET} %sMB / %sMB (${YELLOW}%s%%${RESET})\n" "Memory:" "$MEM_USED" "$MEM_TOTAL" "$MEM_PERC"
printf "${CYAN}%-18s${RESET} %s\n" "Disk:"       "$DISK"
printf "${CYAN}%-18s${RESET} %s\n" "Processes:"  "$PROCS"
printf "${CYAN}%-18s${RESET} %s\n" "Users:"      "$USERS"
printf "${CYAN}%-18s${RESET} %s\n" "IP:"         "$IP"

echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}Support:${RESET}  support@DreamNodes.in"
echo -e "${GREEN}Website:${RESET}  https://DreamNodes.in"
echo -e "${ORANGE}Dream Nodes — Premium Hosting Experience 💎${RESET}"
echo ""
EOF

    chmod +x /etc/update-motd.d/00-DreamNodes
    systemctl restart ssh 2>/dev/null || true

    echo ""
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${GREEN}✅ VPS Machine Making complete!${RESET}"
    echo -e "  ${GRAY}Reconnect SSH to see your Dream Nodes MOTD.${RESET}"
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ===== Option 3: Add New Commands =====
run_add_commands() {
    echo ""
    echo -e "${CYAN}🔧 Installing Dream Nodes Custom Commands...${RESET}"

    # ---- dreamfetch ----
    echo -e "${YELLOW}📦 Installing: dreamfetch${RESET}"
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
IP_PRIV=$(hostname -I | awk '{print $1}')
IP_PUB=$(curl -s --max-time 3 ifconfig.me 2>/dev/null || echo "N/A")
LOAD=$(uptime | awk -F'load average:' '{print $2}' | xargs)
PACKAGES=$(dpkg -l 2>/dev/null | grep -c '^ii' || echo "N/A")

echo ""
echo -e "${ORANGE}  ██████╗ ██████╗ ███████╗ █████╗ ███╗   ███╗"
echo -e "  ██╔══██╗██╔══██╗██╔════╝██╔══██╗████╗ ████║"
echo -e "  ██║  ██║██████╔╝█████╗  ███████║██╔████╔██║"
echo -e "  ██║  ██║██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║"
echo -e "  ██████╔╝██║  ██║███████╗██║  ██║██║ ╚═╝ ██║"
echo -e "  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝${RESET}"
echo ""
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${BOLD}${GREEN}Dream Nodes — VPS System Info${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
printf "  ${CYAN}%-16s${RESET} %s\n" "Hostname:"    "$HOSTNAME"
printf "  ${CYAN}%-16s${RESET} %s\n" "OS:"          "$OS"
printf "  ${CYAN}%-16s${RESET} %s\n" "Kernel:"      "$KERNEL"
printf "  ${CYAN}%-16s${RESET} %s\n" "Arch:"        "$ARCH"
printf "  ${CYAN}%-16s${RESET} %s\n" "Shell:"       "$SHELL_NAME"
printf "  ${CYAN}%-16s${RESET} %s\n" "Uptime:"      "$UPTIME"
printf "  ${CYAN}%-16s${RESET} %s\n" "CPU:"         "$CPU_MODEL"
printf "  ${CYAN}%-16s${RESET} %s cores\n" "CPU Cores:"   "$CPU_CORES"
printf "  ${CYAN}%-16s${RESET} ${YELLOW}%sMB${RESET} used / %sMB total\n" "Memory:"      "$MEM_USED" "$MEM_TOTAL"
printf "  ${CYAN}%-16s${RESET} ${YELLOW}%s${RESET} used / %s total\n" "Disk (/):"    "$DISK_USED" "$DISK_TOTAL"
printf "  ${CYAN}%-16s${RESET} %s\n" "Private IP:"  "$IP_PRIV"
printf "  ${CYAN}%-16s${RESET} %s\n" "Public IP:"   "$IP_PUB"
printf "  ${CYAN}%-16s${RESET} %s\n" "Load Avg:"    "$LOAD"
printf "  ${CYAN}%-16s${RESET} %s\n" "Packages:"    "$PACKAGES"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${ORANGE}DreamNodes.in 💎${RESET}"
echo ""
DREAMFETCH
    chmod +x /usr/local/bin/dreamfetch

    # ---- dream ----
    echo -e "${YELLOW}📦 Installing: dream${RESET}"
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

# ===== Progress Bar =====
bar() {
    local used=$1
    local total=$2
    local width=30
    local filled=$(( used * width / total ))
    local empty=$(( width - filled ))
    local pct=$(( used * 100 / total ))
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    if [ $pct -ge 90 ]; then
        echo -e "${RED}[${bar}] ${pct}%${RESET}"
    elif [ $pct -ge 70 ]; then
        echo -e "${YELLOW}[${bar}] ${pct}%${RESET}"
    else
        echo -e "${GREEN}[${bar}] ${pct}%${RESET}"
    fi
}

echo ""
echo -e "${ORANGE}${BOLD}  ⚡ Dream Nodes — Live Performance Monitor${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# CPU
CPU_IDLE=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{print $8}' | tr -d '%us,')
CPU_USED=$(echo "100 - $CPU_IDLE" | bc 2>/dev/null || echo "0")
CPU_USED_INT=${CPU_USED%.*}
[ -z "$CPU_USED_INT" ] && CPU_USED_INT=0
echo -ne "  ${CYAN}CPU Usage    ${RESET} "
bar $CPU_USED_INT 100
echo -e "  ${GRAY}  Core Count: $(nproc) | Load: $(uptime | awk -F'load average:' '{print $2}' | xargs)${RESET}"
echo ""

# RAM
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_CACHED=$(free -m | awk '/Mem:/ {print $6}')
echo -ne "  ${CYAN}RAM Usage    ${RESET} "
bar $MEM_USED $MEM_TOTAL
echo -e "  ${GRAY}  Used: ${MEM_USED}MB | Free: ${MEM_FREE}MB | Cached: ${MEM_CACHED}MB | Total: ${MEM_TOTAL}MB${RESET}"
echo ""

# DISK
while IFS= read -r line; do
    MOUNT=$(echo "$line" | awk '{print $6}')
    SIZE=$(echo "$line" | awk '{print $2}')
    USED_H=$(echo "$line" | awk '{print $3}')
    FREE_H=$(echo "$line" | awk '{print $4}')
    PCT=$(echo "$line" | awk '{print $5}' | tr -d '%')
    TOTAL_KB=$(df "$MOUNT" | awk 'NR==2{print $2}')
    USED_KB=$(df "$MOUNT" | awk 'NR==2{print $3}')
    echo -ne "  ${CYAN}Disk $MOUNT$(printf '%*s' $((10-${#MOUNT})) '')${RESET} "
    bar $USED_KB $TOTAL_KB
    echo -e "  ${GRAY}  Used: $USED_H | Free: $FREE_H | Total: $SIZE${RESET}"
    echo ""
done < <(df -h --output=source,size,used,avail,pcent,target | grep -E '^/dev/' | head -5)

# NETWORK
echo -e "  ${CYAN}Network I/O${RESET}"
NET_IFACE=$(ip route | grep default | awk '{print $5}' | head -1)
if [ -n "$NET_IFACE" ]; then
    RX1=$(cat /sys/class/net/$NET_IFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    TX1=$(cat /sys/class/net/$NET_IFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    sleep 1
    RX2=$(cat /sys/class/net/$NET_IFACE/statistics/rx_bytes 2>/dev/null || echo 0)
    TX2=$(cat /sys/class/net/$NET_IFACE/statistics/tx_bytes 2>/dev/null || echo 0)
    RX_RATE=$(( (RX2 - RX1) / 1024 ))
    TX_RATE=$(( (TX2 - TX1) / 1024 ))
    echo -e "  ${GRAY}  Interface: $NET_IFACE | ↓ Download: ${GREEN}${RX_RATE} KB/s${RESET}${GRAY} | ↑ Upload: ${YELLOW}${TX_RATE} KB/s${RESET}"
fi
echo ""

# TOP PROCESSES
echo -e "  ${CYAN}Top 5 Processes (by CPU)${RESET}"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
printf "  ${BOLD}%-8s %-10s %-8s %-8s %s${RESET}\n" "PID" "USER" "CPU%" "MEM%" "COMMAND"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "  %-8s %-10s %-8s %-8s %s\n", $2, $1, $3, $4, $11}'
echo ""

# UPTIME / TIME
echo -e "  ${CYAN}System Time  ${RESET} $(date '+%A, %d %B %Y — %H:%M:%S %Z')"
echo -e "  ${CYAN}Uptime       ${RESET} $(uptime -p | sed 's/up //')"
echo -e "${GRAY}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${ORANGE}Dream Nodes — Premium Hosting Experience 💎${RESET}"
echo ""
DREAM
    chmod +x /usr/local/bin/dream

    echo ""
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${GREEN}✅ Custom Commands Installed!${RESET}"
    echo ""
    echo -e "  ${YELLOW}dreamfetch${RESET}  ${GRAY}→ Shows full VPS specs & system info${RESET}"
    echo -e "  ${YELLOW}dream${RESET}       ${GRAY}→ Live performance monitor with progress bars${RESET}"
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ===== MAIN LOOP =====
while true; do
    show_logo
    echo -e "  ${BOLD}${ORANGE}Select an option:${RESET}"
    echo ""
    show_menu
    read -r choice

    case $choice in
        1)
            show_logo
            echo -e "  ${BOLD}${GREEN}» Starting Setup${RESET}"
            echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
            echo ""
            run_starting_setup
            echo ""
            echo -ne "  ${GRAY}Press Enter to return to menu...${RESET}"
            read -r
            ;;
        2)
            show_logo
            echo -e "  ${BOLD}${GREEN}» VPS Machine Making${RESET}"
            echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
            echo ""
            run_vps_machine_making
            echo ""
            echo -ne "  ${GRAY}Press Enter to return to menu...${RESET}"
            read -r
            ;;
        3)
            show_logo
            echo -e "  ${BOLD}${GREEN}» Add New Commands${RESET}"
            echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
            echo ""
            run_add_commands
            echo ""
            echo -ne "  ${GRAY}Press Enter to return to menu...${RESET}"
            read -r
            ;;
        4)
            show_logo
            echo -e "  ${ORANGE}👋 Exiting Dream Nodes Installer. Goodbye!${RESET}"
            echo ""
            exit 0
            ;;
        *)
            echo ""
            echo -e "  ${RED}❌ Invalid option. Please enter 1, 2, 3, or 4.${RESET}"
            sleep 1.5
            ;;
    esac
done
