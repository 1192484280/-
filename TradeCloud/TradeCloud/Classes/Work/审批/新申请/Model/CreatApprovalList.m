//
//  CreatApprovalList.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/15.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CreatApprovalList.h"

@implementation CreatApprovalList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.approvalDic = [NSMutableDictionary dictionary];
       
        self.peopleArr = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)sharedInstance{
    
    static CreatApprovalList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedClient = [[CreatApprovalList alloc] init];
    });
    return sharedClient;
}

@end
