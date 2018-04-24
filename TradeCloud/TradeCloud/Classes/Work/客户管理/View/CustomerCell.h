//
//  CustomerCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CustomerCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@property (strong, nonatomic) CustomerModel *model;

@end
