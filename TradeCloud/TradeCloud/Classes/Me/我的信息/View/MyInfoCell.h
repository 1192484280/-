//
//  MyInfoCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView  andIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *la1;
@property (weak, nonatomic) IBOutlet UILabel *la2;

- (void)reciveTitle:(NSString *)title andIndex:(NSIndexPath *)indexPath;

@end
