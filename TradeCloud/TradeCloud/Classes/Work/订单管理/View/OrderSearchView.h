//
//  OrderSearchView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSearchViewDelegate<NSObject>

- (void)onSortBtn:(UIButton *)btn;
-(void)onDetailSearch;
- (void)onExport;
- (void)ClickSearchBtn:(NSString *)title;

@end

@interface OrderSearchView : UIView

@property (weak, nonatomic) id<OrderSearchViewDelegate> delegate;

@end
