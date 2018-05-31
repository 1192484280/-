//
//  ApprovalModelUrlCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreatApprovalUrlModel;

@interface ApprovalModelUrlCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *iconView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconViewWidth;

@property (strong, nonatomic) CreatApprovalUrlModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@end
