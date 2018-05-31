//
//  WaitHandleViewController.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@protocol WaitHandleViewControllerDelegate<NSObject>

- (void)selectedCell:(BOOL)showBottomView;

@end

@interface WaitHandleViewController : BaseViewController

@property (weak, nonatomic) id<WaitHandleViewControllerDelegate> delegate;

@end
