//
//  OrderDetailModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSString *customer_id;

@property (nonatomic, copy) NSString *customer_name;

@property (nonatomic, copy) NSString *section_number;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *factory_id;

@property (nonatomic, copy) NSString *factory_name;

@property (nonatomic, copy) NSString *goods_type_id;

@property (nonatomic, copy) NSString *goods_type_name;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *note;

@end
