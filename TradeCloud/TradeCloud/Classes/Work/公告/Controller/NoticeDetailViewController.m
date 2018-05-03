//
//  NoticeDetailViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/25.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()
{
    
    IBOutlet UILabel *desLa;
    IBOutlet NSLayoutConstraint *viewHeight;
}
@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"公告详情"];
    
    NSString *a = @"新华社北京4月24日电　中共中央政治局4月23日下午就《共产党宣言》及其时代意义举行第五次集体学习。中共中央总书记习近平在主持学习时强调，学习马克思主义基本理论是共产党人的必修课。我们重温《共产党宣言》，就是要深刻感悟和把握马克思主义真理力量，坚定马克思主义信仰，追溯马克思主义政党保持先进性和纯洁性的理论源头，提高全党运用马克思主义基本原理解决当代中国实际问题的能力和水平,就是要深刻感悟和把握马克思主义真理力量，坚定马克思主义信仰，追溯马克思主义政党保持先进性和纯洁性的理论源头，提高全党运用马克思主义基本原理解决当代中国实际问题的能力和水平,坚定马克思主义信仰，追溯马克思主义政党保持先进性和纯洁性的理论源头，提高全党运用马克思主义基本原理解决当代中国实际问题的能力和水平,坚定马克思主义信仰，追溯马克思主义政党保持先进性和纯洁性的理论源头，提高全党运用马克思主义基本原理解决当代中国实际问题的能力和水平";
    
    UIFont *font = [UIFont systemFontOfSize:20];
    
    [self setLabelSpace:desLa withValue: a withFont:font];
    
    desLa.height = [self getSpaceLabelHeight:a withFont:font withWidth:kScreenWidth];
    
    viewHeight.constant = desLa.height + 200;

}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 10; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 20.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
}

//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 10.0;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
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
