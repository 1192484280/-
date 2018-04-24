//
//  OrderCostStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderCostAddParameterModel;
@class OrderCostParameterModel;
@class OrderCostDetailModel;

@interface OrderCostStore : NSObject

/**
 * 订单成本列表
 */
- (void)getListWithParameterModel:(OrderCostParameterModel *)parameterModel Success:(void(^)(NSArray *listArr, NSString *total,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;

/**
 * 删除成本
 */
- (void)deleteWithId:(NSString *)cost_id Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 添加成本
 */
- (void)addOrderCostWithParameterModel:(OrderCostAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 修改成本
 */
- (void)editWithParameterModel:(OrderCostAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 订单成本详细
 */
- (void)getDetailWithId:(NSString *)cost_id Success:(void(^)(OrderCostDetailModel *model))success Failure:(void(^)(NSError *error))failure;

@end
