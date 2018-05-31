//
//  MyApprovalModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyApprovalModel : NSObject

@property (nonatomic, copy) NSString *approval_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *add_time_zh;

@property (nonatomic, copy) NSArray *field_data;

@end
