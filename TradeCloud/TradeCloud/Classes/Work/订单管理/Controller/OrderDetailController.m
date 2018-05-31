//
//  OrderDetailController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/13.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderStore.h"
#import "OrderDetailModel.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "CustomerStore.h"
#import "CustomerModel.h"
#import "OrderAddParameterModel.h"

@interface OrderDetailController ()<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *customerBtn;
@property (strong, nonatomic) IBOutlet UITextField *kuanhaoTf;
@property (strong, nonatomic) IBOutlet UITextField *numTf;
@property (strong, nonatomic) IBOutlet UIButton *factoryBtn;
@property (strong, nonatomic) IBOutlet UIButton *typeBtn;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
@property (strong, nonatomic) IBOutlet UITextView *desTw;
@property (strong, nonatomic) IBOutlet UILabel *desLa;

@property (strong, nonatomic) OrderAddParameterModel *parameterModel;

@end

@implementation OrderDetailController

- (OrderAddParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[OrderAddParameterModel alloc] init];
        _parameterModel.order_id = self.order_id;
        _parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
        _parameterModel.company_id = [UserDefaultsTool getObjWithKey:@"company_id"];
        _parameterModel.department_id = [UserDefaultsTool getObjWithKey:@"department_id"];
    }
    
    return _parameterModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"订单详细"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    
    _kuanhaoTf.delegate = self;
    _numTf.delegate = self;
    _desTw.delegate = self;
    
    _kuanhaoTf.keyboardType = UIKeyboardTypeNumberPad;
    _numTf.keyboardType = UIKeyboardTypeNumberPad;
    
    if (_ifEdit) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
        
    }else{
        
        _customerBtn.enabled = NO;
        _factoryBtn.enabled = NO;
        _typeBtn.enabled = NO;
        _stateBtn.enabled = NO;
        _kuanhaoTf.enabled = NO;
        _numTf.enabled = NO;
        _desTw.editable = NO;
    }
    
    [self refresh];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.placeholder isEqualToString:@"输入款号"]) {
        
        self.parameterModel.section_number = textField.text;
    }else{
        
        self.parameterModel.num = textField.text;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        _desLa.alpha = 0;
    }else{
        
        _desLa.alpha = 1;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.parameterModel.note = textView.text;
}

- (void)save{
    
    [self.view endEditing:YES];
    
    if ( !(self.parameterModel.section_number.length > 0)) {
        
        return [self showMBPError:@"请填写款号!"];
    }
    
    if (!(self.parameterModel.num.length > 0)) {
        
        return [self showMBPError:@"请填写数量!"];
    }
    
    OrderStore *store = [[OrderStore alloc] init];
    MJWeakSelf
    [store editOrderWithParameterModel:self.parameterModel Success:^{
        
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
- (void)refresh{

    OrderStore *store = [[OrderStore alloc] init];
    
    MJWeakSelf
    [store getorderDetailWithId:self.order_id Success:^(OrderDetailModel *model) {
        
        [weakSelf setParameterModelWith:model];
        
        [weakSelf.customerBtn setTitle:model.customer_name forState:UIControlStateNormal];
        weakSelf.kuanhaoTf.text = model.section_number;
        weakSelf.numTf.text = model.num;
        [weakSelf.factoryBtn setTitle:model.factory_name forState:UIControlStateNormal];
        [weakSelf.typeBtn setTitle:model.goods_type_name forState:UIControlStateNormal];
        NSString *state = @"";
        if ([model.status intValue] == 0) {
            
            state = @"未发布";
        }else if ([model.status intValue] == 1){
            
            state = @"发布";
        }else if ([model.status intValue] == 2){
            
            state = @"暂停";
        }else if ([model.status intValue] == 3){
            
            state = @"完成";
        }
        [weakSelf.stateBtn setTitle:state forState:UIControlStateNormal];
        weakSelf.desTw.text = model.note;
        if (model.note.length >0) {
            
            weakSelf.desLa.alpha = 0;
        }else{
            
            weakSelf.desLa.alpha = 1;
        }
        
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
        
    }];
}

- (void)setParameterModelWith:(OrderDetailModel *)model{

    self.parameterModel.customer_id = model.customer_id;
    self.parameterModel.section_number = model.section_number;
    self.parameterModel.num = model.num;
    self.parameterModel.factory_id = model.factory_id;
    self.parameterModel.goods_type_id = model.goods_type_id;
    self.parameterModel.status = model.status;
    self.parameterModel.note = model.note;

}

- (IBAction)onCustomerBtn:(UIButton *)sender {
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    [store getCustomerListWithPage:@"1" andNum:@"99999" andCustomerName:nil success:^(NSArray *arr, BOOL haveMore) {
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (CustomerModel *model in arr) {
            
            [alert addAction:[UIAlertAction actionWithTitle:model.customer_name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.customerBtn setTitle:model.customer_name forState:UIControlStateNormal];
                
                weakSelf.parameterModel.customer_id = model.customer_id;
            }]];
            
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];

        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)onFactoryBtn:(UIButton *)sender {
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getFactoryListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择工厂" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.factoryBtn setTitle:model.value forState:UIControlStateNormal];
                
                weakSelf.parameterModel.factory_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}

- (IBAction)onTypeBtn:(UIButton *)sender {
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getGoodstypeListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.typeBtn setTitle:model.value forState:UIControlStateNormal];
                
                weakSelf.parameterModel.goods_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}

- (IBAction)onStateBtn:(UIButton *)sender {
    
    MJWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"发布" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.stateBtn setTitle:@"发布" forState:UIControlStateNormal];
        
        weakSelf.parameterModel.status = @"1";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"暂停" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.stateBtn setTitle:@"暂停" forState:UIControlStateNormal];
        weakSelf.parameterModel.status = @"2";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.stateBtn setTitle:@"完成" forState:UIControlStateNormal];
        weakSelf.parameterModel.status = @"3";
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

- (void)returnMyBlock:(myblock)block{
    
    self.block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
