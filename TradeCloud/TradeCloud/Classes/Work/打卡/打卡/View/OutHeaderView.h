//
//  OutHeaderView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OutHeaderViewDelegate<NSObject>

- (void)photoBtn:(UIButton *)btn;
- (void)onRemarkBtn:(UIButton *)btn;
- (void)onAddresBtn:(UIButton *)btn;

@end

@interface OutHeaderView : UIView

@property (weak, nonatomic) id<OutHeaderViewDelegate>delegate;

@property (strong, nonatomic) NSString *location;

@end
