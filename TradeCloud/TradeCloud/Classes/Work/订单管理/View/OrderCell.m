//
//  OrderCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()
@property (strong, nonatomic) IBOutlet UILabel *kuanhaoLa;
@property (strong, nonatomic) IBOutlet UILabel *typeLa;
@property (strong, nonatomic) IBOutlet UILabel *stateLa;
@property (strong, nonatomic) IBOutlet UILabel *factoryLa;
@property (strong, nonatomic) IBOutlet UILabel *numLa;
@property (strong, nonatomic) IBOutlet UILabel *datela;


@end

@implementation OrderCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [OrderCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}


- (void)setModel:(OrderModel *)model{
    
    _kuanhaoLa.text = model.section_number;
    _typeLa.text = model.goods_type_name;
    _stateLa.text = model.status_name;
    _factoryLa.text = model.factory_name;
    _numLa.text = model.num;
    _datela.text = model.add_time;
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
