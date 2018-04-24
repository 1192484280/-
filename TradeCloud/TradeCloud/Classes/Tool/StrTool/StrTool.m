//
//  StrTool.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "StrTool.h"

@implementation StrTool

#pragma mark - 判断手机号
+(BOOL)checkMobilePhone:(NSString *)phoneNum
{
    NSString * MOBIL = @"^1(3[0-9]|4[579]|5[0-35-9]|7[01356]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if ([regextestmobile evaluateWithObject:phoneNum]) {
        return YES;
    }
    return NO;
}

#pragma mark - 获取当前时间
+ (NSString *)getNowTime{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *string = [fmt stringFromDate:date];
    
    return string;
}

@end
