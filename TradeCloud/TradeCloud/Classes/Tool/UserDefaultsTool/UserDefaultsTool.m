//
//  UserDefaultsTool.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "UserDefaultsTool.h"

@implementation UserDefaultsTool

#pragma mark - 添加存储数据
+ (void)setObj:(NSString *)obj andKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:obj forKey:key];
    [ud synchronize];
    
}

#pragma mark - 查找存储数据
+ (NSString *)getObjWithKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *str = [ud objectForKey:key];
    return str;
}

#pragma mark - 删除存储数据
+ (void)deleteObjWithKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:key];
    [ud synchronize];
}

@end
