//
//  CommonStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonStore : NSObject

/**
 * 工厂列表
 */
- (void)getFactoryListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;

/**
 * 商品类型
 */
- (void)getGoodstypeListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;

/**
 * 支出类型
 */
- (void)getPayTypeListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;

/**
 * 员工列表
 */
- (void)getStaffListSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure;


/**
 * 上传图片
 */
- (void)upPhoto:(UIImage *)img Success:(void(^)(NSString *imgUrl))success Failure:(void(^)(NSError *error))failure;



@end
