#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <net/if.h>
#include <stdio.h>
#include <sys/ioctl.h>

int main() {
  printf("SIZE ifreq: 0x%lx\n", sizeof(struct ifreq));
  printf("SIZE int: 0x%lx\n", sizeof(int));
  printf("SIOCGIFINDEX: 0x%lx\n", SIOCGIFINDEX);
  printf("SIZE sockaddr_ll: 0x%lx\n", sizeof(struct sockaddr_ll));
  printf("ETH_P_ALL: 0x%lx\n", ETH_P_ALL);

  return 0;
}