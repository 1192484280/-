//
//  ReimbursApprovalBottomView.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/22.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReimbursApprovalBottomView.h"

@interface ReimbursApprovalBottomView()
{
    BOOL _myHandle;
}
@property (strong, nonatomic) NSMutableArray *masonryViewArray;

@property (copy, nonatomic) NSArray *imgArr;
@property (copy, nonatomic) NSArray *imgArr2;

@end

@implementation ReimbursApprovalBottomView

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"icon_pass",@"icon_refuse"];
        
    }
    return _imgArr;
}

- (NSArray *)imgArr2{
    
    if (!_imgArr2) {
        
        _imgArr2 = @[@"icon_cuiban",@"icon_cexiao"];
        
    }
    return _imgArr2;
}

- (NSMutableArray *)masonryViewArray {
    
    if (!_masonryViewArray) {
        
        _masonryViewArray = [NSMutableArray array];
        
        NSArray *arr = self.imgArr;
        
        if(!_myHandle){
            
            arr = self.imgArr2;
        }
        for (int i = 0; i < 2; i ++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_masonryViewArray addObject:btn];
            
        }
        
    }
    return _masonryViewArray;
    
}

- (void)onBtn:(UIButton *)btn{
    
    if(_myHandle){
        
        if (btn.tag == 100) {
            
            if (self.passBlock) {
                
                self.passBlock();
            }
        }else{
            
            if (self.refuseBlock) {
                
                self.refuseBlock();
            }
        }
        
    }else{
        
        if (btn.tag == 100) {
            
            if (self.urgeBlock) {
                
                self.urgeBlock();
            }
        }else{
            
            if (self.RevokeBlock) {
                
                self.RevokeBlock();
            }
        }
        
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame withPage:(BOOL)myHandle{
    
    if (self = [super initWithFrame:frame]) {
        
        _myHandle = myHandle;
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = DetailColor;
    [self addSubview:line];
    
    CGFloat btnW = 80;
    CGFloat btnH = 40;
    CGFloat spacing = (kScreenWidth - btnW * 2)/3;
    // 实现masonry水平固定控件宽度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:btnW leadSpacing:spacing tailSpacing:spacing];
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(5);
        make.height.mas_equalTo(btnH);
        
    }];
    
    
    
}
@end
