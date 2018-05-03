//
//  OutHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OutHeaderView.h"

#define pi 3.14159265359

#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface OutHeaderView()

@property (strong, nonatomic) UILabel *timeLa;
@property (strong, nonatomic) UIButton *addreBtn;
@property (strong, nonatomic) UIButton *remarkBtn;
@property (strong, nonatomic) UIButton *photoBtn;

@end

@implementation OutHeaderView

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

- (UIButton *)addreBtn{
    
    if (!_addreBtn) {
        
        _addreBtn = [[UIButton alloc] init];
        [_addreBtn setTitle:@"当前位置" forState:UIControlStateNormal];
        [_addreBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _addreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _addreBtn.size = CGSizeMake(kScreenWidth, 30);
        _addreBtn.centerX = self.centerX;
        _addreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _addreBtn.y = self.height - 70;
        [_addreBtn addTarget:self action:@selector(onAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addreBtn;
}
- (UIButton *)remarkBtn{
    
    if (!_remarkBtn) {
        
        _remarkBtn = [[UIButton alloc] init];
        [_remarkBtn setTitle:@"添加备注" forState:UIControlStateNormal];
        [_remarkBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _remarkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _remarkBtn.size = CGSizeMake(kScreenWidth, 15);
        _remarkBtn.centerX = self.centerX;
        _remarkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _remarkBtn.y = CGRectGetMaxY(self.addreBtn.frame) + 8;
        [_remarkBtn addTarget:self action:@selector(onRemark:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _remarkBtn;
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
    
    [self addSubview:self.addreBtn];
    
    
    UIImageView *adreIm = [[UIImageView alloc] init];
    adreIm.image = [UIImage imageNamed:@"loufang"];
    [self addSubview:adreIm];
    
    [adreIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.bottom.equalTo(self.addreBtn.mas_top).offset(-8);
        
    }];
    
    
    [self addSubview:self.remarkBtn];
    
}

- (void)setLocation:(NSString *)location{
    
    [self.addreBtn setTitle:location forState:UIControlStateNormal];
}


- (void)onPhotoBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBtn:)]) {
        
        [self.delegate photoBtn:btn];
    }
}

- (void)onRemark:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRemarkBtn:)]) {
        
        [self.delegate onRemarkBtn:btn];
    }
}

- (void)onAddress:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onAddresBtn:)]) {
        
        [self.delegate onAddresBtn:btn];
    }
}
@end
