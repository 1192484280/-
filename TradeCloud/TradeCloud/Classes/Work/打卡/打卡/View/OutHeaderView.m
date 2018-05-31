//
//  OutHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OutHeaderView.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>

#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface OutHeaderView()

@property (strong, nonatomic) YYLabel *timeLa;
@property (strong, nonatomic) UIButton *titleBtn;
@property (strong, nonatomic) UIButton *remarkBtn;
@property (strong, nonatomic) UIButton *photoBtn;


@end

@implementation OutHeaderView

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

- (UIButton *)titleBtn{
    
    if (!_titleBtn) {
        
        _titleBtn = [[UIButton alloc] init];
        [_titleBtn setTitle:@"定位中..." forState:UIControlStateNormal];
        [_titleBtn setTitleColor:FontColor forState:UIControlStateNormal];
        _titleBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [_titleBtn addTarget:self action:@selector(onTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _titleLa.text = @"当前位置";
//        _titleLa.textColor = [UIColor colorWithHexString:@"#F8711C"];
//        _titleLa.font = [UIFont boldSystemFontOfSize:25];
//        _titleLa.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleBtn;
}



- (UIButton *)remarkBtn{
    
    if (!_remarkBtn) {
        
        _remarkBtn = [[UIButton alloc] init];
        [_remarkBtn setTitle:@"+ 添加备注" forState:UIControlStateNormal];
        [_remarkBtn setTitleColor:FontColor forState:UIControlStateNormal];
        _remarkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _remarkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_remarkBtn addTarget:self action:@selector(onRemarkBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _remarkBtn;
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
    
    [self addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(adreIm.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(25);
        make.centerX.equalTo(self);
    }];
    
    
    [self addSubview:self.remarkBtn];
    
    [self.remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    
}

- (void)setLocation:(NSString *)location{
    
    [self.titleBtn setTitle:location forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - 拍照
- (void)onPhotoBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBtn:)]) {
        
        [self.delegate photoBtn:btn];
    }
}

#pragma mark - 点击选择位置
- (void)onTitleBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onAddresBtn:)]) {
        
        [self.delegate onAddresBtn:btn];
    }
}

#pragma mark - 添加备注
- (void)onRemarkBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRemarkBtn:)]) {
        
        [self.delegate onRemarkBtn:btn];
    }
}
@end
