//
//  OrderAlertView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderAlertViewDelegete<NSObject>

- (void)onCancelBtn;
- (void)onLeftBtn;
- (void)onRightBtn;

@end

@interface OrderAlertView : UIView

@property (weak, nonatomic) id<OrderAlertViewDelegete> delegate;

@end
