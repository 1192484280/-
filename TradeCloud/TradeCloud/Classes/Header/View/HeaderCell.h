//
//  HeaderCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/3/27.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andListArr:(NSArray *)listArr andIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath;

@end
