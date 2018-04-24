//
//  CustomerModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerModel : NSObject

@property (nonatomic, copy) NSString *staff_id;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *company_id;

@property (nonatomic, copy) NSString *customer_name;

@property (nonatomic, copy) NSString *company_name;

@property (nonatomic, copy) NSString *customer_id;

@property (nonatomic, copy) NSString *last_order_time;

@property (nonatomic, copy) NSString *total_order_num;

@end
