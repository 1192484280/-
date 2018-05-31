//
//  SubmitStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitStore : NSObject

/**
 * 获取我的审批列表
 */
- (void)getSubListWithStaff_id:(NSString *)staff_id andStatus:(NSString *)status andPage:(NSInteger)page andKeywords:(NSString *)keywords Success:(void(^)(NSArray *listArr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure;

@end
