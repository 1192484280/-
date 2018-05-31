//
//  ReimbursApprovalHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReimbursApprovalHeaderView.h"
#import "ApprovalDetailModel.h"

@interface ReimbursApprovalHeaderView ()

@property (weak, nonatomic) UIImageView *im;

@property (weak, nonatomic) UILabel *titleLa;

@property (weak, nonatomic) UILabel *statusLa;

@end

@implementation ReimbursApprovalHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    UIImageView *im = [[UIImageView alloc] init];
    [self addSubview:im];
    [im mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    self.im = im;
    
    UILabel *titleLa = [[UILabel alloc] init];
    [self addSubview:titleLa];
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(im.mas_right).offset(8);
        make.centerY.equalTo(im);
        make.right.equalTo(self).offset(8);
    }];
    self.titleLa = titleLa;
    
    UILabel *statusLa = [[UILabel alloc] init];
    [self addSubview:statusLa];
    self.statusLa = statusLa;
}
- (void)setModel:(ApprovalDetailModel *)model{
    
    [self.im sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"add_img"]];
    
    self.titleLa.text = model.title;
}

@end
