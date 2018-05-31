//
//  PunchClockList.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "PunchClockList.h"
#import "PunchClockParameterModel.h"
#import "CompanyPunchInfo.h"

@implementation PunchClockList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.parameterModel = [[PunchClockParameterModel alloc] init];
        self.punchConfig = [[CompanyPunchInfo alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static PunchClockList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[PunchClockList alloc] init];
    });
    return sharedClient;
}



@end
