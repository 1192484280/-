//
//  NSArray+json.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/19.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (json)

/**
 *  转换成JSON串字符串（有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toReadableJSONString;

@end
