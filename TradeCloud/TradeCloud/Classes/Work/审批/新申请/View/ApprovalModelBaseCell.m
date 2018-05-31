//
//  ApprovalModelBaseCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ApprovalModelBaseCell.h"
#import "CreatApprovalDataModel.h"
#import "TZImagePickerController.h"
#import "OptionsModel.h"
#import "BRPickerView.h"
#import "CreatApprovalList.h"
#import "ManySelectView.h"
#import "CommonStore.h"

@interface ApprovalModelBaseCell()<TZImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    CreatApprovalDataModel *_model;
}

@property (strong, nonatomic) NSMutableArray *imgArr;

@end

@implementation ApprovalModelBaseCell

- (NSMutableArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

+ (instancetype)tempWithTableView:(UITableView *)tableView andModel:(CreatApprovalDataModel *)model{
    
    NSInteger type = [model.type intValue];
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (type) {
        case 1:
            identity = @"CELL1";
            index = 0;
            break;
        case 2:
        case 3:
            identity = @"CELL2";
            index = 1;
            break;
        case 4:
        case 5:
            identity = @"CELL3";
            index = 2;
            break;
        case 6:
            identity = @"CELL4";
            index = 3;
            break;
        case 7:
        case 8:
            identity = @"CELL5";
            index = 4;
            break;
        case 9:
            identity = @"CELL6";
            index = 5;
            break;
        case 10:
            identity = @"CELL7";
            index = 6;
            break;
        default:
            identity = @"CELL1";
            index = 0;
            break;
    }
    ApprovalModelBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

+ (CGFloat)getHeightWithModel:(CreatApprovalDataModel *)model{
    
    UITableViewCell *cell = [self cellWithModel:model];
    return cell.frame.size.height;
}

+ (instancetype)cellWithModel:(CreatApprovalDataModel *)model{
    
    ClassName
    
    NSInteger type = [model.type intValue];
    
    NSInteger index = 0;
    switch (type) {
        case 1:
            index = 0;
            break;
        case 2:
        case 3:
            index = 1;
            break;
        case 4:
        case 5:
            index = 2;
            break;
        case 6:
            index = 3;
            break;
        case 7:
        case 8:
            index = 4;
            break;
        case 9:
            index = 5;
            break;
        case 10:
            index = 6;
            break;
        default:
            index = 0;
            break;
    }
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:index];
}

- (void)setModel:(CreatApprovalDataModel *)model{

    _model = model;
    
    NSInteger require = [model.require intValue];
    
    NSInteger type = [model.type intValue];
    switch (type) {
        case 1:
            self.title1.text = model.label_name;
            self.tf.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            if (require != 1) {
                
                self.star1.alpha = 0;
            }
            break;
        case 2:
        case 3:
            self.title2.text = model.label_name;
            self.tw.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            if (require != 1) {
                
                self.star2.alpha = 0;
            }
            break;
        case 4:
        case 5:
            self.title3.text = model.label_name;
            if (require != 1) {
                
                self.star3.alpha = 0;
            }
            break;
        case 6:
            self.title4.text = model.label_name;
            if (require != 1) {
                
                self.star4.alpha = 0;
            }
            break;
        case 7:
        case 8:
            self.title5.text = model.label_name;
            self.value5.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            if (require != 1) {
                
                self.star5.alpha = 0;
            }
            break;
        case 9:
            self.title6.text = model.label_name;

            self.value6.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            
            
            if (require != 1) {
                
                self.star6.alpha = 0;
            }
            break;
        case 10:
            self.title7.text = model.label_name;
            self.value7.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            if (require != 1) {
                
                self.star7.alpha = 0;
            }
            break;
        default:
            self.title1.text = model.label_name;
            self.tf.text = [CreatApprovalList sharedInstance].approvalDic[model.value_name];
            if (require != 1) {
                
                self.star1.alpha = 0;
            }
            break;
    }
}

#pragma mark - 单图上传
- (IBAction)onPicBtn:(UIButton *)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.singleImBtn setImage:photos[0] forState:UIControlStateNormal];
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(quene, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            CommonStore *store = [[CommonStore alloc] init];
            [store upPhoto:photos[0] Success:^(NSString *imgUrl) {
                
                dispatch_semaphore_signal(semaphore);
                
                [[CreatApprovalList sharedInstance].approvalDic setObject:imgUrl forKey:_model.value_name];
                
            } Failure:^(NSError *error) {
                
            }];
            
            
        });
        
        //[[CreatApprovalList sharedInstance].approvalDic setObject:photos[0] forKey:_model.label_name];
    }];
    
    [[self viewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 多图上传
- (IBAction)onManyPicBtn:(UIButton *)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.imgArr addObjectsFromArray:photos];
    
        [self refreshPhotoViewUI];
        
    }];
    
    [[self viewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 下拉/单选
- (IBAction)onSelectBtn:(UIButton *)sender {
    
    //放下键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSArray *arr = [OptionsModel mj_objectArrayWithKeyValuesArray:_model.options];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    for (OptionsModel *model in arr) {
        
        [alert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.value5.text = model.name;
            
            [[CreatApprovalList sharedInstance].approvalDic setObject:model.name forKey:_model.value_name];
            
        }]];
    }
    
    [[self viewController] presentViewController:alert animated:YES completion:^{
        
    }];

}

