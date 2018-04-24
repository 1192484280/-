//
//  CommonStore.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CommonStore.h"
#import "CommonModel.h"
#import "StaffModel.h"
#import "HttpSessionManager.h"


@implementation CommonStore

#pragma mark - 工厂列表
- (void)getFactoryListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/index/getField",IP];
    NSDictionary *dic = @{
                          @"group":@"factory"
                          };
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [CommonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

#pragma mark - 商品类型
- (void)getGoodstypeListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/index/getField",IP];
    NSDictionary *dic = @{
                          @"group":@"goods_type"
                          };
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [CommonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 支出类型
- (void)getPayTypeListArrSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/index/getField",IP];
    NSDictionary *dic = @{
                          @"group":@"pay_type"
                          };
    [HttpTool postUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [CommonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


#pragma mark - 员工列表
- (void)getStaffListSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@v1/user_company_department_staff/index",IP];
    NSDictionary *dic = @{
                          @"page":@"1",
                          @"num":@"999999"
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [StaffModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

#pragma mark - 上传图片
- (void)upPhoto:(UIImage *)img Success:(void(^)(NSString *imgUrl))success Failure:(void(^)(NSError *error))failure{
    
    HttpSessionManager *manager = [HttpSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@v1/upload/upload",IP];
    NSDictionary *dic = @{
                          @"file":@"1"
                          };
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    //3. 图片二进制文件
    NSData *imageData = UIImageJPEGRepresentation(img, 0.7f);
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject[@"data"][@"url"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


@end
