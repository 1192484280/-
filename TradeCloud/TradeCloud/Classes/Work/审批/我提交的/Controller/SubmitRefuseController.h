//
//  SubmitRefuseController.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@protocol SubmitRefuseControllerDelegate<NSObject>

- (void)selectedCell:(BOOL)showBottomView2;

@end

@interface SubmitRefuseController : BaseViewController

@property (weak, nonatomic) id<SubmitRefuseControllerDelegate> delegate;

@end
