//
//  CreatApprovalModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/7.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreatApprovalUrlModel.h"

@interface CreatApprovalModel : NSObject

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, strong) CreatApprovalUrlModel *url;


@end
