//
//  ApprovalDetailStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ApprovalDetailStore.h"
#import "ApprovalDetailModel.h"
#import "FieldDataModel.h"
#import "ProcessModel.h"



@implementation ApprovalDetailStore

#pragma mark - 申请详细
- (void)getApprovalDetailWithStaff_id:(NSString *)staff_id andApproval_id:(NSString *)approval_id Success:(void(^)(ApprovalDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval/detail",IP];
    
    NSDictionary *dic = @{
                          @"staff_id":staff_id,
                          @"approval_id":approval_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            ApprovalDetailModel *model = [ApprovalDetailModel mj_objectWithKeyValues:responseObject[@"url"]];
            
            NSArray *contentArr = [FieldDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"url"][@"field_data_content"]];
            
            NSArray *descArr = [FieldDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"url"][@"field_data_desc"]];
            
            NSArray *processArr = [ProcessModel mj_objectArrayWithKeyValuesArray:responseObject[@"url"][@"process_list"]];
            
            model.field_data_desc = descArr;
            model.field_data_content = contentArr;
            model.process_list = processArr;
            
            success(model);
        }else{
            
            failure(error);
        }
        
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 审批操作
- (void)handleApprovalWithStaff_id:(NSString *)staff_id andApproval_id:(NSString *)approval_id andStatus:(NSString *)status Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval/detailPost",IP];
    
    NSDictionary *dic = @{
                          @"staff_id":staff_id,
                          @"approval_id":approval_id,
                          @"status":status
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

#pragma mark - 催办
- (void)urgeApprovalWithStaff_id:(NSString *)staff_id andMsg:(NSString *)msg Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval/pushOne",IP];
    
    NSDictionary *dic = @{
                          @"staff_id":staff_id,
                          @"msg":msg,
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
@end
