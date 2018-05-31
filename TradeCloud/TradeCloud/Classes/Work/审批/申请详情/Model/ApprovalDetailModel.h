//
//  ApprovalDetailModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApprovalDetailModel : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *template_name;

@property (nonatomic, copy) NSString *template_id;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *add_time_zh;

@property (nonatomic, copy) NSArray *field_data_desc;

@property (nonatomic, copy) NSArray *field_data_content;

@property (nonatomic, copy) NSArray *process_list;

@end
