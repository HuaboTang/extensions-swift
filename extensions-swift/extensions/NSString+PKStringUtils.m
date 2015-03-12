//
//  NSString+PKStringUtils.m
//  PiKey
//
//  Created by 唐华嶓 on 14-8-20.
//  Copyright (c) 2014年 piKey. All rights reserved.
//

#import "NSString+PKStringUtils.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>

/** 判定email的正则 */
const NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
const NSString *mobilePhoneNumRegex = @"[0-9]{11}";
@implementation NSString (PKStringUtils)

-(NSString *)lowerFirstChar {
    NSString *fLow = [[self substringWithRange:NSMakeRange(0, 1)] lowercaseString];
	return [fLow stringByAppendingString:[self substringFromIndex:1]];
}

- (NSString *) upperCaseFirstChar {
    NSString *fLow = [[self substringWithRange:NSMakeRange(0, 1)] uppercaseString];
	return [fLow stringByAppendingString:[self substringFromIndex:1]];
}

- (BOOL) isEmail {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isMobilePhoneNumber {
	NSPredicate *mobilePhoneNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobilePhoneNumRegex];
	return [mobilePhoneNumTest evaluateWithObject:self];
}

- (BOOL)isNotBlank {
	if (self.length > 0) {
		return YES;
	} else {
		return NO;
	}
}

+ (NSString *)localIPAddress {
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                break;
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

- (NSNumber *)toNumber {
	return [NSNumber numberWithInt:[self intValue]];
}

+ (NSString *) appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

- (NSArray *)split:(NSString *)ch {
	NSMutableArray *array;
	if (ch) {
		array = [[NSMutableArray alloc] init];
		NSRange range = [self rangeOfString:ch];
		if (range.location != NSNotFound) {
			[array addObject:[self substringWithRange:NSMakeRange(0, range.location)]];
			[array addObjectsFromArray:[[self substringFromIndex:range.location+range.length] split:ch]];
		} else {
			[array addObject:[self copy]];
		}
		return array;
	} else {
		return nil;
	}
}

+ (NSString *)filenameWithUrl:(NSURL *)url {
	NSArray *arry = [[url absoluteString] split:@"/"];
	return [arry lastObject];
}
@end
