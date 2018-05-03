//
//  WorkClockController.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@protocol WorkClockControllerDelegate<NSObject>

- (void)onWorkPhoto:(UIButton *)btn;

@end

@interface WorkClockController : BaseViewController

@property (weak, nonatomic) id<WorkClockControllerDelegate>delegate;


@end
