#!/bin/bash
# Menu For Script
# Edition : Stable Edition V1.0
# Auther  : Ghafoor Ali
# (C) Copyright 2021-2023 By Ghafoor Ali
# =========================================
#!/bin/bash
clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="XdrgVPN"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-epro | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

clear
clear
function add-host(){
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e " ${COLBG1}               • ADD VPS HOST •                ${NC}"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -rp "  New Host Name : " -e host
echo ""
if [ -z $host ]; then
echo -e "  [INFO] Type Your Domain/sub domain"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
else
echo "IP=$host" > /var/lib/ssnvpn-pro/ipvps.conf
echo ""
echo "  [INFO] Dont forget to renew cert"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to Renew Cret"
crtxray
fi
}
clear
clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                     ⇱ INFORMATION VPS ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo -e "□ Sever Uptime        = $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "□ Current Time        = $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "□ Operating System    = $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) )"
echo -e "□ Current Domain      = $( cat /etc/xray/domain )"
echo -e "□ Server IP           = ${IP}"
echo -e "□ Clients Name        = $Name"
echo -e "□ Exfire Script VPS   = $Exp"
echo -e "□ Time Reboot VPS     = 00:00 ${GREEN}( 12 o'ckock daily)${NC}"
echo -e "□ License Limit       = VPS ${GREEN}( Register IP VPS )${NC}"
echo -e "□ AutoScript By Dev   = ${GREEN}( Ghafoor Ali )${NC}"
exp=$( curl -s https://raw.githubusercontent.com/ghafoorali176/izinvps/ipuk/ip | grep -w $IP | cut -d ' ' -f 3 )
now=`date -d "0 days" +"%Y-%m-%d"`
expired_date=$(date -d "$exp" +%s)
now_date=$(date -d "$now" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
if [[ $sisa_hari -lt 0 ]]; then
    
    echo -e "${EROR} Your IP Is Expired ( $sisa_hari Days )"
    exit 1
else
    echo ""
fi
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                     ⇱ STATUS By Ghafoor Ali ⇲                       \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
echo -e " [ ${GREEN}SSH WebSocket${NC} : ${GREEN}ON ${NC}]     [ ${GREEN}XRAY${NC} : ${status_xray} ]      [ ${GREEN}NGINX${NC} : ${status_nginx} ]"
echo -e "$COLOR1─────────────────────────────────────────────────────────────${NC}"
echo -e "\033[1;93m│\033[0m ${BOLD}${YELLOW}SSH  VMESS   VLESS  TROJAN   SHADOWSOCKS$NC"
echo -e "\033[1;93m│\033[0m ${Blue} $ssh1     $vmc       $vlx      $trx           $ssx   $NC"
echo -e "$COLOR1└────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                     ⇱ MENU By Ghafoor Ali ⇲                         \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
echo -e "  ${COLOR1}[01]${NC} • [${YELLOW}Menu${NC}] SSHWS     ${COLOR1}[08]${NC} • [${YELLOW}Menu${NC}] THEME     $COLOR1 $NC"
echo -e "  ${COLOR1}[02]${NC} • [${YELLOW}Menu${NC}] VMESS     ${COLOR1}[09]${NC} • [${YELLOW}Menu${NC}] BACKUP    $COLOR1 $NC"
echo -e "  ${COLOR1}[03]${NC} • [${YELLOW}Menu${NC}] VLESS     ${COLOR1}[10]${NC} • [${YELLOW}Menu${NC}] SETTINGS  $COLOR1 $NC"
echo -e "  ${COLOR1}[04]${NC} • [${YELLOW}Menu${NC}] TROJAN    ${COLOR1}[11]${NC} • INFORMATION      $COLOR1 $NC"
echo -e "  ${COLOR1}[05]${NC} • [${YELLOW}Menu${NC}] SS WS     ${COLOR1}[12]${NC} • ADD HOST/DOMAIN  $COLOR1 $NC"
echo -e "  ${COLOR1}[06]${NC} • [${YELLOW}Menu${NC}] SET DNS   ${COLOR1}[13]${NC} • RENEW CERT       $COLOR1 $NC"
echo -e "  ${COLOR1}[07]${NC} • [${YELLOW}Menu${NC}] LOAD VPS  ${COLOR1}[14]${NC} • CHANGE PW VPS  $COLOR1 $NC"
echo -e " ${RED}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                     ⇱ Ghafoor Ali VPN PROJECT ⇲                      \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo -e ""

echo -ne " Select menu : "; read opt
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; menu-vmess ;;
03 | 3) clear ; menu-vless ;;
04 | 4) clear ; menu-trojan ;;
05 | 5) clear ; menu-ss ;;
06 | 6) clear ; menu-dns ;;
06 | 7) clear ; gotop ;;
07 | 8) clear ; menu-theme ;;
09 | 9) clear ; menu-backup ;;
10) clear ; menu-set ;;
11) clear ; info ;;
12) clear ; add-host ;;
13) clear ; crtxray ;;
14) clear ; passwd ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
