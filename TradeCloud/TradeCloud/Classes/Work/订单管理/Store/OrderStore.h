//
//  OrderStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/11.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderParameterModel;
@class OrderDetailModel;
@class OrderAddParameterModel;

@interface OrderStore : NSObject

/**
 * 获取订单列表
 */
- (void)getListWithOrderParameterModel:(OrderParameterModel *)parameterModel Success:(void(^)(NSArray *listArr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;


/**
 * 订单详细
 */
- (void)getorderDetailWithId:(NSString *)order_id Success:(void(^)(OrderDetailModel *model))success Failure:(void(^)(NSError *error))failure;


/**
 * 删除订单
 */
- (void)deleteOrderWithId:(NSString *)order_id Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 添加订单
 */
- (void)addOrderWithParameterModel:(OrderAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

/**
 * 修改订单
 */
- (void)editOrderWithParameterModel:(OrderAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

@end
