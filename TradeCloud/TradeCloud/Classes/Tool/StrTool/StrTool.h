//
//  StrTool.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrTool : NSObject

/**
 * 检测手机号
 */
+(BOOL)checkMobilePhone:(NSString *)phoneNum;

/**
 * 获取时间
 */
+ (NSString *)getNowTime;

@end
