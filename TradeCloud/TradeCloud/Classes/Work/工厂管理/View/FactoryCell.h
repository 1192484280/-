//
//  FactoryCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FactoryCellDelegate<NSObject>

- (void)onEditWithSection:(NSInteger)section;

@end

@interface FactoryCell : UITableViewCell

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)Cell;

@property (assign, nonatomic) NSInteger section;

@property (weak, nonatomic) id<FactoryCellDelegate> delegate;

@end
