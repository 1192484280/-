//
//  ProcessModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessModel : NSObject

@property (nonatomic, copy) NSString *approval_staff_id;

@property (nonatomic, copy) NSString *staff_name;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *wait_checker_id;

@end
