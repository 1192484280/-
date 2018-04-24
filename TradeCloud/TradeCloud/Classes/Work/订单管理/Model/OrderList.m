//
//  OrderList.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderList.h"
#import "OrderParameterModel.h"

@implementation OrderList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.parameterModel = [[OrderParameterModel alloc] init];

    }
    
    return self;
}

+ (instancetype)sharedInstance{
    
    static OrderList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[OrderList alloc] init];
    });
    return sharedClient;
}
@end
