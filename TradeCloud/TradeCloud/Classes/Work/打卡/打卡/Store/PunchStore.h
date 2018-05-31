//
//  PunchStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CompanyPunchInfo;

@interface PunchStore : NSObject

/**
 * 获取打卡配置信息
 */
- (void)getPunchInfoWithCompany_id:(NSString *)company_id Success:(void(^)(CompanyPunchInfo *config))success Failure:(void(^)(NSError *error))failure;

/**
 * 打卡
 */
- (void)punchclockSuccess:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 打卡记录
 */
- (void)getPunchlistWithStaff_id:(NSString *)staff_id andDate:(NSString *)date andPage:(NSString *)page Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure;
@end
