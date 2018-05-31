//
//  OrderCostAddController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostAddController.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "CustomerStore.h"
#import "CustomerModel.h"
#import "OrderStore.h"
#import "OrderList.h"
#import "OrderModel.h"
#import "OrderCostAddParameterModel.h"
#import "OrderCostStore.h"
#import "TZImagePickerController.h"
#import "NSArray+json.h"
#import "BRPickerView.h"

@interface OrderCostAddController ()<UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *customerLa;
@property (strong, nonatomic) IBOutlet UILabel *kuanhaoLa;
@property (strong, nonatomic) IBOutlet UILabel *payTypeLa;
@property (strong, nonatomic) IBOutlet UITextField *payTf;
@property (strong, nonatomic) IBOutlet UILabel *payTime;
@property (strong, nonatomic) IBOutlet UILabel *typeLa;
@property (strong, nonatomic) IBOutlet UITextView *explainTw;
@property (strong, nonatomic) IBOutlet UITextView *remarkTw;
@property (strong, nonatomic) IBOutlet UILabel *explainLa;
@property (strong, nonatomic) IBOutlet UILabel *remarkLa;
@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *photoView_width;

@property (strong, nonatomic) OrderCostAddParameterModel *parameterModel;

@property (strong, nonatomic) NSMutableArray *imgArr;

@end

@implementation OrderCostAddController

- (NSMutableArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (OrderCostAddParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[OrderCostAddParameterModel alloc] init];
        _parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
        _parameterModel.company_id = [UserDefaultsTool getObjWithKey:@"company_id"];
        _parameterModel.department_id = [UserDefaultsTool getObjWithKey:@"department_id"];
    }
    
    return _parameterModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self setNavBarWithTitle:@"添加订单成本"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(sure)];
    
    
    _payTf.delegate = self;
    _payTf.keyboardType = UIKeyboardTypeNumberPad;
    [_payTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _explainTw.delegate = self;
    _explainTw.tag = 10;
    
    _remarkTw.delegate = self;
    _remarkTw.tag = 11;
    
    [OrderList sharedInstance].parameterModel.page = 1;
    [OrderList sharedInstance].parameterModel.num = @"999";
    
    _photoView_width.constant = kScreenWidth;
    
    
}

- (void)textFieldDidChange:(UITextField *)textField

{
    
    if (textField == _payTf) {
        
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

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.tag == 10) {
        
        if (textView.text.length > 0) {
            
            self.explainLa.alpha = 0;
        }else{
            
            self.explainLa.alpha = 1;
        }
    }else{
        
        if (textView.text.length > 0) {
            
            self.remarkLa.alpha = 0;
        }else{
            
            self.remarkLa.alpha = 1;
        }
    }
}
#pragma mark - 选择客户
- (IBAction)onCustomerBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    [store getCustomerListWithPage:@"1" andNum:@"99999" andCustomerName:nil success:^(NSArray *arr, BOOL haveMore) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (CustomerModel *model in arr) {
            
            [alert addAction:[UIAlertAction actionWithTitle:model.customer_name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                weakSelf.customerLa.text = model.customer_name;
                
                [OrderList sharedInstance].parameterModel.customer_id = model.customer_id;
            }]];
            
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 选择款号
- (IBAction)onKuanHaoBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (!([OrderList sharedInstance].parameterModel.customer_id.length > 0)) {
        
        return [self showMBPError:@"请先选择客户"];
    }
    OrderStore *store = [[OrderStore alloc] init];
    
    MJWeakSelf
    [store getListWithOrderParameterModel:[OrderList sharedInstance].parameterModel Success:^(NSArray *listArr, BOOL haveMore) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择款号" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (OrderModel *model in listArr) {
            
            [alert addAction:[UIAlertAction actionWithTitle:model.section_number style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                weakSelf.kuanhaoLa.text = model.section_number;
                
                weakSelf.parameterModel.order_id = model.order_id;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];

        
    } Failure:^(NSError *error) {
       
        [self showMBPError:[HttpTool handleError:error]];
    }];
}

