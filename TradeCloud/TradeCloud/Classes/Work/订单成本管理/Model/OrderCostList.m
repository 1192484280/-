//
//  OrderCostList.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostList.h"
#import "OrderCostParameterModel.h"

@implementation OrderCostList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.parameterModel = [[OrderCostParameterModel alloc] init];
    }
    
    return self;
}
+ (instancetype)sharedInstance{
    static OrderCostList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[OrderCostList alloc] init];
    });
    return sharedClient;
}

@end
