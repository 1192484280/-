//
//  NewApprovalStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/7.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CreatApprovalModel;

@interface NewApprovalStore : NSObject

/**
 * 获取模板列表
 */
- (void)getNewApplyModelListSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;


/**
 * 创建模板
 */
- (void)getModelDetailWithId:(NSString *)uid Success:(void(^)(CreatApprovalModel *model))success Failure:(void(^)(NSError *error))failure;


/**
 * 提交
 */
- (void)postApprovalWithId:(NSString *)templateId Dic:(NSDictionary *)dic Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

@end
