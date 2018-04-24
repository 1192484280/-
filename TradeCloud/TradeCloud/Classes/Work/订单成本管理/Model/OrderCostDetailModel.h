//
//  OrderCostDetailModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCostDetailModel : NSObject

@property (nonatomic, copy) NSString *cost_id;

@property (nonatomic, copy) NSString *customer_name;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *pay_name;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *pay_type_id;

@property (nonatomic, copy) NSString *pay_type_name;

@property (nonatomic, copy) NSString *pay_instructions;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSArray *attachments;

@end
