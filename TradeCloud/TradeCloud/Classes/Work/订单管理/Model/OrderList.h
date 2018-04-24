//
//  OrderList.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderParameterModel.h"

@interface OrderList : NSObject

@property (strong, nonatomic) OrderParameterModel *parameterModel;

+ (instancetype)sharedInstance;

@end
