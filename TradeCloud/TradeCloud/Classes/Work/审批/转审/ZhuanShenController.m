//
//  ZhuanShenController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/11.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ZhuanShenController.h"

@interface ZhuanShenController ()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *plaseLa;
@property (strong, nonatomic) IBOutlet UITextView *desTw;

@end

@implementation ZhuanShenController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = NormalBgColor;
    
    [self setNavBar];
    
    self.desTw.delegate = self;
    
    
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        self.plaseLa.alpha = 0;
        
    }else{
        
        self.plaseLa.alpha = 1;
    }
}
- (void)setNavBar{
    
    [self setNavBarWithTitle:@"转审"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(onPostBtn)];
}

- (void)onPostBtn{
    
    [self showMBPError:@"提交"];
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
