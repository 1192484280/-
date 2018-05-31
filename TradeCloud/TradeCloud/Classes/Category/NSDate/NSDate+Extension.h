//
//  NSDate+Extension.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/25.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *传入时间与当前时间的差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)date;

/**
 *是否为今年
 */
- (BOOL)isThisYear;

/**
 *是否为今天
 */
- (BOOL)isToday;

/**
 *是否为昨天
 */
- (BOOL)isYestoday;

/**
 *返回只有年月日的时间
 */
- (NSDate *)dateWithYMD;


@end
