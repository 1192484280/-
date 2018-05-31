//
//  PunchStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "PunchStore.h"
#import "PunchClockList.h"
#import "PunchClockParameterModel.h"
#import "PunchModel.h"
#import "CompanyPunchInfo.h"

@implementation PunchStore

#pragma mark - 获取打卡配置信息
- (void)getPunchInfoWithCompany_id:(NSString *)company_id Success:(void(^)(CompanyPunchInfo *config))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/card_setting/detail",IP];
    
    NSDictionary *dic = @{
                          @"company_id":company_id,
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            CompanyPunchInfo *config = [CompanyPunchInfo mj_objectWithKeyValues:responseObject[@"data"]];
            success(config);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 打卡
- (void)punchclockSuccess:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/card_log/add",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[PunchClockList sharedInstance].parameterModel.company_id forKey:@"company_id"];
    [dic setObject:[PunchClockList sharedInstance].parameterModel.department_id forKey:@"department_id"];
    [dic setObject:[PunchClockList sharedInstance].parameterModel.staff_id forKey:@"staff_id"];
    [dic setObject:[PunchClockList sharedInstance].parameterModel.image forKey:@"image"];
    [dic setObject:[PunchClockList sharedInstance].parameterModel.location forKey:@"location"];
    [dic setObject:[PunchClockList sharedInstance].parameterModel.type_status forKey:@"type_status"];
    if ([PunchClockList sharedInstance].parameterModel.note.length > 0) {
        
        [dic setObject:[PunchClockList sharedInstance].parameterModel.note forKey:@"note"];
    
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


#pragma mark - 打卡列表
- (void)getPunchlistWithStaff_id:(NSString *)staff_id andDate:(NSString *)date andPage:(NSString *)page Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/card_log/index",IP];
    
    NSDictionary *dic = @{
                          @"staff_id":staff_id,
                          @"date_time":date,
                          @"page":page,
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            BOOL more = YES;
            
            NSArray *arr = [PunchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            if(!(arr.count > 0)){
                
                more = NO;
            }
            success(arr, more);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
