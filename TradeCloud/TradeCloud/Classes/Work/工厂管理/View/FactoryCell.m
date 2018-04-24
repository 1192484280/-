//
//  FactoryCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "FactoryCell.h"

@implementation FactoryCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    FactoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [FactoryCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (IBAction)onEditBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onEditWithSection:)]) {
        
        [self.delegate onEditWithSection:self.section];
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
