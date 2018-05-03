//
//  CodeViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CodeViewController.h"
#import "CodeView.h"

@interface CodeViewController ()
{
    
    IBOutlet UIView *codeView;
}
@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NormalBgColor;
    
    [self setNavBarWithTitle:@"更换手机号"];
    
    [self jhSetupViews];
}

- (void)jhSetupViews
{
    CodeFig *fig = [[CodeFig alloc] init];
    fig.inputNum = 4;
    fig.fixedSpacing = 15;
    fig.tailSpacing = 50;
    fig.leadSpacing = 50;
    fig.borColor = [UIColor grayColor];
    fig.borHeight = 65;
    fig.font = [UIFont boldSystemFontOfSize:25];
    CodeView *view = [[CodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, codeView.height) andFig:fig];
    view.finishBlock = ^(NSString *code) {
        
        [self showMBPError:code];
    };
    [codeView addSubview:view];
    
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
