//
//  OrderDetailCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailModel;

@interface OrderDetailCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *titleLa;
@property (strong, nonatomic) IBOutlet UILabel *detailLa;
@property (weak, nonatomic) IBOutlet UILabel *desLa;


- (void)reciveTitle:(NSString *)title andDetailText:(OrderDetailModel *)model andIndexPath:(NSIndexPath *)indexPath;


@end
