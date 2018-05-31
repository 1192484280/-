//
//  OrderAddParameterModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/13.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderAddParameterModel : NSObject

//***修改订单需要
@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *staff_id;

@property (nonatomic, copy) NSString *company_id;

@property (nonatomic, copy) NSString *department_id;

@property (nonatomic, copy) NSString *customer_id;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *factory_id;

@property (nonatomic, copy) NSString *goods_type_id;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSString *attachments;

@end
