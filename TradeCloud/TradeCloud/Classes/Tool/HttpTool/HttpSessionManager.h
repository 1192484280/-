//
//  HttpSessionManager.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;

@end
