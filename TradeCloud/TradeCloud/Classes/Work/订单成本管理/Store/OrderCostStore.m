//
//  OrderCostStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostStore.h"
#import "OrderCostModel.h"
#import "OrderCostAddParameterModel.h"
#import "OrderCostParameterModel.h"
#import "OrderCostDetailModel.h"

@implementation OrderCostStore

#pragma mark - 订单成本列表
- (void)getListWithParameterModel:(OrderCostParameterModel *)parameterModel Success:(void(^)(NSArray *listArr, NSString *total,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order_cost/index",IP];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
//    if (parameterModel.staff_id) {
//        
//        [dic setObject:parameterModel.staff_id forKey:@"staff_id"];
//    }
    
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)parameterModel.page] forKey:@"page"];
    [dic setObject:parameterModel.num forKey:@"num"];
    
    if (parameterModel.section_number) {
        
        [dic setObject:parameterModel.section_number forKey:@"section_number"];
    }
    
    if (parameterModel.start_time) {
        
        [dic setObject:parameterModel.start_time forKey:@"start_time"];
    }
    
    if (parameterModel.end_time) {
        
        [dic setObject:parameterModel.end_time forKey:@"end_time"];
    }
    
    if (parameterModel.pay_type_id) {
        [dic setObject:parameterModel.pay_type_id forKey:@"pay_type_id"];
    }
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            BOOL more = YES;
            NSArray *arr = [OrderCostModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            NSString *total = responseObject[@"url"][@"total_money"];
            
            if (!(arr.count > 0)) {
                
                more = NO;
            }
            success(arr,total,more);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 删除成本
- (void)deleteWithId:(NSString *)cost_id Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order_cost/del",IP];
    NSDictionary *dic = @{
                          @"cost_id":cost_id
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

#pragma mark - 添加成本
- (void)addOrderCostWithParameterModel:(OrderCostAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order_cost/add",IP];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (parameterModel.staff_id) {
        
        [dic setObject:parameterModel.staff_id forKey:@"staff_id"];
    }
    
    if (parameterModel.company_id) {
        
        [dic setObject:parameterModel.company_id forKey:@"company_id"];
    }
    
    if (parameterModel.department_id) {
        
        [dic setObject:parameterModel.department_id forKey:@"department_id"];
    }
    
    if (parameterModel.order_id) {
        
        [dic setObject:parameterModel.order_id forKey:@"order_id"];
    }
    
    if (parameterModel.pay_name) {
        
        [dic setObject:parameterModel.pay_name forKey:@"pay_name"];
    }
    
    if (parameterModel.money) {
        
        [dic setObject:parameterModel.money forKey:@"money"];
    }
    
    if (parameterModel.pay_time) {
        
        [dic setObject:parameterModel.pay_time forKey:@"pay_time"];
    }
    
    if (parameterModel.pay_type_id) {
        
        [dic setObject:parameterModel.pay_type_id forKey:@"pay_type_id"];
    }
    
    if (parameterModel.pay_instructions) {
        
        [dic setObject:parameterModel.pay_instructions forKey:@"pay_instructions"];
    }
    
    if (parameterModel.note) {
        
        [dic setObject:parameterModel.note forKey:@"note"];
    }
    
    if (parameterModel.attachments) {
        
        [dic setObject:parameterModel.attachments forKey:@"attachments"];
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

#pragma mark - 修改成本
- (void)editWithParameterModel:(OrderCostAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order_cost/edit",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (parameterModel.cost_id) {
        
        [dic setObject:parameterModel.cost_id forKey:@"cost_id"];
    }
    
    if (parameterModel.pay_name) {
        
        [dic setObject:parameterModel.pay_name forKey:@"pay_name"];
    }
    
    if (parameterModel.money) {
        
        [dic setObject:parameterModel.money forKey:@"money"];
    }
    
    if (parameterModel.pay_time) {
        
        [dic setObject:parameterModel.pay_time forKey:@"pay_time"];
    }
    
    if (parameterModel.pay_type_id) {
        
        [dic setObject:parameterModel.pay_type_id forKey:@"pay_type_id"];
    }
    
    if (parameterModel.pay_instructions) {
        
        [dic setObject:parameterModel.pay_instructions forKey:@"pay_instructions"];
    }
    
    if (parameterModel.note) {
        
        [dic setObject:parameterModel.note forKey:@"note"];
    }
    
    if (parameterModel.attachments) {
        
        [dic setObject:parameterModel.attachments forKey:@"attachments"];
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

#pragma mark - 订单成本详细
- (void)getDetailWithId:(NSString *)cost_id Success:(void(^)(OrderCostDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order_cost/edit",IP];
    
    NSDictionary *dic = @{
                          @"cost_id":cost_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            OrderCostDetailModel *model = [OrderCostDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            success(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}
@end
