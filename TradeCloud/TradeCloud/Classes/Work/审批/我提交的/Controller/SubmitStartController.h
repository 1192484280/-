//
//  SubmitStartController.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@protocol SubmitStartControllerDelegate<NSObject>

- (void)selectedCell:(BOOL)showBottomView2;

@end

@interface SubmitStartController : BaseViewController

@property (weak, nonatomic) id<SubmitStartControllerDelegate> delegate;

@end
