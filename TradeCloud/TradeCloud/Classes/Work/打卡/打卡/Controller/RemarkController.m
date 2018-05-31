//
//  RemarkController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "RemarkController.h"
#import <YYTextView.h>
#import <NSAttributedString+YYText.h>
#import "PunchClockList.h"
#import "PunchClockParameterModel.h"

@interface RemarkController ()

@end

@implementation RemarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"填写备注"];
    
    YYTextView *textView = [YYTextView new];
    textView.placeholderText = @"请输入备注";
    textView.placeholderFont = [UIFont systemFontOfSize:20];
    textView.textColor = FontColor;
    textView.font = [UIFont systemFontOfSize:20];
    //textView.attributedText = text;
    textView.size = CGSizeMake(kScreenWidth, kScreenHeight);
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    //textView.selectedRange = NSMakeRange(text.length, 0);
    [self.view addSubview:textView];
}

- (void)textViewDidChange:(YYTextView *)textView{
    
    [PunchClockList sharedInstance].parameterModel.note = textView.text;
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
