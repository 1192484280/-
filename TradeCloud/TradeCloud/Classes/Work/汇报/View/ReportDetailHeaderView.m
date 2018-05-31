//
//  ReportDetailHeaderView.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReportDetailHeaderView.h"

@interface ReportDetailHeaderView()

@property (weak, nonatomic) UILabel *desLa;

@end

@implementation ReportDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"add_img"];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self).offset(16);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UILabel *timeLa = [[UILabel alloc] init];
    timeLa.text = @"15:00";
    timeLa.textColor = FontColor;
    [self addSubview:timeLa];
    [timeLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self).offset(16);
        
        make.size.mas_equalTo(CGSizeMake(80, 50));
        
    }];
    
    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.text = @"张三日报";
    titleLa.textColor = FontColor;
    [self addSubview:titleLa];
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(16);
        make.left.equalTo(img.mas_right).offset(8);
        
        make.height.mas_equalTo(50);
        
        make.right.equalTo(timeLa).offset(-8);
        
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#E8E6E8"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(img.mas_bottom).offset(8);
        
    }];
    
    
    UILabel *desLa = [[UILabel alloc] init];
    NSString *a = @"皇马的T恤上写着“A por la 13”，意思是“为了第13冠”、“冲向第13冠”，相当于口号，给自己打气。事实上皇马每次晋级决赛之后，都会身穿类似的T恤庆祝晋级。但不少人以为皇马已经提前身穿了夺冠纪念T恤，抨击皇马缺乏尊重。";
    desLa.text = a;
    desLa.textColor = FontColor;
    desLa.numberOfLines = 0;
    [self addSubview:desLa];
    
    //设置字间距
    NSDictionary *dic = @{
                          NSKernAttributeName:@1.f
                          };
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:a attributes:dic];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [a length])];
    
    [desLa setAttributedText:attributedString];
    
    [desLa sizeToFit];
    
    [desLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line).offset(16);
        make.left.right.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-8);
        
    }];
    
}



@end
