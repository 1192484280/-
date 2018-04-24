//
//  OrderParameterModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/13.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderParameterModel : NSObject

@property (nonatomic, copy) NSString *staff_id;

@property (nonatomic, copy) NSString *customer_id;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *goods_type_id;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *factory_id;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *num;

@end
