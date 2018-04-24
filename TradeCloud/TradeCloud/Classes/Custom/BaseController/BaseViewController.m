//
//  BaseViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决设置导航栏不透明后界面下移问题
    //self.extendedLayoutIncludesOpaqueBars = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 带返回的navBar
- (void)setNavBarWithTitle:(NSString *)title
{
    self.title = title;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MBProgress展示错误信息
- (void)showMBPError:(NSString *)msg{
    
    [MBProgressHUD showError:msg toView:self.view];
}

#pragma mark - SVP展示错误信息
- (void)showSVPError:(NSString *)msg{
    
    [SVProgressHUD showErrorWithStatus:msg];
    [self performSelector:@selector(svpDismiss) withObject:nil afterDelay:2];
}

- (void)svpDismiss{
    
    [SVProgressHUD dismiss];
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
