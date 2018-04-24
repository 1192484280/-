//
//  NewApprovalCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NewApprovalCell.h"

@implementation NewApprovalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"NewApprovalCell" owner:self options:nil].lastObject;
    }
    return self;
}


- (void)reciveTitle:(NSString *)title andImg:(NSString *)img{
    
    self.im.image = [UIImage imageNamed:img];
    self.la.text = title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
