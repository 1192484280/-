//
//  ReimbursBottomCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/22.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReimbursBottomCell.h"
#import "ProcessModel.h"

@implementation ReimbursBottomCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    ReimbursBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [ReimbursBottomCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)setModel:(ProcessModel *)model{
    
    self.im.image = [UIImage imageNamed:@"add_img"];
    self.valueLa.text = model.title;
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