#pragma mark - 多选
- (IBAction)onManySelectBtn:(UIButton *)sender{
    
    //放下键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSArray *arr = [OptionsModel mj_objectArrayWithKeyValuesArray:_model.options];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onManySelectBtnwithArr:withModel: andIndexPath:)]) {
        
        [self.delegate onManySelectBtnwithArr:arr withModel:_model andIndexPath:self.indexPath];
    }
    
    
    
    
//    NSArray *arr = [OptionsModel mj_objectArrayWithKeyValuesArray:_model.options];
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//
//    for (OptionsModel *model in arr) {
//
//        [alert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            self.value6.text = model.name;
//            [[CreatApprovalList sharedInstance].approvalDic setObject:model.name forKey:_model.label_name];
//        }]];
//    }
//
//    [[self viewController] presentViewController:alert animated:YES completion:^{
//
//    }];
    
}

- (void)refreshPhotoViewUI{
    
    [[CreatApprovalList sharedInstance].approvalDic setObject:self.imgArr forKey:_model.value_name];
    
    for (UIView *view in self.photoView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    for (int i =0 ; i< self.imgArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(32*(i+1) + 65*i , 16, 65, 65)];
        [btn setImage:self.imgArr[i] forState:UIControlStateNormal];
        
        [self.photoView addSubview:btn];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(32*(i+1) + 65*i -10, 16-10, 20, 20)];
        [delBtn setImage:[UIImage imageNamed:@"deleBtn"] forState:UIControlStateNormal];
        delBtn.tag = 100 + i;
        [delBtn addTarget:self action:@selector(onDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:delBtn];
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(32*(self.imgArr.count + 1) + 65*(self.imgArr.count) , 16, 65, 65)];
    [btn setImage:[UIImage imageNamed:@"pic_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onManyPicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView addSubview:btn];
    
    self.photoWidth.constant = (CGRectGetMaxX(btn.frame)) + 30;
    
}

- (void)onDelBtn:(UIButton *)btn{
    
    NSInteger a = btn.tag;
    [self.imgArr removeObjectAtIndex:a-100];
    [self refreshPhotoViewUI];
}



#pragma mark - 选择日期
- (IBAction)onDateBtn:(UIButton *)sender {
    
    //放下键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSDate *minDate = [NSDate setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {

        self.value7.text = selectValue;

        [[CreatApprovalList sharedInstance].approvalDic setObject:selectValue forKey:_model.value_name];

    } cancelBlock:^{


    }];
    
    
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

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"%@",textField.text);
    [[CreatApprovalList sharedInstance].approvalDic setObject:textField.text forKey:_model.value_name];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        self.placeLa.alpha = 0;
    }else{
        
        self.placeLa.alpha = 1;
    }
    
    [[CreatApprovalList sharedInstance].approvalDic setObject:textView.text forKey:_model.value_name];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tf.delegate = self;
    self.tw.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
