//
//  OrderCostDetailCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostDetailCell.h"

@interface OrderCostDetailCell()

@property (strong, nonatomic) IBOutlet UILabel *titleLa1;
@property (strong, nonatomic) IBOutlet UILabel *detailLa;

@property (weak, nonatomic) IBOutlet UILabel *titleLa2;
@property (weak, nonatomic) IBOutlet UILabel *desLa;
@property (weak, nonatomic) IBOutlet UIImageView *im;

@end

@implementation OrderCostDetailCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (indexPath.row) {
        case 8:
            identity = @"CELL3";
            index = 2;
            break;
        case 7:
            identity = @"CELL2";
            index = 1;
            break;
        case 6:
            identity = @"CELL2";
            index = 1;
            break;
        default:
            identity = @"CELL";
            index = 0;
            break;
    }
    OrderCostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}


- (void)reciveTitle:(NSString *)title andDetailText:(NSString *)detailText andIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 6) {
        
        self.titleLa1.text = title;
        self.detailLa.text = detailText;
        
    }else if (indexPath.row <8){
        
        self.titleLa2.text = title;
        self.desLa.text = detailText;
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
