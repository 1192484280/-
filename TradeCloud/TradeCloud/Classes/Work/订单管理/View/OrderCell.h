//
//  OrderCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@property (strong, nonatomic) OrderModel *model;


@end
