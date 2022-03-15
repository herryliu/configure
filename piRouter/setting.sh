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

# Wifi/Ethernet Network Interface Mac
# old tp-link TL-WN321G
#wan=${1:-'wlxd0374576deb7'}
# new tp-link Archer T9UH
#wan=${1:-'wlx940c6de4f60c'}
# new tp-link T2U Nano
#wan=${1:-'wlxd0374554ec44'}
# Pi4 onboard Wifi
# mac: d0:37:45:6e:89:cd

# define mac address and interface name
wanMacInt="d0:37:45:6e:89:cd wan"
apMACInt="e4:5f:01:69:26:43 ap"
mon1MacInt="d0:37:45:54:ec:44 mon1"
# Don't leave space between interface definition
udevList="${wanMacInt},${apMACInt},${mon1MacInt}"

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
