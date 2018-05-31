//
//  ReimbursMiddleCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/21.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReimbursMiddleCell.h"
#import "FieldDataModel.h"
#import "ShowImgController.h"

@interface ReimbursMiddleCell ()
{
    FieldDataModel *_model;
}
@end

@implementation ReimbursMiddleCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath withModel:(FieldDataModel *)model{
    
    NSString *identity = @"CELL1";
    NSInteger index = 0;
    NSLog(@"%@",model.value);
    if ([model.value hasPrefix:@"["]) {
        
        identity = @"CELL3";
        index = 2;
        
    }else if ([model.value hasPrefix:IP]){
        
        identity = @"CELL2";
        index = 1;
        
    } else{
        
        identity = @"CELL1";
        index = 0;
    }
    
    ReimbursMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath andModel:(FieldDataModel *)model{
    
    NSInteger index = 0;
    
    if ([model.value hasPrefix:@"["]) {
        
        
        index = 2;
        
    }else if ([model.value hasPrefix:IP]){
        
        index = 1;
        
    } else{
        
        index = 0;
    }
    UITableViewCell *cell = [self cellWithIndex:index];
    return cell.frame.size.height;
}

+ (instancetype)cellWithIndex:(NSInteger )index{
    
    ClassName
    
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:index];
}

- (void)setModel:(FieldDataModel *)model{
    
    _model = model;
    if ([model.value hasPrefix:@"["]) {
        
        self.titleLa3.text = model.label_name;
        NSArray *arr = [self stringToJSON:model.value];
        [self refreshPhotoViewUIwithArr:arr];
        
    }else if ([model.value hasPrefix:IP]){
        
        self.titleLa2.text = model.label_name;
        
        [self.singleImBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.value] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pic_add"]];
    } else{
        
        self.titleLa1.text = model.label_name;
        self.valueLa1.text = model.value;
    }
}



#pragma mark - json转数组
- (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}


- (void)refreshPhotoViewUIwithArr:(NSArray *)arr{
    
    for (int i =0 ; i< arr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(65*i , 2, 55, 55)];
        objc_setAssociatedObject(btn, "imgStr", arr[i], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:arr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pic_add"]];
        [btn addTarget:self action:@selector(onManyImSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:btn];
        
        if (i == arr.count - 1) {
            
            self.photoWidth.constant = (CGRectGetMaxX(btn.frame)) + 30;
        }
    }
}
- (IBAction)onSingleImBtn:(UIButton *)sender {
    
    ShowImgController *VC = [[ShowImgController alloc] init];
    
    VC.imgStr = _model.value;
    
    VC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [[self viewController] presentViewController:VC animated:YES completion:nil];
}


- (void)onManyImSelect:(UIButton *)sender{
    
    NSString *imgStr = objc_getAssociatedObject(sender, "imgStr");
    
    ShowImgController *VC = [[ShowImgController alloc] init];
    
    VC.imgStr = imgStr;
    
    VC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [[self viewController] presentViewController:VC animated:YES completion:nil];
}

//获取view对应的控制器
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
