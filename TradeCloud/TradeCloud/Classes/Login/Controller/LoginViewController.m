//
//  LoginViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarController.h"
#import "ForgetOneController.h"
#import "LoginStore.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *telText;
@property (strong, nonatomic) IBOutlet UITextField *passText;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _telText.keyboardType = UIKeyboardTypeNumberPad;
    _passText.secureTextEntry = YES;
    _telText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [_telText setValue:[UIColor colorWithHexString:@"#EEEEEE"] forKeyPath:@"_placeholderLabel.textColor"];
    [_telText setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    [_passText setValue:[UIColor colorWithHexString:@"#EEEEEE"] forKeyPath:@"_placeholderLabel.textColor"];
    [_passText setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
}
- (IBAction)onLoginBtn:(UIButton *)sender {
    
    if (!(_telText.text.length > 0)) {
        
        [self showMBPError:@"请输入账号"];
        return;
    }
    
    if (!(_passText.text.length > 0)) {
        
        [self showMBPError:@"请输入密码"];
        return;
    }
    
//    TabBarController *tab = [[TabBarController alloc] init];
//    [self presentViewController:tab animated:YES completion:nil];
    
    LoginStore *store = [[LoginStore alloc] init];
    [store loginWithUser:_telText.text andPass:_passText.text Success:^{

        TabBarController *tab = [[TabBarController alloc] init];
        [self presentViewController:tab animated:YES completion:nil];

    } Failure:^(NSError *error) {

        [self showMBPError:[HttpTool handleError:error]];
        
    }];
    
}
- (IBAction)onForgetBtn:(UIButton *)sender {
    
    ForgetOneController *VC = [[ForgetOneController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
