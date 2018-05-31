//
//  CompanyPunchInfo.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyPunchInfo : NSObject

/**
 * 上班时间
 */
@property (nonatomic, copy) NSString *start_time;

/**
 * 下班时间
 */
@property (nonatomic, copy) NSString *end_time;

/**
 * 上班地点
 */
@property (nonatomic, copy) NSString *location;

/**
 * 网络类型
 */
@property (nonatomic, copy) NSString *network_type;

/**
 * wifi名称
 */
@property (nonatomic, copy) NSString *wifi_name;

@end
