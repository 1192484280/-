//
//  NameViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTf;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NormalBgColor;
    [self setNavBarWithTitle:self.name];
    _nameTf.placeholder = [NSString stringWithFormat:@"请输入%@",self.name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onSure)];
}

- (void)onSure{
    
    NSLog(@"确认");
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
