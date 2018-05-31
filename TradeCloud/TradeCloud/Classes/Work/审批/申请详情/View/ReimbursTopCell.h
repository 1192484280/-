//
//  ReimbursTopCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FieldDataModel;

@interface ReimbursTopCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLa;
@property (strong, nonatomic) IBOutlet UILabel *valueLa;

@property (strong, nonatomic) FieldDataModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;


@end
