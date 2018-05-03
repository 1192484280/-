//
//  BaseViewController.h
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 带返回的navBar
 */
- (void)setNavBarWithTitle:(NSString *)title;

/**
 * MBProgress展示错误信息
 */
- (void)showMBPError:(NSString *)msg;



@end
