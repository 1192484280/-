//
//  ApprovalDetailStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApprovalDetailModel;

@interface ApprovalDetailStore : NSObject

/**
 * 申请详细
 * staff_id              员工id
 * approval_id           审批id
 */
- (void)getApprovalDetailWithStaff_id:(NSString *)staff_id andApproval_id:(NSString *)approval_id Success:(void(^)(ApprovalDetailModel *model))success Failure:(void(^)(NSError *error))failure;


/**
 * 审批操作（同意/拒绝）
 * staff_id          员工id
 * approval_id       审批id
 * status            status
 */
- (void)handleApprovalWithStaff_id:(NSString *)staff_id andApproval_id:(NSString *)approval_id andStatus:(NSString *)status Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;


/**
 * 催办
 */
- (void)urgeApprovalWithStaff_id:(NSString *)staff_id andMsg:(NSString *)msg Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;
@end
