//
//  UserDefaultsTool.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsTool : NSObject

/**
 * 添加存储数据
 */
+ (void)setObj:(NSString *)obj andKey:(NSString *)key;

/**
 * 查找存储数据
 */
+ (NSString *)getObjWithKey:(NSString *)key;

/**
 * 删除存储数据
 */
+ (void)deleteObjWithKey:(NSString *)key;

@end
