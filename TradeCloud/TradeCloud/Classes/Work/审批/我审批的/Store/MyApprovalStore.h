//
//  MyApprovalStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyApprovalStore : NSObject

/**
 * 我审批的列表
 */
- (void)getMyApprovalListWithStaff_id:(NSString *)staff_id type:(NSString *)type page:(NSInteger)page andKeywords:(NSString *)keywords Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure;




@end
