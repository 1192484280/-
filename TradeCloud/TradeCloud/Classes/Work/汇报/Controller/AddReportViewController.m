//
//  AddReportViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/25.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "AddReportViewController.h"

@interface AddReportViewController ()<UITextViewDelegate>
{
    IBOutlet UILabel *desLa;
    IBOutlet UITextView *desTw;
}

@property (weak, nonatomic) UIButton *titleBtn;

@end

@implementation AddReportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavBar];
    
    desTw.delegate = self;
    
}

- (void)setNavBar{
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"写日报" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    btn.width = kScreenWidth * 0.6;
    btn.height = 30;
    [btn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    self.titleBtn = btn;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cladar"] style:UIBarButtonItemStylePlain target:self action:@selector(onCaldar)];
}

- (void)onBtn:(UIButton *)btn{
    
    MJWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"写日报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.titleBtn setTitle:@"写日报" forState:UIControlStateNormal];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"写汇报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.titleBtn setTitle:@"写汇报" forState:UIControlStateNormal];
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        desLa.alpha = 0;
    }else{
        
        desLa.alpha = 1;
    }
}

- (void)onCaldar{
    
    
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
