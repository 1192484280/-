//
//  SubmitStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "SubmitStore.h"
#import "MyApprovalModel.h"

@implementation SubmitStore

#pragma mark - 我的审批列表
- (void)getSubListWithStaff_id:(NSString *)staff_id andStatus:(NSString *)status andPage:(NSInteger)page andKeywords:(NSString *)keywords Success:(void(^)(NSArray *listArr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/approval/index",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:staff_id forKey:@"staff_id"];
    [dic setObject:status forKey:@"status"];
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
