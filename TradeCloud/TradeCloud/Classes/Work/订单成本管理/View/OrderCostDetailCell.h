//
//  OrderCostDetailCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCostDetailCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

- (void)reciveTitle:(NSString *)title andDetailText:(NSString *)detailText andIndexPath:(NSIndexPath *)indexPath;


@end