#pragma mark - 点击付款方式
- (IBAction)onPayType:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    MJWeakSelf
    NSString *pay1 = @"支付宝";
    NSString *pay2 = @"微信";
    NSString *pay3 = @"现金";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择付款方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.payTypeLa.text = pay1;
        weakSelf.parameterModel.pay_name = pay1;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.payTypeLa.text = pay2;
        weakSelf.parameterModel.pay_name = pay2;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:pay3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.payTypeLa.text = pay3;
        weakSelf.parameterModel.pay_name = pay3;
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

#pragma mark - 点选择支付时间
- (IBAction)onPayTimeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSDate *minDate = [NSDate setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    MJWeakSelf
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        
        weakSelf.payTime.text = selectValue;
        weakSelf.parameterModel.pay_time = selectValue;
        
    } cancelBlock:^{
        
        
    }];
    
    
}

#pragma mark - 选择支出类型
- (IBAction)onGoodsTypeBtn:(UIButton *)sender {
    
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
                
                weakSelf.typeLa.text = model.value;
                weakSelf.parameterModel.pay_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];

    } Failure:^(NSError *error) {
        
    }];
}

- (void)sure{
    
    [self.view endEditing:YES];


    if (!(self.parameterModel.order_id.length > 0)) {

        return [self showMBPError:@"选择款号"];
    }

    if (!(self.parameterModel.money.length > 0)) {

        return [self showMBPError:@"填写支出"];
    }

    if (!(self.parameterModel.pay_name.length > 0)) {

        return [self showMBPError:@"选择付款方式"];
    }

    if (!(self.parameterModel.pay_time.length > 0)) {

        return [self showMBPError:@"选择支出时间"];
    }

    if (!(self.parameterModel.pay_type_id.length > 0)) {

        return [self showMBPError:@"选择支出类型"];
    }

    if (!(self.parameterModel.pay_instructions.length > 0)) {

        return [self showMBPError:@"填写支出说明"];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view makeToastActivity:CSToastPositionCenter];
    
    
    
    if (!(self.imgArr.count > 0)) {
        
        [self save];
        return;
        
    }
    
    
    //信号量实现请求完一次接口再请求一次
    NSMutableArray *imgUrlArr = [NSMutableArray array];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    MJWeakSelf
    for (int i =0; i<self.imgArr.count; i++) {
        
        
        //任务1
        dispatch_async(quene, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            CommonStore *store = [[CommonStore alloc] init];
            [store upPhoto:weakSelf.imgArr[i] Success:^(NSString *imgUrl) {
                
                [imgUrlArr addObject:imgUrl];
                
                dispatch_semaphore_signal(semaphore);
                
                if (i == weakSelf.imgArr.count - 1) {
                    
                    weakSelf.parameterModel.attachments = [imgUrlArr mj_JSONString];
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
    [store addOrderCostWithParameterModel:self.parameterModel Success:^{
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.view hideToastActivity];
        
        
        [weakSelf showMBPError:@"添加成功!"];
        
        if (weakSelf.block != nil) {
            
            weakSelf.block();
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } Failure:^(NSError *error) {
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.view hideToastActivity];
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}

- (void)returnMyBlock:(myblock)block{
    
    self.block = block;
}


- (IBAction)onPhotoBtn:(UIButton *)sender {
    
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
        [btn setImage:self.imgArr[i] forState:UIControlStateNormal];
        
        [self.photoView addSubview:btn];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(16*(i+1) + 65*i - 10 , 7.5, 20, 20)];
        [delBtn setImage:[UIImage imageNamed:@"deleBtn"] forState:UIControlStateNormal];
        delBtn.tag = 100 + i;
        [delBtn addTarget:self action:@selector(onDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:delBtn];
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16*(self.imgArr.count + 1) + 65*(self.imgArr.count) , 17.5, 65, 65)];
    [btn setImage:[UIImage imageNamed:@"pic_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView addSubview:btn];
    
    _photoView_width.constant = (CGRectGetMaxX(btn.frame)) + 30;
    
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
