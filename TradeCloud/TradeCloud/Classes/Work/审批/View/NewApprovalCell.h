//
//  NewApprovalCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewApprovalCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *im;

@property (strong, nonatomic) IBOutlet UILabel *la;

- (void)reciveTitle:(NSString *)title andImg:(NSString *)img;

@end
