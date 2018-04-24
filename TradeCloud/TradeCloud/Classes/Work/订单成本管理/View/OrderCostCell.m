//
//  OrderCostCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostCell.h"
#import "OrderCostModel.h"

@interface OrderCostCell()
@property (strong, nonatomic) IBOutlet UILabel *kuaohaoLa;
@property (strong, nonatomic) IBOutlet UILabel *dateLa;
@property (strong, nonatomic) IBOutlet UILabel *moneyLa;
@property (strong, nonatomic) IBOutlet UILabel *personLa;
@property (strong, nonatomic) IBOutlet UILabel *typeLa;



@end
@implementation OrderCostCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    OrderCostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [OrderCostCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}


- (void)setModel:(OrderCostModel *)model{
    
    self.kuaohaoLa.text = model.section_number;
    self.dateLa.text = model.pay_time;
    self.moneyLa.text = [NSString stringWithFormat:@"¥%@",model.money];
    self.personLa.text = model.staff_name;
    self.typeLa.text = model.pay_type_name;
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
