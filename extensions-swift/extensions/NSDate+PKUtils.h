//
//  NSDate+PKUtils.h
//  PiKey
//
//  Created by 唐华嶓 on 14-8-29.
//  Copyright (c) 2014年 piKey. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YMD @"yyyy-MM-dd"
#define YMDHMS @"yyyy-MM-dd HH:mm:ss"

@interface NSDate (PKUtils)

/**
 * 获取格式化的日期字符串
 * @param formatExp 格式化表达式，默认为yyyy-MM-dd
 */
- (NSString *)formatedString:(NSString *)formatExp;

/**
 * 使用yyyy-MM-dd或者yyyy-MM-DD HH:mm:ss格式的字符串初始化
 */
+ (NSDate *) initWithString:(NSString *)string;

- (NSString *)UTCFormateDate;
@end