//
//  OrderCostParameterModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCostParameterModel : NSObject

@property (nonatomic, copy) NSString *staff_id;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *pay_type_id;


@end
