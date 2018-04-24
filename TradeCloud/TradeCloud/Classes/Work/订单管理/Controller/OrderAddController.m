//
//  OrderAddController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderAddController.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "CustomerStore.h"
#import "CustomerModel.h"
#import "OrderStore.h"
#import "OrderAddParameterModel.h"

@interface OrderAddController ()<UITextViewDelegate,UITextFieldDelegate>
{
    
    IBOutlet UILabel *customerLa;
    IBOutlet UITextField *kuanhaoTf;
    IBOutlet UITextField *numTf;
    IBOutlet UILabel *factoryLa;
    IBOutlet UILabel *typeLa;
    IBOutlet UILabel *stateLa;
    IBOutlet UILabel *desLa;
    IBOutlet UITextView *desTw;
}

@property (strong, nonatomic) OrderAddParameterModel *parameterModel;

@end

@implementation OrderAddController

- (OrderAddParameterModel *)parameterModel{

    if (!_parameterModel) {
        
        _parameterModel = [[OrderAddParameterModel alloc] init];
        _parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
        _parameterModel.company_id = [UserDefaultsTool getObjWithKey:@"company_id"];
        _parameterModel.department_id = [UserDefaultsTool getObjWithKey:@"department_id"];
    }
    
    return _parameterModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"添加订单"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(sure)];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    
    desTw.delegate = self;
    kuanhaoTf.delegate = self;
    numTf.delegate = self;
    
    kuanhaoTf.keyboardType = UIKeyboardTypeNumberPad;
    numTf.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.placeholder isEqualToString:@"请输入款号"]) {
        
        self.parameterModel.section_number = textField.text;
    }else{
        
        self.parameterModel.num = textField.text;
    }
    
}
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        desLa.alpha = 0;
    }else{
        
        desLa.alpha = 1;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.parameterModel.note = textView.text;
}

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
                
                customerLa.text = model.customer_name ;
                weakSelf.parameterModel.customer_id = model.customer_id;
            }]];
            
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
        
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)onFactoryBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getFactoryListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择工厂" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                factoryLa.text = model.value;
                self.parameterModel.factory_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
    
}
- (IBAction)onTypeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getGoodstypeListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                typeLa.text = model.value;
                self.parameterModel.goods_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}
- (IBAction)onStateBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"发布" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        stateLa.text = @"发布";
        self.parameterModel.status = @"1";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"暂停" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        stateLa.text = @"暂停";
        self.parameterModel.status = @"2";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        stateLa.text = @"完成";
        self.parameterModel.status = @"3";
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

- (void)sure{
    
    [self.view endEditing:YES];
    
    if (!self.parameterModel.customer_id) {
        
        return [self showMBPError:@"请选择客户!"];
    }
    
    if ( !(self.parameterModel.section_number.length > 0)) {
        
        return [self showMBPError:@"请填写款号!"];
    }
    
    if (!(self.parameterModel.num.length > 0)) {
        
        return [self showMBPError:@"请填写数量!"];
    }
    
    if (!self.parameterModel.factory_id) {
        
        return [self showMBPError:@"请选择工厂!"];
    }
    
    if (!self.parameterModel.goods_type_id) {
        
        return [self showMBPError:@"请选择类型!"];
    }
    
    if (!self.parameterModel.status) {
        
        return [self showMBPError:@"请选择状态!"];
    }
    
    OrderStore *store = [[OrderStore alloc] init];
    MJWeakSelf
    [store addOrderWithParameterModel:self.parameterModel Success:^{
        
        [weakSelf showMBPError:@"添加成功!"];
        
        if (weakSelf.block != nil) {
            
            weakSelf.block();
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } Failure:^(NSError *error) {
        
        [HttpTool handleError:error];
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
