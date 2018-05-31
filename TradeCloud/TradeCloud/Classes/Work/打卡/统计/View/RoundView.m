//
//  RoundView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "RoundView.h"
#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation RoundView


- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
    
    [color set];
    

    UIBezierPath *mPath = [[UIBezierPath alloc] init];
    
    mPath.lineWidth = 13;//线条宽度
    
    mPath.lineCapStyle = kCGLineCapRound;//拐角
    
    mPath.lineJoinStyle = kCGLineCapRound;//终点
    
    [mPath addArcWithCenter:CGPointMake((self.width/2), 150) radius:90 startAngle:DEGREES_TO_RADIANS(180) endAngle:0 clockwise:YES];
    
    [mPath stroke];//边框填充
}


@end
