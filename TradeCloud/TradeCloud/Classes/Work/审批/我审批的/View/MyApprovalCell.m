//
//  MyApprovalCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalCell.h"

@implementation MyApprovalCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    MyApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [MyApprovalCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
