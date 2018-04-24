//
//  OrderCostList.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderCostParameterModel;

@interface OrderCostList : NSObject

@property (strong, nonatomic) OrderCostParameterModel *parameterModel;

+ (instancetype)sharedInstance;

@end
