//
//  ManySelectHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ManySelectHeaderView.h"

@implementation ManySelectHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *la = [[UILabel alloc] initWithFrame:self.frame];
        la.textAlignment = NSTextAlignmentCenter;
        la.text = @"选择";
        la.textColor = FontColor;
        la.font = [UIFont systemFontOfSize:13];
        [self addSubview:la];
    }
    return self;
}

@end
