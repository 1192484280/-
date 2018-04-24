//
//  LoginStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "LoginStore.h"

@implementation LoginStore

- (void)loginWithUser:(NSString *)username andPass:(NSString *)password Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/index/login",IP];
    
    //测试账号：yikai
    //测试密码：123456
    
    NSDictionary *dic = @{
                          @"username":username,
                          @"password":password
                          };
    
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            //缓存userId;
            [UserDefaultsTool setObj:responseObject[@"data"][@"staff_id"] andKey:@"staff_id"];
            [UserDefaultsTool setObj:responseObject[@"data"][@"company_id"] andKey:@"company_id"];
            [UserDefaultsTool setObj:responseObject[@"data"][@"department_id"] andKey:@"department_id"];
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

@end
