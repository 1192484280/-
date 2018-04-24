//
//  OrderModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/11.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *goods_type_name;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *status_name;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *factory_name;

@property (nonatomic, copy) NSString *staff_id;

@end
