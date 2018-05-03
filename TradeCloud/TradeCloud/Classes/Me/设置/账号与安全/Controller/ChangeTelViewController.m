//
//  ChangeTelViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ChangeTelViewController.h"
#import "CodeViewController.h"

@interface ChangeTelViewController ()

@end

@implementation ChangeTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =NormalBgColor;
    
    [self setNavBarWithTitle:@"更换手机号"];
}
- (IBAction)onNextStep:(UIButton *)sender {
    
    CodeViewController *codeVC = [[CodeViewController alloc] init];
    [self.navigationController pushViewController:codeVC animated:YES];
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
