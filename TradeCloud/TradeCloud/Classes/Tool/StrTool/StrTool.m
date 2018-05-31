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
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *string = [fmt stringFromDate:date];
    
    return string;
}

#pragma mark - 获取时间差
//+ (NSString *) compareCurrentTime:(NSString *)str
//
//{
//
//    //把字符串转为NSdate
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//    NSDate *timeDate = [dateFormatter dateFromString:str];
//
//    //得到与当前时间差
//
//    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
//
//    timeInterval = -timeInterval;
//
//    long temp = 0;
//
//    NSString *result;
//
//    if (timeInterval < 60) {
//
//        result = [NSString stringWithFormat:@"刚刚"];
//
//    }
//
//    else if((temp = timeInterval/60) <60){
//
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//
//    }
//
//    else if((temp = temp/60) <24){
//
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//
//    }
//
//    else if((temp = temp/24) <30){
//
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//
//    }
//
//    else if((temp = temp/30) <12){
//
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//
//    }
//
//    else{
//
//        temp = temp/12;
//
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//
//    }
//
//    return  result;
//
//}

+ (BOOL) compareCurrentTime:(NSString *)str

{
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    
    BOOL result = NO;
    
    if (timeInterval < 60) {
        
        result = NO;
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = NO;
        
    }
    
    else if((temp = temp/60) <24){
        
        //5：工作时长
        if (temp < 5) {
            
            result = NO;
        }else{
            result = YES;
        }
        
    }
    
    else if((temp = temp/24) <30){
        
        result = YES;
        
    }
    
    else if((temp = temp/30) <12){
        
        result = YES;
        
    }
    
    else{
        
        temp = temp/12;
        
        result = YES;
        
    }
    
    return  result;
    
}


@end
