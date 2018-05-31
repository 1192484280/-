//
//  ShowImgController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ShowImgController.h"

@interface ShowImgController ()

@end

@implementation ShowImgController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    UIImageView *im = [[UIImageView alloc] initWithFrame:self.view.bounds];
    im.contentMode = UIViewContentModeScaleAspectFit;
    [im sd_setImageWithURL:[NSURL URLWithString:self.imgStr]];
    [self.view addSubview:im];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];
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
