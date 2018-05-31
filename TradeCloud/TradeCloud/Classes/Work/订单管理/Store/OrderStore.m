//
//  OrderStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/11.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderStore.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "OrderAddParameterModel.h"
#import "OrderParameterModel.h"

@implementation OrderStore

#pragma mark - 获取订单列表
- (void)getListWithOrderParameterModel:(OrderParameterModel *)parameterModel Success:(void(^)(NSArray *listArr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order/index",IP];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
//    if (parameterModel.staff_id) {
//
//        [dic setObject:parameterModel.staff_id forKey:@"staff_id"];
//    }
    
    if (parameterModel.page) {
        
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)parameterModel.page] forKey:@"page"];
    }
    
    if (parameterModel.num) {
        
        [dic setObject:parameterModel.num forKey:@"num"];
    }
    
    if (parameterModel.customer_id) {
        
        [dic setObject:parameterModel.customer_id forKey:@"customer_id"];
    }
    
    if (parameterModel.section_number) {
        
        [dic setObject:parameterModel.section_number forKey:@"section_number"];
    }
    
    if (parameterModel.goods_type_id) {
        
        [dic setObject:parameterModel.goods_type_id forKey:@"goods_type_id"];
    }
    
    if (parameterModel.status) {
        
        [dic setObject:parameterModel.status forKey:@"status"];
    }
    
    if (parameterModel.factory_id) {
        
        [dic setObject:parameterModel.factory_id forKey:@"factory_id"];
    }
    
    if (parameterModel.start_time) {
        
        [dic setObject:parameterModel.start_time forKey:@"start_time"];
    }
    
    if (parameterModel.end_time) {
        
        [dic setObject:parameterModel.end_time forKey:@"end_time"];
    }
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            BOOL more = YES;
            NSArray *arr = [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            if (!(arr.count > 0)) {
                
                more = NO;
            }
            
            success(arr,more);
            
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}


#pragma mark - 删除订单
- (void)deleteOrderWithId:(NSString *)order_id Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order/del",IP];
    NSDictionary *dic = @{
                          @"order_id":order_id
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

#pragma mark - 订单详细
- (void)getorderDetailWithId:(NSString *)order_id Success:(void(^)(OrderDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order/edit",IP];
    NSDictionary *dic = @{
                          @"order_id":order_id
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            OrderDetailModel *model = [OrderDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            success(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
    
}

#pragma mark - 添加订单
- (void)addOrderWithParameterModel:(OrderAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order/add",IP];
    
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
    
    if (parameterModel.customer_id) {
        
        [dic setObject:parameterModel.customer_id forKey:@"customer_id"];
    }
    
    if (parameterModel.section_number) {
        
        [dic setObject:parameterModel.section_number forKey:@"section_number"];
    }
    
    if (parameterModel.num) {
        
        [dic setObject:parameterModel.num forKey:@"num"];
    }
    
    if (parameterModel.factory_id) {
        
        [dic setObject:parameterModel.factory_id forKey:@"factory_id"];
    }
    
    if (parameterModel.goods_type_id) {
        
        [dic setObject:parameterModel.goods_type_id forKey:@"goods_type_id"];
    }
    
    if (parameterModel.status) {
        
        [dic setObject:parameterModel.status forKey:@"status"];
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
       
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        failure(error);
    }];
    
}

#pragma mark - 修改订单
- (void)editOrderWithParameterModel:(OrderAddParameterModel *)parameterModel Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/order/edit",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (parameterModel.order_id) {
        
        [dic setObject:parameterModel.order_id forKey:@"order_id"];
    }
    
    if (parameterModel.staff_id) {
        
        [dic setObject:parameterModel.staff_id forKey:@"staff_id"];
    }
    
    if (parameterModel.company_id) {
        
        [dic setObject:parameterModel.company_id forKey:@"company_id"];
    }
    
    if (parameterModel.department_id) {
        
        [dic setObject:parameterModel.department_id forKey:@"department_id"];
    }
    
    if (parameterModel.customer_id) {
        
        [dic setObject:parameterModel.customer_id forKey:@"customer_id"];
    }
    
    if (parameterModel.section_number) {
        
        [dic setObject:parameterModel.section_number forKey:@"section_number"];
    }
    
    if (parameterModel.num) {
        
        [dic setObject:parameterModel.num forKey:@"num"];
    }
    
    if (parameterModel.factory_id) {
        
        [dic setObject:parameterModel.factory_id forKey:@"factory_id"];
    }
    
    if (parameterModel.goods_type_id) {
        
        [dic setObject:parameterModel.goods_type_id forKey:@"goods_type_id"];
    }
    
    if (parameterModel.status) {
        
        [dic setObject:parameterModel.status forKey:@"status"];
    }
    
    if (parameterModel.note) {
        
        [dic setObject:parameterModel.note forKey:@"note"];
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
