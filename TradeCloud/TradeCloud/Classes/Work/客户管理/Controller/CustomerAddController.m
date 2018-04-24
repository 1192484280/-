//
//  CustomerAddController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerAddController.h"
#import "CustomerStore.h"
@interface CustomerAddController ()<UITextViewDelegate>
{
    
    IBOutlet UITextField *nameTf;
    IBOutlet UITextView *desTextView;
    IBOutlet UILabel *plasehoderLa;
    
}

@end

@implementation CustomerAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self setNavBarWithTitle:@"添加客户"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onSurebtn:)];
    
    desTextView.delegate = self;
    [desTextView wzb_autoHeightWithMaxHeight:kScreenHeight - (iPhoneX_Top) - 250 textViewHeightDidChanged:^(CGFloat currentTextViewHeight){
        NSLog(@"");
        
        
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length >0) {
        
        plasehoderLa.alpha = 0;
    }else{
        
        plasehoderLa.alpha = 1;
    }
}

- (void)onSurebtn:(UIBarButtonItem *)sender {
    
    [self.view endEditing:YES];
    
    if (!(nameTf.text.length > 0)) {
        
        return [self showMBPError:@"请输入客户名称"];
        
    }
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    NSString *des = nil;
    if (desTextView.text.length > 0) {
        
        des = desTextView.text;
    }
    [store addCustomerWithName:nameTf.text andDes:des Success:^{
        
        [weakSelf showMBPError:@"添加成功！"];
        
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

- (void)returnMyBlock:(myblock)block{
    
    self.block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
