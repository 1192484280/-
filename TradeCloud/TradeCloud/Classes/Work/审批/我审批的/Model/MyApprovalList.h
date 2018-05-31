//
//  MyApprovalList.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyApprovalModel;

@interface MyApprovalList : NSObject

@property (strong, nonatomic) MyApprovalModel *selectedModel;

+ (instancetype)sharedInstance;

@end
