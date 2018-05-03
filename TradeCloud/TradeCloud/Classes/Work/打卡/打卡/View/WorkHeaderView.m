//
//  WorkHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "WorkHeaderView.h"

#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface WorkHeaderView()

@property (strong, nonatomic) UILabel *timeLa;
@property (strong, nonatomic) UILabel *titleLa;
@property (strong, nonatomic) UIButton *locationBtn;
@property (strong, nonatomic) UIButton *photoBtn;

@end

@implementation WorkHeaderView

- (UILabel *)timeLa{
    
    if (!_timeLa) {
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *currentDate = [formatter stringFromDate:date];
        
        _timeLa = [[UILabel alloc] init];
        _timeLa.size = CGSizeMake(200, 60);
        _timeLa.centerX = self.centerX;
        _timeLa.centerY = self.centerY - 40;
        _timeLa.text = currentDate;
        _timeLa.font = [UIFont boldSystemFontOfSize:50];
        _timeLa.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timeLa;
}

- (UIButton *)photoBtn{
    
    if (!_photoBtn) {
        
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.size = CGSizeMake(200, 40);
        [_photoBtn setTitle:@"拍照打卡" forState:UIControlStateNormal];
        [_photoBtn setTitleColor:FontColor forState:UIControlStateNormal];
        _photoBtn.centerX = self.centerX;
        _photoBtn.y = CGRectGetMaxY(self.timeLa.frame);
        _photoBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_photoBtn addTarget:self action:@selector(onPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _photoBtn;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"您未进入打卡范围";
        _titleLa.textColor = [UIColor greenColor];
        _titleLa.font = [UIFont boldSystemFontOfSize:25];
        _titleLa.size = CGSizeMake(210, 30);
        _titleLa.centerX = self.centerX;
        _titleLa.textAlignment = NSTextAlignmentCenter;
        _titleLa.y = self.height - 90;
    }
    
    return _titleLa;
}
- (UIButton *)locationBtn{
    
    if (!_locationBtn) {
        
        _locationBtn = [[UIButton alloc] init];
        [_locationBtn setTitle:@"当前位置" forState:UIControlStateNormal];
        [_locationBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _locationBtn.size = CGSizeMake(kScreenWidth, 15);
        _locationBtn.centerX = self.centerX;
        _locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _locationBtn.y = CGRectGetMaxY(self.titleLa.frame) + 20;
    }
    
    return _locationBtn;
}
- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor colorWithHexString:@"#F76B1C"];
    
    [color set];
    
    
    UIBezierPath *mPath = [[UIBezierPath alloc] init];
    
    mPath.lineWidth = 10;//线条宽度
    
    mPath.lineCapStyle = kCGLineCapRound;//拐角
    
    mPath.lineJoinStyle = kCGLineCapRound;//终点
    
    [mPath addArcWithCenter:CGPointMake(self.centerX, self.centerY - 30) radius:95 startAngle:DEGREES_TO_RADIANS(360) endAngle:0 clockwise:YES];
    
    [mPath stroke];//边框填充
    

    [self addSubview:self.timeLa];
    
    
    [self addSubview:self.photoBtn];
    
    [self addSubview:self.titleLa];
    
    
    UIImageView *adreIm = [[UIImageView alloc] init];
    adreIm.image = [UIImage imageNamed:@"loufang"];
    [self addSubview:adreIm];
    [adreIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLa.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.titleLa);
        
    }];
    
    
    [self addSubview:self.locationBtn];

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
