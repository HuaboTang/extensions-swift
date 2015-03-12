//
//  NSString+PKStringUtils.h
//  PiKey
//
//  Created by 唐华嶓 on 14-8-20.
//  Copyright (c) 2014年 piKey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKStringUtils)

/**
 * 小写字符串首字符
 */
- (NSString *)lowerFirstChar;

/**
 * 小写首字符
 */
- (NSString *)upperCaseFirstChar;

/**
 * 判断字符串是否为Email地址
 */
- (BOOL)isEmail;

/**
 * 判断字符串是否为手机号
 */
- (BOOL)isMobilePhoneNumber;

/**
 * Return YES if the String is not nil and empty, else return NO
 */
- (BOOL)isNotBlank;

+ (NSString *)localIPAddress;

- (NSNumber *)toNumber;

/**
 * 返回app版本号
 */
+ (NSString *) appVersion;

/**
 * Splits this string around matches of the given String
 * @param ch the delimiting NSString
 * @return the array of strings computed by splitting this string
 */
- (NSArray *) split:(NSString *)ch;

+ (NSString *)filenameWithUrl:(NSURL*)url;
@end
