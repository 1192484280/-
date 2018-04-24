//
//  CustomerDetailModel.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/11.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerDetailModel.h"

@implementation CustomerDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"des" : @"description"};
}

@end
