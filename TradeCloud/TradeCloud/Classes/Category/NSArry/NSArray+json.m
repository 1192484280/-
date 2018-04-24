//
//  NSArray+json.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/19.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NSArray+json.h"

@implementation NSArray (json)

- (NSString *)toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

@end
