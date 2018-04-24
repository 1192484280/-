//
//  HttpTool.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (NSError *)inspectError:(NSDictionary *)responseObject;

+ (NSString *)handleError:(NSError *)error;

@end
