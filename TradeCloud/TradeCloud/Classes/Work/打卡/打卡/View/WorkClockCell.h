//
//  WorkClockCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PunchModel;

@interface WorkClockCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *yearLa;

@property (strong, nonatomic) IBOutlet UILabel *timeLa;
@property (strong, nonatomic) IBOutlet UILabel *locationLa;

@property (strong, nonatomic) PunchModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@end
