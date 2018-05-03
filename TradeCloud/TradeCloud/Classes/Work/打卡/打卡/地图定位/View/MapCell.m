//
//  MapCell.m
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "MapCell.h"

@implementation MapCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    MapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        
        cell = [self cell];
    }
    return cell;
    
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [self cell];
    return cell.frame.size.height;
}

+ (instancetype)cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)setModel:(BMKPoiInfo *)model{
    
    self.title.text = model.name;
    self.address.text = model.address;
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
