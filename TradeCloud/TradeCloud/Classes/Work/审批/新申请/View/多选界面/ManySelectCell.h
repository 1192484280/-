//
//  ManySelectCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OptionsModel;

@interface ManySelectCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLa;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

- (void)setOptionModel:(OptionsModel *)model andSelectArr:(NSArray *)listArr;
@end
