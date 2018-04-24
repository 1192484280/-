//
//  LoginStore.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginStore : NSObject

- (void)loginWithUser:(NSString *)username andPass:(NSString *)password Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

@end
