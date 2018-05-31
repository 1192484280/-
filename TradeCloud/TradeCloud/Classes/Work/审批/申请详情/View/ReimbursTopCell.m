//
//  ReimbursTopCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReimbursTopCell.h"
#import "FieldDataModel.h"

@implementation ReimbursTopCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    ReimbursTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

- (void)setModel:(FieldDataModel *)model{
    
    self.titleLa.text = model.label_name;
    self.valueLa.text = model.value;
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
