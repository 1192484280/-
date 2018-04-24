//
//  HeaderCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/27.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andListArr:(NSArray *)listArr andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            identity = @"CELL1";
            index = 0;
            break;
        case 1:
            identity = @"CELL2";
            index = 1;
            break;
        case 2:
            identity = @"CELL3";
            index = 2;
            break;
            
        default:
            break;
    }
    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
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
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:indexPath.section];
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
