//
//  OrderCostSearchView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCostSearchViewDelegate<NSObject>

- (void)onSortBtn:(UIButton *)btn;
-(void)onDetailSearch;
- (void)onExport;
- (void)clickSearchBtn:(NSString *)title;


@end

@interface OrderCostSearchView : UIView


@property (nonatomic, strong) UILabel *total;

@property (weak, nonatomic) id<OrderCostSearchViewDelegate> delegate;

@end
