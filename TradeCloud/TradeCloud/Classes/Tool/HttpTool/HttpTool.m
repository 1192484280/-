//
//  HttpTool.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HttpTool.h"
#import "HttpSessionManager.h"

//成功返回的标志
#define SuccessResponseCode 1

//网络回传失败域
#define ResponseFailureDomain @"ResponseFailureDomain"

@implementation HttpTool

+ (void)postUrlWithString:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    HttpSessionManager *manager = [HttpSessionManager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 15.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    HttpSessionManager *manager = [HttpSessionManager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 15.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSError *)inspectError:(NSDictionary *)responseObject {
    if ([responseObject[@"code"] integerValue] == 200) {
        return nil;
    } else {
        NSError *error = [NSError errorWithDomain:ResponseFailureDomain code:[responseObject[@"result"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"], NSLocalizedFailureReasonErrorKey:responseObject[@"msg"]}];
        return error;
    }
}

#pragma mark - 解析错误信息
+ (NSString *)handleError:(NSError *)error {
    if ([[error domain] isEqualToString:ResponseFailureDomain]) {
        
        return [error localizedDescription];
        
    } else {
        
        return @"网络错误，请检查您的网络配置";
    }
}

@end
