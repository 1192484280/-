//
//  ApprovalModelBaseCell.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreatApprovalDataModel;

@protocol ApprovalModelBaseCellDelegate<NSObject>

- (void)onManySelectBtnwithArr:(NSArray *)arr withModel:(CreatApprovalDataModel *)model andIndexPath:(NSIndexPath *)indexPath;

@end

@interface ApprovalModelBaseCell : UITableViewCell

@property (weak, nonatomic) id<ApprovalModelBaseCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UIImageView *star1;

@property (strong, nonatomic) IBOutlet UILabel *title1;
@property (strong, nonatomic) IBOutlet UITextField *tf;

@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *placeLa;

@property (weak, nonatomic) IBOutlet UITextView *tw;

@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UIButton *singleImBtn;


@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UILabel *title4;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoWidth;

@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *title5;
@property (weak, nonatomic) IBOutlet UILabel *value5;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *star6;
@property (weak, nonatomic) IBOutlet UILabel *title6;
@property (weak, nonatomic) IBOutlet UILabel *value6;
@property (weak, nonatomic) IBOutlet UIButton *manyselectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *star7;
@property (weak, nonatomic) IBOutlet UILabel *title7;
@property (weak, nonatomic) IBOutlet UILabel *value7;
@property (weak, nonatomic) IBOutlet UIButton *dateSelectBtn;



+ (instancetype)tempWithTableView:(UITableView *)tableView andModel:(CreatApprovalDataModel *)model;

+ (CGFloat)getHeightWithModel:(CreatApprovalDataModel *)model;

+ (instancetype)cellWithModel:(CreatApprovalDataModel *)model;

- (void)setModel:(CreatApprovalDataModel *)model;

@end
