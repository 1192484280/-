//
//  MyApprovalList.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalList.h"
#import "MyApprovalModel.h"

@implementation MyApprovalList

- (instancetype)init{
    
    if (self == [super init]) {
        
        self.selectedModel = [[MyApprovalModel alloc] init];
    }
    
    return self;
}

+ (instancetype)sharedInstance{
    
    static MyApprovalList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MyApprovalList alloc] init];
    });
    return sharedClient;
}

@end
