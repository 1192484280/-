//
//  MailListCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/3/27.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailListCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@end
