//
//  CreatApprovalList.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/15.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatApprovalList : NSObject

@property (strong, nonatomic) NSMutableDictionary *approvalDic;

@property (strong, nonatomic) NSMutableArray *peopleArr;


+ (instancetype)sharedInstance;

@end
