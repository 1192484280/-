//
//  OrderCostDetailController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/16.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostDetailController.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "CustomerStore.h"
#import "CustomerModel.h"
#import "OrderCostAddParameterModel.h"
#import "OrderCostStore.h"
#import "OrderCostDetailModel.h"
#import <UIButton+WebCache.h>
#import "TZImagePickerController.h"
#import "BRPickerView.h"

@interface OrderCostDetailController ()<UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *customerBtn;
@property (strong, nonatomic) IBOutlet UIButton *kuanhaoBtn;

@property (strong, nonatomic) IBOutlet UITextField *moneyTf;
@property (strong, nonatomic) IBOutlet UIButton *timeBtn;

@property (strong, nonatomic) IBOutlet UIButton *payType;

@property (strong, nonatomic) IBOutlet UIButton *typeBtn;

@property (strong, nonatomic) IBOutlet UITextView *explainTw;
@property (strong, nonatomic) IBOutlet UITextView *remarkTw;
@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *photoView_width;

@property (strong, nonatomic) OrderCostAddParameterModel *parameterModel;

@property (strong, nonatomic) NSMutableArray *imgArr;

@property (copy, nonatomic) NSArray *origArr;

@end

@implementation OrderCostDetailController

- (NSMutableArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
- (OrderCostAddParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[OrderCostAddParameterModel alloc] init];
        _parameterModel.cost_id = self.cost_id;
    }
    
    return _parameterModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ECECF1"];
    
    [self setNavBarWithTitle:@"订单成本管理详情"];
    
    if (_ifEdit) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveBtn)];
        
    }else{
        
        _moneyTf.enabled = NO;
        _explainTw.editable = NO;
        _remarkTw.editable = NO;
        _payType.enabled = NO;
        _timeBtn.enabled = NO;
        _typeBtn.enabled = NO;
        
    }
    
    
    
    _moneyTf.delegate = self;
    _moneyTf.keyboardType = UIKeyboardTypeNumberPad;
    _explainTw.delegate = self;
    _remarkTw.delegate = self;
    _explainTw.tag = 10;
    _remarkTw.tag = 11;
    [_moneyTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self refresh];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _moneyTf) {
        
        if (textField.text.length > 8) {
            
            textField.text = [textField.text substringToIndex:8];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.parameterModel.money = textField.text;
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.tag == 10) {
        
        self.parameterModel.pay_instructions = textView.text;
    }else{
        
        self.parameterModel.note = textView.text;
    }
}
- (void)refresh{
    
    OrderCostStore *store = [[OrderCostStore alloc] init];
    [store getDetailWithId:self.cost_id Success:^(OrderCostDetailModel *model) {
        
        [self refreshUIWithModel:model];
        
    } Failure:^(NSError *error) {
        
        [self showMBPError:[HttpTool handleError:error]];
    }];
}

- (void)refreshUIWithModel:(OrderCostDetailModel *)model{
    
    [self.customerBtn setTitle:model.customer_name forState:UIControlStateNormal];
    [self.kuanhaoBtn setTitle:model.section_number forState:UIControlStateNormal];
    _moneyTf.text = model.money;
    [self.payType setTitle:model.pay_name forState:UIControlStateNormal];
    [self.timeBtn setTitle:model.pay_time forState:UIControlStateNormal];
    [self.typeBtn setTitle:model.pay_type_name forState:UIControlStateNormal];
    self.explainTw.text = model.pay_instructions;
    self.remarkTw.text = model.note;
    
    
    
    self.parameterModel.money = model.money;
    self.parameterModel.pay_name = model.pay_name;
    self.parameterModel.pay_time = model.pay_time;
    self.parameterModel.pay_type_id = model.pay_type_id;
    self.parameterModel.pay_instructions = model.pay_instructions;
    self.parameterModel.note = model.note;
    self.origArr = model.attachments;
    [self.imgArr addObjectsFromArray:model.attachments];
    [self refreshPhotoViewUI];
}

