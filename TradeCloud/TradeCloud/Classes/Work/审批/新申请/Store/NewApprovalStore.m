//
//  NewApprovalStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/7.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NewApprovalStore.h"
#import "NewApprovalModel.h"
#import "CreatApprovalModel.h"

@implementation NewApprovalStore

#pragma mark - 获取模板列表
- (void)getNewApplyModelListSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval_template/index",IP];
//        NSDictionary *dic = @{
//                              @"page":@"1",
//                              @"num":@"9999"
//                              };
    [HttpTool getUrlWithString:url parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [NewApprovalModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

/**
 * 创建模板
 */
- (void)getModelDetailWithId:(NSString *)uid Success:(void(^)(CreatApprovalModel *model))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval_template/detail",IP];
    
    NSDictionary *dic = @{
                          @"template_id":uid
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            CreatApprovalModel *model = [CreatApprovalModel mj_objectWithKeyValues:responseObject];
            success(model);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 提交
- (void)postApprovalWithId:(NSString *)templateId Dic:(NSDictionary *)dic Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval/add",IP];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:dic];
    [parameters setObject:[UserDefaultsTool getObjWithKey:@"staff_id"] forKey:@"staff_id"];
    [parameters setObject:templateId forKey:@"template_id"];
    
    [parameters setObject:@"1" forKey:@"status"];
    
    [HttpTool postUrlWithString:url parameters:parameters success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}
@end
