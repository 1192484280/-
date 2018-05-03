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
@end

@implementation AddReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"写汇报"];
    
    desTw.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cladar"] style:UIBarButtonItemStylePlain target:self action:@selector(onCaldar)];
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
