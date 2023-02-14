require 'socket'

INT_SIZE = 0x4 # sizeof(int)

# http://man7.org/linux/man-pages/man7/netdevice.7.html
# https://man7.org/linux/man-pages/man7/packet.7.html

# <net/if.h>
IFREQ_SIZE = 0x28 # sizeof(struct ifreq)

# <sys/ioctl.h>
SIOCGIFINDEX = 0x8933 # Retrieve the interface index of the interface

# <linux/if_packet.h>
SOCKADDR_LL_SIZE = 0x14

# <linux/if_ether.h>
ETH_P_ALL = 0x3 # Every packet

# Open a packet socket with raw socket type
socket = Socket.open(Socket::AF_PACKET, Socket::SOCK_RAW)

# Build struct ifreq and get ifindex
ifreq = ["lo"].pack("a#{IFREQ_SIZE}")
socket.ioctl(SIOCGIFINDEX, ifreq)
ifindex = ifreq[Socket::IFNAMSIZ,INT_SIZE]

# Build struct sockaddr_ll
sockaddr_ll =  [
  Socket::AF_PACKET, # unsigned short sll_family
  ETH_P_ALL,         # unsigned short sll_protocol
  ifindex,           # int sll_ifindex
].pack("ssa#{INT_SIZE}")
sockaddr_ll << [""].pack("a#{SOCKADDR_LL_SIZE-sockaddr_ll.size}")

# Bind 
socket.bind(sockaddr_ll)