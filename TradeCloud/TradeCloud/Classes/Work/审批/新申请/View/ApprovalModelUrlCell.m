//
//  ApprovalModelUrlCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ApprovalModelUrlCell.h"
#import "CreatApprovalUrlModel.h"
#import "ApprovalIdsArrayModel.h"
#import "CommonStore.h"
#import "StaffModel.h"
#import "CreatApprovalList.h"


@interface ApprovalModelUrlCell()

@end

@implementation ApprovalModelUrlCell


+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    ApprovalModelUrlCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    ClassName
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [ApprovalModelUrlCell Cell];
    return cell.frame.size.height;
}

+ (instancetype)Cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)setModel:(CreatApprovalUrlModel *)model{
    
    [self refreshPhotoViewUI];
}

- (void)refreshPhotoViewUI{
    
    for (UIView *view in self.iconView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    for (int i =0 ; i< [CreatApprovalList sharedInstance].peopleArr.count; i++) {
        
        ApprovalIdsArrayModel *model = [CreatApprovalList sharedInstance].peopleArr[i];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(32*(i+1) + 65*i , 16, 65, 65)];
        
        [btn sd_setImageWithURL:[NSURL URLWithString:model.head] forState:UIControlStateNormal];
        
        [self.iconView addSubview:btn];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(32*(i+1) + 65*i -10, 16-10, 20, 20)];
        [delBtn setImage:[UIImage imageNamed:@"deleBtn"] forState:UIControlStateNormal];
        delBtn.tag = 100 + i;
        [delBtn addTarget:self action:@selector(onDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.iconView addSubview:delBtn];
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(32*([CreatApprovalList sharedInstance].peopleArr.count + 1) + 65*([CreatApprovalList sharedInstance].peopleArr.count) , 16, 65, 65)];
    [btn setImage:[UIImage imageNamed:@"pic_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.iconView addSubview:btn];
    
    self.iconViewWidth.constant = (CGRectGetMaxX(btn.frame)) + 30;
    
}

- (void)onSelectBtn:(UIButton *)btn{
    
    //放下键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    MJWeakSelf
    CommonStore *store = [[CommonStore alloc] init];
    [store getStaffListSuccess:^(NSArray *arr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择审批人" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for(StaffModel *model in arr){{
            
            //将除了自己之外的员工添加进选择列表
            if ([model.staff_id intValue] != [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
                
                [alert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    ApprovalIdsArrayModel *peopleModel = [[ApprovalIdsArrayModel alloc] init];
                    
                    peopleModel.uid = model.staff_id;
                    peopleModel.name = model.name;
                    peopleModel.head = model.head;
                    
                    [[CreatApprovalList sharedInstance].peopleArr addObject:peopleModel];
                    
                    [weakSelf refreshPhotoViewUI];
                }]];
            }
        }}
        
        [[weakSelf viewController] presentViewController:alert animated:YES completion:^{
            
        }];

        
    } Failure:^(NSError *error) {
       
        
    }];
    
}

- (void)onDelBtn:(UIButton *)btn{
    
    NSInteger a = btn.tag;
    [[CreatApprovalList sharedInstance].peopleArr removeObjectAtIndex:a-100];
    [self refreshPhotoViewUI];
}

#pragma mark - 获取view对应的控制器
- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
