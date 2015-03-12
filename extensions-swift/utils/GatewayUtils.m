//
//  GatewayUtils.m
//  UWifi
//
//  Created by 唐华嶓 on 12/23/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

#include <stdio.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <sys/sysctl.h>
#include "TargetConditionals.h"

#if TARGET_IPHONE_SIMULATOR
#include <net/route.h>
#define en "en1"
#else
#include "Route.h"
#define en "en0"
#endif

#include <net/if.h>
#include <string.h>
#include <arpa/inet.h>
#import "GatewayUtils.h"

#define CTL_NET         4               /* network, see socket.h */
#define ROUNDUP(a) \
((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

@implementation GatewayUtils

+ (NSString *)gatewayAddress {
    struct in_addr gatewayaddr;
    int r = [self getdefaultgateway:&(gatewayaddr.s_addr)];
    if(r >= 0){
        NSString *getted = [NSString stringWithFormat: @"%s", inet_ntoa(gatewayaddr)];
        return getted;
    }
    return NULL;
}

+ (int)getdefaultgateway:(in_addr_t *)addr {
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY};
    size_t l;
    char * buf, * p;
    struct rt_msghdr * rt;
    struct sockaddr * sa;
    struct sockaddr * sa_tab[RTAX_MAX];
    int i;
    int r = -1;
    if(sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
        return -1;
    }
    if(l > 0) {
        buf = malloc(l);
        if(sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
            return -1;
        }
        for(p=buf; p<buf+l; p+=rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for(i=0; i<RTAX_MAX; i++) {
                if(rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }

            if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sa_family == AF_INET
               && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {


                if(((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                    char ifName[128];
                    if_indextoname(rt->rtm_index,ifName);

                    if(strcmp(en, ifName) == 0){
                        *addr = ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                        r = 0;
                    }
                }
            }
        }
        free(buf);
    }
    return r;
}

@end
