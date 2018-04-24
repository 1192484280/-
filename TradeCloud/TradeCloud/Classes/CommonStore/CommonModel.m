//
//  CommonModel.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid" : @"id",
             @"des":@"description"
             };
}

@end
