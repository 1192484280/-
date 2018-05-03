//
//  CustomerStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerStore.h"
#import "CustomerModel.h"
#import "CustomerDetailModel.h"

@implementation CustomerStore

#pragma mark - 客户列表
- (void)getCustomerListWithPage:(NSString *)page andNum:(NSString *)num andCustomerName:(NSString *)customer_name success:(void(^)(NSArray *arr,BOOL haveMore))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/staff_customer/index",IP];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //[dic setObject:[UserDefaultsTool getObjWithKey:@"staff_id"] forKey:@"staff_id"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:num forKey:@"num"];
    
    if (customer_name) {
        
        [dic setObject:customer_name forKey:@"customer_name"];
    }
    

    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            BOOL more = YES;
            NSArray *arr = [CustomerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            if (!(arr.count > 0)) {
                
                more = NO;
            }
            success(arr,more);
        }
        
        
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

#pragma mark - 添加客户
- (void)addCustomerWithName:(NSString *)name andDes:(NSString *)des Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/staff_customer/add",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserDefaultsTool getObjWithKey:@"staff_id"] forKey:@"staff_id"];
    [dic setObject:[UserDefaultsTool getObjWithKey:@"company_id"] forKey:@"company_id"];
    [dic setObject:[UserDefaultsTool getObjWithKey:@"department_id"] forKey:@"department_id"];
    [dic setObject:name forKey:@"name"];
    
    if (des) {
        
        [dic setObject:des forKey:@"description"];
    }
    
    
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
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

#pragma mark - 删除客户
- (void)deleteCustomerWithId:(NSString *)customer_id success:(void(^)(void))success failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/staff_customer/del",IP];
    NSDictionary *dic = @{
                          @"customer_id":customer_id
                          };
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
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


#pragma mark - 客户详情
- (void)getCustomerDetailWithId:(NSString *)customer_id Success:(void(^)(CustomerDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/staff_customer/edit",IP];
    NSDictionary *dic = @{
                          @"customer_id":customer_id
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            CustomerDetailModel *model = [CustomerDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            success(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

#pragma mark - 修改客户信息
- (void)editCustomerInfoWithId:(NSString *)customer_id andName:(NSString *)name andDes:(NSString *)des Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/staff_customer/edit",IP];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:customer_id forKey:@"customer_id"];
    
    [dic setObject:name forKey:@"name"];
    
    if (des) {
        
        [dic setObject:des forKey:@"description"];
    }
    
    
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
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
