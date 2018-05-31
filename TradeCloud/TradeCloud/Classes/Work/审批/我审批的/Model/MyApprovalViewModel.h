//
//  MyApprovalViewModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyApprovalModel;

@interface MyApprovalViewModel : NSObject

@property (strong, nonatomic) MyApprovalModel *model;

@property (assign, nonatomic) CGRect titleFrame;

@property (assign, nonatomic) CGRect imFrame;

@property (assign, nonatomic) CGRect timeFrame;

@property (assign, nonatomic) CGRect desLaFrame;

@property (assign, nonatomic) CGRect valueLaFrame;

@property (assign, nonatomic) CGFloat cellHeight;

@end