- (void)onPhotoBtn:(UIButton *)btn{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.imgArr addObjectsFromArray:photos];
        
        [self refreshPhotoViewUI];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)refreshPhotoViewUI{
    
    for (UIView *view in _photoView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    for (int i =0 ; i< self.imgArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16*(i+1) + 65*i , 17.5, 65, 65)];
        if ([[self.imgArr[i] class] isEqual:[UIImage class]]) {
            
            [btn setImage:self.imgArr[i] forState:UIControlStateNormal];
        }else{
            
            [btn sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pic_add"]];
        }
        
        [self.photoView addSubview:btn];
        
        if (_ifEdit) {
            
            UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(16*(i+1) + 65*i - 10 , 7.5, 20, 20)];
            [delBtn setImage:[UIImage imageNamed:@"deleBtn"] forState:UIControlStateNormal];
            delBtn.tag = 100 + i;
            [delBtn addTarget:self action:@selector(onDelBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.photoView addSubview:delBtn];
        }else{
            
            _photoView_width.constant = (CGRectGetMaxX(btn.frame)) + 30;
        }
    }
    
    if (_ifEdit) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16*(self.imgArr.count + 1) + 65*(self.imgArr.count) , 17.5, 65, 65)];
        [btn setImage:[UIImage imageNamed:@"pic_add"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:btn];
        
        _photoView_width.constant = (CGRectGetMaxX(btn.frame)) + 30;
    }
    
}
- (void)onSaveBtn{
    
    
    
    [self.view endEditing:YES];
    
    BOOL isExist = YES;
    for (int i = 0; i<self.imgArr.count; i++) {
        
        if ([self.imgArr[i] isKindOfClass:[UIImage class]]) {
            
            isExist = NO;
        }
    }
    
    if (self.imgArr.count == self.origArr.count && isExist) {
        
        [self save];
        
        return;
    }
    
    
    if (isExist) {
        
        NSMutableArray *urlArr = [NSMutableArray array];
        for (int i = 0; i<self.imgArr.count; i++) {
            
            [urlArr addObject:self.imgArr[i]];
        }
        
        self.parameterModel.attachments = [urlArr mj_JSONString];
        [self save];
        
        return;
    }
    
    
   [self.view makeToastActivity:CSToastPositionCenter];
    
    NSMutableArray *urlArr = [NSMutableArray array];
    NSMutableArray *imArr = [NSMutableArray array];
    for (int i = 0; i < self.imgArr.count ; i++) {
        
        if ([[self.imgArr[i] class] isEqual:[UIImage class]]) {
            
            [imArr addObject:self.imgArr[i]];
        }else{
            
            [urlArr addObject:self.imgArr[i]];
        }
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    MJWeakSelf
    for (int i =0; i<imArr.count; i++) {
        
        
        //任务1
        dispatch_async(quene, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            CommonStore *store = [[CommonStore alloc] init];
            [store upPhoto:imArr[i] Success:^(NSString *imgUrl) {
                
                [urlArr addObject:imgUrl];
                
                dispatch_semaphore_signal(semaphore);
                
                if (i == imArr.count - 1) {
                    
                    weakSelf.parameterModel.attachments = [urlArr mj_JSONString];
                    [weakSelf save];
                }
                
            } Failure:^(NSError *error) {
                
                
                return [weakSelf showMBPError:[HttpTool handleError:error]];
            }];
            
        });
        
        
    }
}

- (void)save{
    
    MJWeakSelf
    OrderCostStore *store = [[OrderCostStore alloc] init];
    [store editWithParameterModel:self.parameterModel Success:^{
        
        [self.view hideToastActivity];
        [weakSelf showMBPError:@"修改成功!"];
        
        if (weakSelf.block != nil) {
            
            weakSelf.block();
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } Failure:^(NSError *error) {
        
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}
- (IBAction)onCustomerBtn:(UIButton *)sender {

}

- (IBAction)onSectionNumBtn:(UIButton *)sender {
}
- (IBAction)onPayTypeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    MJWeakSelf
    NSString *pay1 = @"支付宝";
    NSString *pay2 = @"微信";
    NSString *pay3 = @"现金";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择付款方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [sender setTitle:pay1 forState:UIControlStateNormal];
        weakSelf.parameterModel.pay_name = pay1;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [sender setTitle:pay2 forState:UIControlStateNormal];
        weakSelf.parameterModel.pay_name = pay2;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [sender setTitle:pay3 forState:UIControlStateNormal];
        weakSelf.parameterModel.pay_name = pay3;
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
- (IBAction)onTimeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSDate *minDate = [NSDate setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    
    MJWeakSelf
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        
        [sender setTitle:selectValue forState:UIControlStateNormal];
        weakSelf.parameterModel.pay_time = selectValue;
        
    } cancelBlock:^{
        
        
    }];
    
}
- (IBAction)onTypeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getPayTypeListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择支出类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [sender setTitle:model.value forState:UIControlStateNormal];
                weakSelf.parameterModel.pay_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)returnMyBlock:(myblock)block{
    
    self.block = block;
}


- (void)onDelBtn:(UIButton *)btn{
    
    NSInteger a = btn.tag;
    [self.imgArr removeObjectAtIndex:a-100];
    [self refreshPhotoViewUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
