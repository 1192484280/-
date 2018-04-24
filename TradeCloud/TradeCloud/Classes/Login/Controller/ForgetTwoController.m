//
//  ForgetTwoController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ForgetTwoController.h"
#import "ForgetThreeController.h"

@interface ForgetTwoController ()

@end

@implementation ForgetTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"忘记密码"];
}
- (IBAction)onNextBtn:(UIButton *)sender {
    
    ForgetThreeController *VC = [[ForgetThreeController alloc] init];
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
