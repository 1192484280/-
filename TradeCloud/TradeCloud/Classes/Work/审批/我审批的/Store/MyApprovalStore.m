//
//  MyApprovalStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalStore.h"
#import "MyApprovalModel.h"

@implementation MyApprovalStore

#pragma mark - 我审批的列表
- (void)getMyApprovalListWithStaff_id:(NSString *)staff_id type:(NSString *)type page:(NSInteger)page andKeywords:(NSString *)keywords Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval_record/index",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:staff_id forKey:@"staff_id"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    
    if (keywords) {
        
        [dic setObject:keywords forKey:@"keywords"];
    }
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if(error == nil){
            
            BOOL more = YES;
            
            NSArray *arr = [MyApprovalModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
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
