# global variables for piRouter

# Binary path
EXECROOT="${HOME}/piRouter"
LOG='/usr/bin/logger'
KILL_ALL='/usr/bin/killall'
IW='/sbin/iw'
IP_CMD='/sbin/ip'
HOSTAPD='/usr/sbin/hostapd'
DNSMASQ='/usr/sbin/dnsmasq'
WPA_SUPPLICANT='/usr/sbin/wpa_supplicant'
WPA_CLI='/sbin/wpa_cli'
DHCLIENT='/sbin/dhclient'
IPTABLES='/usr/sbin/iptables'
AUTOSSH='/usr/bin/autossh'
PROWL="${EXECROOT}/push.sh"
IWD="/usr/libexec/iwd"
DHCPC="/usr/sbin/dhcpcd"
WPAPASS="/usr/bin/wpa_passphrase"
MACCHG="/usr/bin/macchanger"

# Wifi/Ethernet Network Interface Mac
# old tp-link TL-WN321G
#wan=${1:-'wlxd0374576deb7'}
# new tp-link Archer T9UH
#wan=${1:-'wlx940c6de4f60c'}
# new tp-link T2U Nano
#wan=${1:-'wlxd0374554ec44'}
# Pi4 onboard Wifi
# mac: d0:37:45:6e:89:cd

# wifi client mode iwd or wpa
WifiMode='wpa'
APSSID='4784'

# define mac address and interface name
# T2U 1
extMacInt0="d0:37:45:5b:8e:a9 ext0"
# T2U 2
extMacInt1="d0:37:45:6e:89:cd ext1"
# Old TP-Link
extMacInt2="d0:37:45:54:ec:44 ext2"

# ap interface can be multiple to include all boards we have
# since the board is unique, so won't have duplication
# ap mac e4:5f:01:69:26:43 for plastic board
apMACInt1="e4:5f:01:69:26:43 ap"
# ap mac dc:a6:32:58:61:f7 for metal board
apMACInt2="dc:a6:32:58:61:f7 ap"

# Don't leave space between interface definition
udevList="${apMACInt1},${apMACInt2},${extMacInt0},${extMacInt1},${extMacInt2}"

# Interface name and IP address
wan=${1:-'wan'}
ap=${2:-'ap'}
ap_net="192.168.11"
conf_dir="${EXECROOT}/conf"
otg_net="192.168.2"
otg_ip="${otg_net}.1/24"
eth_ip="192.168.50.2/24"
otg_int="usb0"
eth_int="eth0"
