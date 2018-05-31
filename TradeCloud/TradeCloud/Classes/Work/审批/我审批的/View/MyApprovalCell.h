//
//  MyApprovalCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyApprovalViewModel;

@interface MyApprovalCell : UITableViewCell

@property (strong, nonatomic) MyApprovalViewModel *frameModel;

+ (instancetype)tempWithTableView:(UITableView *)tableView;


@end
