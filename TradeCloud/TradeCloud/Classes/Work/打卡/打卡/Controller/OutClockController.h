//
//  OutClockController.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@protocol OutClockControllerDelegate<NSObject>

- (void)onWorkPhoto:(UIButton *)btn;
- (void)onRemark:(UIButton *)btn;
- (void)onAddres:(UIButton *)btn;

@end

@interface OutClockController : BaseViewController

@property (weak, nonatomic) id<OutClockControllerDelegate>delegate;

@end
