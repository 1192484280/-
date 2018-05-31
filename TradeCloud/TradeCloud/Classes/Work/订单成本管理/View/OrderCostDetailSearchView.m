//
//  OrderCostDetailSearchView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostDetailSearchView.h"
#import "OrderCostList.h"
#import "OrderCostParameterModel.h"

@interface OrderCostDetailSearchView()<UITextFieldDelegate>

@property(weak, nonatomic) UILabel *orderTime;
@property(weak, nonatomic) UIButton *startBtn;
@property(weak, nonatomic) UIButton *endBtn;
@property(weak, nonatomic) UILabel *kuanhaoLa;
@property(weak, nonatomic) UITextField *kuanhaoTf;
@property(weak, nonatomic) UILabel *typeLa;
@property(weak, nonatomic) UIButton *typeTf;
@property(weak, nonatomic) UILabel *stateLa;
@property(weak, nonatomic) UIButton *stateTf;
@property(weak, nonatomic) UIView *line;

@property(weak, nonatomic) UIButton *searchBtn;

@end

@implementation OrderCostDetailSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:self.bounds];
    im.image = [UIImage imageNamed:@"alert_bg2"];
    [self addSubview:im];
    
    UILabel *orderTime = [[UILabel alloc] init];
    orderTime.text = @"支出日期:";
    orderTime.textAlignment = NSTextAlignmentRight;
    orderTime.font = [UIFont systemFontOfSize:15];
    [self addSubview:orderTime];
    self.orderTime = orderTime;
    
    
    
    UIButton *startBtn = [[UIButton alloc] init];
    [self setBtn:startBtn WithTitle:@"开始日期"];
    [startBtn addTarget:self action:@selector(onStart:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startBtn];
    self.startBtn = startBtn;
    
    
    UIButton *endBtn = [[UIButton alloc] init];
    [self addSubview:endBtn];
    [self setBtn:endBtn WithTitle:@"结束日期"];
    [endBtn addTarget:self action:@selector(onEnd:) forControlEvents:UIControlEventTouchUpInside];
    self.endBtn = endBtn;
    
    UILabel *kuanhaoLa = [[UILabel alloc] init];
    kuanhaoLa.text = @"款号:";
    kuanhaoLa.textAlignment = NSTextAlignmentRight;
    kuanhaoLa.font = [UIFont systemFontOfSize:15];
    [self addSubview:kuanhaoLa];
    self.kuanhaoLa = kuanhaoLa;
    
    UITextField *kuanhaoTf = [[UITextField alloc] init];
    [self addSubview:kuanhaoTf];
    kuanhaoTf.placeholder = @"请输入款号";
    [self setTf:kuanhaoTf];
    kuanhaoTf.delegate = self;
    self.kuanhaoTf = kuanhaoTf;
    
    UILabel *typeLa = [[UILabel alloc] init];
    typeLa.text = @"支出类型:";
    typeLa.textAlignment = NSTextAlignmentRight;
    typeLa.font = [UIFont systemFontOfSize:15];
    [self addSubview:typeLa];
    self.typeLa = typeLa;
    
    UIButton *typeTf = [[UIButton alloc] init];
    [self addSubview:typeTf];
    [self setBtn:typeTf WithTitle:@"选择支出类型"];
    [typeTf addTarget:self action:@selector(onType:) forControlEvents:UIControlEventTouchUpInside];
    self.typeTf = typeTf;
    
    UILabel *stateLa = [[UILabel alloc] init];
    stateLa.text = @"支出人:";
    stateLa.textAlignment = NSTextAlignmentRight;
    stateLa.font = [UIFont systemFontOfSize:15];
    [self addSubview:stateLa];
    self.stateLa = stateLa;
    
    UIButton *stateTf = [[UIButton alloc] init];
    [self addSubview:stateTf];
    [self setBtn:stateTf WithTitle:@"选择支出人"];
    [stateTf addTarget:self action:@selector(onStateBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.stateTf = stateTf;
    
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
//    [self addSubview:line];
//    self.line = line;
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 8;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.backgroundColor = NAVBARCOLOR;
    [searchBtn addTarget:self action:@selector(onDetailSearch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    self.searchBtn = searchBtn;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [OrderCostList sharedInstance].parameterModel.section_number = textField.text;
    
}


- (void)onDetailSearch{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchDetailSearchBtn)]) {
        
        [self.delegate onSearchDetailSearchBtn];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.orderTime.x = 16;
    self.orderTime.y = 20;
    self.orderTime.width = 70;
    self.orderTime.height = 30;
    
    self.startBtn.x = CGRectGetMaxX(self.orderTime.frame) + 20;
    self.startBtn.y = 20;
    self.startBtn.width = (kScreenWidth - (CGRectGetMaxX(self.orderTime.frame) + 20) - 16)/2 - 10 ;
    self.startBtn.height = 30;
    
    self.endBtn.x = CGRectGetMaxX(self.startBtn.frame) + 20;
    self.endBtn.y = 20;
    self.endBtn.width = (kScreenWidth - (CGRectGetMaxX(self.orderTime.frame) + 20) - 16)/2 - 10;
    self.endBtn.height = 30;
    
    self.kuanhaoLa.x = self.orderTime.x;
    self.kuanhaoLa.y = CGRectGetMaxY(self.orderTime.frame) + 8;
    self.kuanhaoLa.width = 70;
    self.kuanhaoLa.height = 30;
    
    self.kuanhaoTf.x = CGRectGetMaxX(self.kuanhaoLa.frame) + 20 ;
    self.kuanhaoTf.y = self.kuanhaoLa.y;
    self.kuanhaoTf.width = kScreenWidth - (CGRectGetMaxX(self.kuanhaoLa.frame) + 20) - 16;
    self.kuanhaoTf.height = 30;
    
    self.typeLa.x = self.orderTime.x;
    self.typeLa.y = CGRectGetMaxY(self.kuanhaoLa.frame) + 8;
    self.typeLa.width = 70;
    self.typeLa.height = 30;
    
    self.typeTf.x = CGRectGetMaxX(self.typeLa.frame) + 20;
    self.typeTf.y = self.typeLa.y;
    self.typeTf.width = kScreenWidth - (CGRectGetMaxX(self.typeLa.frame) + 20) - 16;
    self.typeTf.height = 30;
    
    self.stateLa.x = self.orderTime.x;
    self.stateLa.y = CGRectGetMaxY(self.typeLa.frame) + 8;
    self.stateLa.width = 70;
    self.stateLa.height = 30;
    
    self.stateTf.x = CGRectGetMaxX(self.stateLa.frame) + 20;
    self.stateTf.y = self.stateLa.y;
    self.stateTf.width = kScreenWidth - (CGRectGetMaxX(self.stateLa.frame) + 20) - 16;
    self.stateTf.height = 30;
    

//    self.line.x = 0;
//    self.line.y = CGRectGetMaxY(self.stateLa.frame) + 15;
//    self.line.width = kScreenWidth;
//    self.line.height = 0.5;
    
    self.searchBtn.y = CGRectGetMaxY(self.stateTf.frame) + 30;
    self.searchBtn.x = 50;
    self.searchBtn.width = kScreenWidth - 100;
    self.searchBtn.height = 38;
}

- (void)setTf:(UITextField *)tf{
    
    tf.layer.borderWidth = 0.5;
    tf.layer.borderUIColor = DetailColor;
    tf.font = [UIFont systemFontOfSize:13];
    tf.textAlignment = NSTextAlignmentCenter;
}

- (void)setBtn:(UIButton *)btn WithTitle:(NSString *)title{
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:DetailColor forState:UIControlStateNormal];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderUIColor = DetailColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)onStart:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onStartDateBtn:)]) {
        
        [self.delegate onStartDateBtn:btn];
    }
}

- (void)onEnd:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onEndDateBtn:)]) {
        
        [self.delegate onEndDateBtn:btn];
    }
}

- (void)onType:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPayTypeBtn:)]) {
        
        [self.delegate onPayTypeBtn:btn];
    }

}

- (void)onStateBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPersonBtn:)]) {
        
        [self.delegate onPersonBtn:btn];
    }
    
}
@end
