//
//  ReimbursBottomCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/22.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessModel.h"

@interface ReimbursBottomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *im;
@property (strong, nonatomic) IBOutlet UILabel *valueLa;

@property (strong, nonatomic) ProcessModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@end
