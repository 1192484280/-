//
//  PunchClockList.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PunchClockParameterModel;
@class CompanyPunchInfo;

@interface PunchClockList : NSObject

@property (strong, nonatomic) PunchClockParameterModel *parameterModel;

@property (strong, nonatomic) CompanyPunchInfo *punchConfig;

+ (instancetype)sharedInstance;

@end
