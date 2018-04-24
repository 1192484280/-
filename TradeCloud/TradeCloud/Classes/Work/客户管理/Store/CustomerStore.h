//
//  CustomerStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomerDetailModel;

@interface CustomerStore : NSObject

/**
 * 客户列表
 */
- (void)getCustomerListWithPage:(NSString *)page andNum:(NSString *)num andCustomerName:(NSString *)customer_name success:(void(^)(NSArray *arr,BOOL haveMore))success failure:(void(^)(NSError *error))failure;

/**
 * 添加客户
 */
- (void)addCustomerWithName:(NSString *)name andDes:(NSString *)des Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

/**
 * 删除客户
 */
- (void)deleteCustomerWithId:(NSString *)customer_id success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 * 客户详细
 */
- (void)getCustomerDetailWithId:(NSString *)customer_id Success:(void(^)(CustomerDetailModel *model))success Failure:(void(^)(NSError *error))failure;

/**
 * 修改客户信息
 */
- (void)editCustomerInfoWithId:(NSString *)customer_id andName:(NSString *)name andDes:(NSString *)des Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


@end

