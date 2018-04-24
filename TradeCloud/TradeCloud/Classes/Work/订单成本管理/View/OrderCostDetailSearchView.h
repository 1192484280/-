//
//  OrderCostDetailSearchView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCostDetailSearchViewDelegate<NSObject>

- (void)onSearchDetailSearchBtn;
- (void)onStartDateBtn:(UIButton *)btn;
- (void)onEndDateBtn:(UIButton *)btn;
- (void)onPayTypeBtn:(UIButton *)btn;
- (void)onPersonBtn:(UIButton *)btn;
@end

@interface OrderCostDetailSearchView : UIView

@property (weak, nonatomic) id<OrderCostDetailSearchViewDelegate> delegate;

@end
