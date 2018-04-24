//
//  SearchDetailView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDetailViewDelegate<NSObject>

- (void)onStartDateBtn:(UIButton *)btn;
- (void)onEndDateBtn:(UIButton *)btn;
- (void)onTypeBtn:(UIButton *)btn;
- (void)onStateBtn:(UIButton *)btn;
- (void)onCustomerBtn:(UIButton *)btn;
- (void)onFactoryBtn:(UIButton *)btn;
- (void)onSearchDetailSearchBtn;

@end

@interface SearchDetailView : UIView

@property (weak, nonatomic) id<SearchDetailViewDelegate> delegate;

@end
