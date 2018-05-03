//
//  CodeView.h
//  CodeDemo
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeFig:NSObject

@property (assign, nonatomic) NSInteger inputNum;

@property (assign, nonatomic) NSInteger fixedSpacing;

@property (assign, nonatomic) NSInteger leadSpacing;

@property (assign, nonatomic) NSInteger tailSpacing;

@property (assign, nonatomic) NSInteger borHeight;

@property (strong, nonatomic) UIColor *borColor;

@property (strong, nonatomic) UIFont *font;

@end

@interface CodeView : UIView

@property (nonatomic, copy) void(^finishBlock)(NSString *code);

- (instancetype)initWithFrame:(CGRect)frame andFig:(CodeFig *)codeFig;

@end
