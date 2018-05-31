//
//  CreatApprovalDataModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatApprovalDataModel : NSObject

@property (nonatomic, copy) NSString *field_id;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *label_name;

@property (nonatomic, copy) NSString *value_name;

@property (nonatomic, copy) NSString *default_value;

@property (nonatomic, copy) NSString *length;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *require;

@property (nonatomic, copy) NSArray *options;

@end
