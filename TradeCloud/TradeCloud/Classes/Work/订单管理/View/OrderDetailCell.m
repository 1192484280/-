//
//  OrderDetailCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderDetailCell.h"
#import "OrderDetailModel.h"

@implementation OrderDetailCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (indexPath.row) {
        case 6:
            identity = @"CELL2";
            index = 1;
            break;
        default:
            identity = @"CELL";
            index = 0;
            break;
    }
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
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
    
    NSInteger index = 0;
    switch (indexPath.row) {
        case 6:
            
            index = 1;
            break;
        default:
            
            index = 0;
            break;
    }
    
    ClassName
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:index];
}

- (void)reciveTitle:(NSString *)title andDetailText:(OrderDetailModel *)model andIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.customer_name;
    }
    
    if (indexPath.row == 1) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.section_number;
    }
    
    if (indexPath.row == 2) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.num;
    }
    
    if (indexPath.row == 3) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.factory_name;
    }
    
    if (indexPath.row == 4) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.goods_type_name;
    }
    
    if (indexPath.row == 5) {
        
        self.titleLa.text = title;
        self.detailLa.text = model.status;
    }
    
    if (indexPath.row == 6) {
        
        self.desLa.text = model.note;
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
