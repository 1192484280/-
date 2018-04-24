//
//  CustomerDetailController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerDetailController.h"
#import "CustomerStore.h"
#import "CustomerDetailModel.h"

@interface CustomerDetailController ()<UITextViewDelegate>
{
    IBOutlet UITextField *nameTf;
    IBOutlet UITextView *desTw;
    IBOutlet UILabel *desLa;
}

@end



@implementation CustomerDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"EFEFF4"];
    desTw.delegate = self;
    
    [self setNavBarWithTitle:@"客户详情"];
    
    if (_ifEdit) {
        
        self.navigationItem.rightBarButtonItem =[ [UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onSave)];
    }else{
        
        desTw.editable = NO;
        nameTf.enabled = NO;
    }
    
    
    [self refresh];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        desLa.alpha = 0;
    }else{
        
        desLa.alpha = 1;
    }
}
- (void)refresh{
    
    [SVProgressHUD show];
    
    CustomerStore *store = [[CustomerStore alloc] init];
    [store getCustomerDetailWithId:self.customer_id Success:^(CustomerDetailModel *model) {
        
        [self setUIWithModel:model];
        [SVProgressHUD dismiss];
        
    } Failure:^(NSError *error) {
        
        [self showMBPError:[HttpTool handleError:error]];
        [SVProgressHUD dismiss];
    }];
}
- (void)onSave{

    if (!(nameTf.text.length > 0)) {
        
        return [self showMBPError:@"请输入客户名称!"];
    }
    [nameTf resignFirstResponder];
    [self.view endEditing:YES];
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    NSString *des = nil;
    if (desTw.text.length > 0) {
        
        des = desTw.text;
    }
    [store editCustomerInfoWithId:self.customer_id andName:nameTf.text andDes:des Success:^{
        
        [weakSelf showMBPError:@"修改成功!"];
        
        if (weakSelf.block != nil) {
            
            weakSelf.block();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } Failure:^(NSError *error) {
       
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
    
}

- (void)setUIWithModel:(CustomerDetailModel *)model{
    
    nameTf.text = model.name;
    desTw.text = model.des;
    if (desTw.text.length > 0) {
        
        desLa.alpha = 0;
    }
    
    
}

- (void)returnMyBlock:(myblock)block{
    
    self.block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
