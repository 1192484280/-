//
//  CleanViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CleanViewController.h"

@interface CleanViewController ()

@end

@implementation CleanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"一键清理"];
    
}
- (IBAction)onCleanBtn:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您将清理缓存" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

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
