//
//  CountHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CountHeaderView.h"
#import "RoundView.h"

@interface CountHeaderView()

@property (strong, nonatomic) RoundView *roundView;
@property (weak, nonatomic) UIImageView *norIm;
@property (weak, nonatomic) UIImageView *unnorIm;
@property (weak, nonatomic) UILabel *norLa;
@property (weak, nonatomic) UILabel *unnorLa;
@property (weak, nonatomic) UILabel *laterLa;
@end

@implementation CountHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    
    return self;
}


- (RoundView *)roundView{
    
    if (!_roundView) {
        
        _roundView = [[RoundView alloc] init];
        _roundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_roundView];
        [_roundView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.equalTo(self).offset(10);
            make.right.bottom.equalTo(self).offset(-10);
        }];
    }
    
    return _roundView;
}

- (void)setUI{
    

    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.text = @"上下班打卡";
    titleLa.font = [UIFont boldSystemFontOfSize:17];
    [self.roundView addSubview:titleLa];
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.roundView).offset(10);
        
    }];
    
    
    UILabel *norLa = [[UILabel alloc] init];
    norLa.text = @"正常0人";
    norLa.textColor = [UIColor grayColor];
    norLa.font = [UIFont systemFontOfSize:15];
    norLa.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:norLa];
    [norLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.roundView).offset(120);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.roundView).offset(10);
    
    }];
    
    UILabel *unnorLa = [[UILabel alloc] init];
    unnorLa.text = @"异常4人";
    unnorLa.textColor = [UIColor grayColor];
    unnorLa.font = [UIFont systemFontOfSize:15];
    unnorLa.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:unnorLa];
    [unnorLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.roundView).offset(140);
        make.centerX.equalTo(self.roundView).offset(10);
        make.height.mas_equalTo(20);
    }];

    UIImageView *norIm = [[UIImageView alloc] init];
    norIm.image = [UIImage imageNamed:@"norIm"];
    [self.roundView addSubview:norIm];
    [norIm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.roundView).offset(120);
        make.left.equalTo(norLa.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    UIImageView *unnorIm = [[UIImageView alloc] init];
    unnorIm.image = [UIImage imageNamed:@"unnorIm"];
    [self.roundView addSubview:unnorIm];
    [unnorIm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.roundView).offset(140);
        make.left.equalTo(unnorLa.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *la1 = [[UILabel alloc] init];
    la1.text = @"迟到";
    la1.textColor = FontColor;
    la1.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la1];
    
    UILabel *la2 = [[UILabel alloc] init];
    la2.text = @"早退";
    la2.textColor = FontColor;
    la2.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la2];
    
    UILabel *la3 = [[UILabel alloc] init];
    la3.text = @"缺卡";
    la3.textColor = FontColor;
    la3.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la3];
    
    CGFloat LRpadding = -10;
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.roundView).offset(LRpadding);
        make.left.equalTo(self.roundView);
        make.width.equalTo(la2);
    }];
    
    [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.roundView).offset(LRpadding);
        make.left.equalTo(la1.mas_right);
        make.width.equalTo(la1);
    }];
    
    [la3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.roundView).offset(LRpadding);
        make.left.equalTo(la2.mas_right);
        make.width.equalTo(la2);
    }];
    
    [la3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.roundView);
    }];
    
    UILabel *la4 = [[UILabel alloc] init];
    la4.text = @"1";
    la4.textColor = [UIColor orangeColor];
    la4.font = [UIFont boldSystemFontOfSize:20];
    la4.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la4];
    
    UILabel *la5 = [[UILabel alloc] init];
    la5.text = @"0";
    la5.textColor = [UIColor blackColor];
    la5.font = [UIFont boldSystemFontOfSize:20];
    la5.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la5];
    
    UILabel *la6 = [[UILabel alloc] init];
    la6.text = @"1";
    la6.textColor = [UIColor orangeColor];
    la6.font = [UIFont boldSystemFontOfSize:20];
    la6.textAlignment = NSTextAlignmentCenter;
    [self.roundView addSubview:la6];
    
    CGFloat Rpadding = -10;
    
    [la4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(la1.mas_top).offset(Rpadding);
        make.left.equalTo(self.roundView);
        make.width.equalTo(la5);
    }];
    
    [la5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(la1.mas_top).offset(Rpadding);
        make.left.equalTo(la4.mas_right);
        make.width.equalTo(la4);
    }];
    
    [la6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(la1.mas_top).offset(Rpadding);
        make.left.equalTo(la5.mas_right);
        make.width.equalTo(la5);
    }];
    
    [la6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.roundView);
    }];
    
}


@end
