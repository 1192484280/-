//
//  WorkHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "WorkHeaderView.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>

#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface WorkHeaderView()

@property (strong, nonatomic) YYLabel *timeLa;
@property (strong, nonatomic) UILabel *titleLa;
@property (strong, nonatomic) UIButton *locationBtn;
@property (strong, nonatomic) UIButton *photoBtn;

@end

@implementation WorkHeaderView

- (YYLabel *)timeLa{
    
    if (!_timeLa) {
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *currentDate = [formatter stringFromDate:date];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:currentDate];
        one.yy_font = [UIFont boldSystemFontOfSize:50];
        one.yy_color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
        
        YYTextShadow *innerShadow = [YYTextShadow new];
        innerShadow.color = [UIColor blackColor];
        innerShadow.offset = CGSizeMake(0, 1);
        innerShadow.radius = 1;
        one.yy_textInnerShadow = innerShadow;
        
        _timeLa = [YYLabel new];
        _timeLa.attributedText = one;
        _timeLa.width = 200;
        _timeLa.height = 60;
        _timeLa.centerX = self.centerX;
        _timeLa.centerY = self.centerY - 70;
        _timeLa.textAlignment = NSTextAlignmentCenter;
        _timeLa.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    
    return _timeLa;
}

- (UIButton *)photoBtn{
    
    if (!_photoBtn) {
        
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.size = CGSizeMake(200, 40);
        [_photoBtn setTitle:@"拍照打卡" forState:UIControlStateNormal];
        [_photoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _photoBtn.centerX = self.centerX;
        _photoBtn.y = CGRectGetMaxY(self.timeLa.frame);
        _photoBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_photoBtn addTarget:self action:@selector(onPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _photoBtn;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"您未进入打卡范围";
        _titleLa.textColor = FontColor;
        _titleLa.font = [UIFont boldSystemFontOfSize:25];
        _titleLa.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLa;
}
- (UIButton *)locationBtn{
    
    if (!_locationBtn) {
        
        _locationBtn = [[UIButton alloc] init];
        [_locationBtn setTitle:@"定位中..." forState:UIControlStateNormal];
        [_locationBtn setTitleColor:FontColor forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _locationBtn;
}
- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
    
    [color set];
    
    
    UIBezierPath *mPath = [[UIBezierPath alloc] init];
    
    mPath.lineWidth = 10;//线条宽度
    
    mPath.lineCapStyle = kCGLineCapRound;//拐角
    
    mPath.lineJoinStyle = kCGLineCapRound;//终点
    
    [mPath addArcWithCenter:CGPointMake(self.centerX, self.centerY - 60) radius:95 startAngle:DEGREES_TO_RADIANS(360) endAngle:0 clockwise:YES];
    
    [mPath stroke];//边框填充
    
    [self addSubview:self.timeLa];
    
    [self addSubview:self.photoBtn];
    
    UIImageView *adreIm = [[UIImageView alloc] init];
    adreIm.image = [UIImage imageNamed:@"loufang"];
    [self addSubview:adreIm];
    
    [adreIm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self).offset(60);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(self);
        
    }];
    
    [self addSubview:self.titleLa];
    
    [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(adreIm.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    
    
    [self addSubview:self.locationBtn];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLa.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];

}

- (void)setLocation:(NSString *)location{
    
    [self.locationBtn setTitle:location forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    
    self.titleLa.text = title;
}

- (void)onPhotoBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBtn:)]) {
        
        [self.delegate photoBtn:btn];
    }
}
@end
