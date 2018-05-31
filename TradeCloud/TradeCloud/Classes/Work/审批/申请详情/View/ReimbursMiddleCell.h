//
//  ReimbursMiddleCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FieldDataModel;

@interface ReimbursMiddleCell : UITableViewCell

@property (strong, nonatomic) FieldDataModel *model;
@property (strong, nonatomic) IBOutlet UILabel *titleLa1;
@property (weak, nonatomic) IBOutlet UILabel *titleLa2;
@property (weak, nonatomic) IBOutlet UILabel *titleLa3;
@property (strong, nonatomic) IBOutlet UILabel *valueLa1;
@property (weak, nonatomic) IBOutlet UIButton *singleImBtn;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoWidth;

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath withModel:(FieldDataModel *)model;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath andModel:(FieldDataModel *)model;

+ (instancetype)cellWithIndex:(NSInteger )index;

@end
