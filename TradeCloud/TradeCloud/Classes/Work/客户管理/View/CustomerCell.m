//
//  CustomerCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerCell.h"

@interface CustomerCell()

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UILabel *creatTime;
@property (strong, nonatomic) IBOutlet UILabel *lastTime;


@end

@implementation CustomerCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [CustomerCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}


- (void)setModel:(CustomerModel *)model{
    
    self.name.text = model.customer_name;
    self.num.text = model.total_order_num;
    self.creatTime.text = model.add_time;
    self.lastTime.text = [NSString stringWithFormat:@"最后下单时间：%@",model.last_order_time];
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
