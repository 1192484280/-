//
//  MineHeaderView.m
//  JuHuiLife
//
//  Created by zhangming on 2018/2/5.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()

@property (weak , nonatomic) UIImageView *bgView;
@property (weak, nonatomic) UIImageView *headerIm;
@property (weak, nonatomic) UILabel *nameLa;
@property (weak, nonatomic) UILabel *telLa;
@property (weak, nonatomic) UILabel *emailLa;
@property (weak, nonatomic) UILabel *companyLa;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"headerbg_02"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onNameLa)];
    UITapGestureRecognizer *tapIm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onNameLa)];
    
    UIImageView *headerIm = [[UIImageView alloc] init];
    headerIm.image = [UIImage imageNamed:@"add_img"];
    [self addSubview:headerIm];
    self.headerIm = headerIm;
    headerIm.userInteractionEnabled = YES;
    [headerIm addGestureRecognizer:tapIm];
    
    UILabel *nameLa = [[UILabel alloc] init];
    nameLa.text = @"Mr.Right";
    nameLa.font = [UIFont systemFontOfSize:15];
    nameLa.textAlignment = NSTextAlignmentCenter;
    nameLa.textColor = [UIColor whiteColor];
    [self addSubview:nameLa];
    self.nameLa = nameLa;
    nameLa.userInteractionEnabled = YES;
    [nameLa addGestureRecognizer:tap];
    
    UILabel *telLa = [[UILabel alloc] init];
    telLa.text = @"17664517323";
    telLa.font = [UIFont systemFontOfSize:15];
    telLa.textColor = [UIColor whiteColor];
    telLa.textAlignment = NSTextAlignmentRight;
    [self addSubview:telLa];
    self.telLa = telLa;
    
    
    UILabel *emailLa = [[UILabel alloc] init];
    emailLa.text = @"1192484280@qq.com";
    emailLa.font = [UIFont systemFontOfSize:15];
    emailLa.textColor = [UIColor whiteColor];
    emailLa.textAlignment = NSTextAlignmentLeft;
    [self addSubview:emailLa];
    self.emailLa = emailLa;
    
    UILabel *companyLa = [[UILabel alloc] init];
    companyLa.text = @"优捷思科技（大连）";
    companyLa.font = [UIFont systemFontOfSize:15];
    companyLa.textColor = [UIColor whiteColor];
    companyLa.textAlignment = NSTextAlignmentCenter;
    [self addSubview:companyLa];
    self.companyLa = companyLa;
}

- (void)onNameLa{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lookAtMe)]) {
        
        [self.delegate lookAtMe];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    self.bgView.y -= kScreenHeight;
    self.bgView.height += kScreenHeight;
    
    self.headerIm.y = 50;
    self.headerIm.x = (kScreenWidth - 80)/2;
    self.headerIm.width = 80;
    self.headerIm.height = 80;
    self.headerIm.layer.cornerRadius = self.headerIm.width/2;
    self.headerIm.layer.masksToBounds = YES;
    self.headerIm.layer.borderWidth = 1;
    self.headerIm.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.nameLa.y = CGRectGetMaxY(self.headerIm.frame) + 10;
    self.nameLa.x = (kScreenWidth - 150)/2;
    self.nameLa.width = 150;
    self.nameLa.height = 25;
    
    self.telLa.y = CGRectGetMaxY(self.nameLa.frame) + 10;
    self.telLa.x = 0;
    self.telLa.width = kScreenWidth/2 - 10;
    self.telLa.height = 25;
    
    self.emailLa.y = CGRectGetMaxY(self.nameLa.frame) + 10;
    self.emailLa.x = kScreenWidth/2 + 10;
    self.emailLa.width = kScreenWidth/2 - 10;
    self.emailLa.height = 25;
    
    self.companyLa.y = CGRectGetMaxY(self.telLa.frame) + 10;
    self.companyLa.x = 0;
    self.companyLa.width = kScreenWidth;
    self.companyLa.height = 25;
}

@end
