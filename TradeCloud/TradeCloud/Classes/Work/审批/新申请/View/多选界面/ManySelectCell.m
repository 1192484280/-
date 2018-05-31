//
//  ManySelectCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ManySelectCell.h"
#import "OptionsModel.h"

@implementation ManySelectCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    ManySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}


- (void)setOptionModel:(OptionsModel *)model andSelectArr:(NSArray *)listArr{
    
    self.titleLa.text = model.name;
    
    for (OptionsModel *mo in listArr) {
        
        if ([mo isEqual:model]) {
            
            self.selectBtn.selected = YES;
        }
    }
    
    __block BOOL isExist = NO;
    
    
    for (OptionsModel *info in listArr) {
        
        if ([model isEqual:info]) {
            
            isExist = YES;
            
        }
    }
    //重复则跳过
    if (!isExist) {
        
        self.selectBtn.selected = NO;
    }else{
        self.selectBtn.selected = YES;
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
