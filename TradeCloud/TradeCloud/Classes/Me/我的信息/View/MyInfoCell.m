//
//  MyInfoCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyInfoCell.h"

@implementation MyInfoCell

+ (instancetype)tempWithTableView:(UITableView *)tableView  andIndexPath:(NSIndexPath *)indexPath{

    NSString *identity = @"";
    NSInteger index = 1;
    switch (indexPath.section) {
        case 0:
            identity = @"CELL";
            index = 0;
            break;
        default:
            identity = @"CELL2";
            
            break;
    }
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [self cellWithIndex:indexPath];
    return cell.frame.size.height;
}

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath{

    ClassName
    NSInteger index = 1;
    switch (indexPath.section) {
        case 0:
            
            index = 0;
            break;
        default:
            break;
    }
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:index];
}

- (void)reciveTitle:(NSString *)title andIndex:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        self.la1.text = title;
    }else{
        
        self.la2.text = title;
    }
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
