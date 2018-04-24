//
//  OrderCostCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderCostModel;

@interface OrderCostCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@property (assign, nonatomic) NSInteger section;

@property (strong, nonatomic) OrderCostModel *model;


@end
