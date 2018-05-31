//
//  PunchModel.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "PunchModel.h"

@implementation PunchModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"uid" : @"id",
             };
}

@end
