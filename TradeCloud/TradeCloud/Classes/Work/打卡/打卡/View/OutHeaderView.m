//
//  OutHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OutHeaderView.h"

@implementation OutHeaderView

#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor colorWithHexString:@"#F76B1C"];
    
    [color set];
    
    
    UIBezierPath *mPath = [[UIBezierPath alloc] init];
    
    mPath.lineWidth = 10;//线条宽度
    
    mPath.lineCapStyle = kCGLineCapRound;//拐角
    
    mPath.lineJoinStyle = kCGLineCapRound;//终点
    
    [mPath addArcWithCenter:self.center radius:95 startAngle:DEGREES_TO_RADIANS(360) endAngle:0 clockwise:YES];
    
    [mPath stroke];//边框填充
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *currentDate = [formatter stringFromDate:date];
    
    
    UILabel *la = [[UILabel alloc] init];
    la.size = CGSizeMake(200, 60);
    la.center = self.center;
    la.text = currentDate;
    la.font = [UIFont boldSystemFontOfSize:60];
    la.textAlignment = NSTextAlignmentCenter;
    [self addSubview:la];
    
    UILabel *la2 = [[UILabel alloc] init];
    la2.size = CGSizeMake(200, 40);
    la2.text = @"拍照打卡";
    la2.centerX = self.centerX;
    la2.y = CGRectGetMaxY(la.frame);
    la2.font = [UIFont systemFontOfSize:20];
    la2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:la2];
    
    UILabel *adreLa = [[UILabel alloc] init];
    adreLa.text = @"您已进入打卡范围";
    adreLa.textColor = [UIColor greenColor];
    adreLa.font = [UIFont boldSystemFontOfSize:25];
    adreLa.size = CGSizeMake(210, 30);
    adreLa.centerX = self.centerX;
    adreLa.textAlignment = NSTextAlignmentCenter;
    adreLa.y = self.height - 60;
    [self addSubview:adreLa];
    
    UIImageView *adreIm = [[UIImageView alloc] init];
    adreIm.image = [UIImage imageNamed:@"loufang"];
    [self addSubview:adreIm];
    [adreIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(adreLa.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(adreLa);
        
    }];
    
    UILabel *adreLa2 = [[UILabel alloc] init];
    adreLa2.text = @"当前位置";
    adreLa2.textColor = [UIColor greenColor];
    adreLa2.font = [UIFont systemFontOfSize:15];
    adreLa2.size = CGSizeMake(210, 15);
    adreLa2.centerX = self.centerX;
    adreLa2.textAlignment = NSTextAlignmentCenter;
    adreLa2.y = self.height - 20;
    [self addSubview:adreLa2];
}

@end
