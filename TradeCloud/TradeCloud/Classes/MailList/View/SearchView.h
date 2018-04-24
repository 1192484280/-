//
//  SearchView.h
//  TradeCloud
//
//  Created by zhangming on 2018/3/27.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate<NSObject>

- (void)ClickSearchBtn:(NSString *)title;

@end

@interface SearchView : UIView

@property (weak, nonatomic) id<SearchViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andplaceHoder:(NSString *)placeHoder;

@end
