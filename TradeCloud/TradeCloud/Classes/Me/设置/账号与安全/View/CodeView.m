//
//  CodeView.m
//  CodeDemo
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CodeView.h"
#import "Masonry.h"
#import "HXCTextFild.h"

@implementation CodeFig

- (instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

@end


@interface CodeView()<UITextFieldDelegate,HXCTextFildDelegate>

@property (strong, nonatomic) CodeFig *codeFig;

@end

@implementation CodeView

- (instancetype)initWithFrame:(CGRect)frame andFig:(CodeFig *)codeFig{
    
    if (self = [super initWithFrame:frame]) {
        
        _codeFig = codeFig;
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
 
    NSMutableArray *arr = [NSMutableArray new];
    
    for (int i = 0; i <_codeFig.inputNum; i++) {
        
        HXCTextFild *tf = [[HXCTextFild alloc] init];
        tf.layer.borderColor = _codeFig.borColor.CGColor;
        tf.layer.borderWidth = 0.5;
        [self addSubview:tf];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.delegate = self;
        tf.hxcdelegate = self;
        tf.font = _codeFig.font;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [arr addObject:tf];
        tf.tag = 10+i;
        [tf addTarget:self action:@selector(textFildChange:) forControlEvents:UIControlEventEditingChanged];
        
        if (tf.tag == 10) {
            
            [tf becomeFirstResponder];
        }
    }
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:_codeFig.fixedSpacing leadSpacing:_codeFig.leadSpacing tailSpacing:_codeFig.leadSpacing];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.height.mas_equalTo(_codeFig.borHeight);
    }];

}

- (void)textFildChange:(UITextField *)tf{
    
    if (tf.tag == 9 + _codeFig.inputNum ) {
        
        [tf endEditing:YES];
        
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i< _codeFig.inputNum; i++) {
            
            UITextField *ttf = [self viewWithTag:10 + i];
            [str appendFormat:@"%@",ttf.text];
            
        }
        self.finishBlock(str);
    }
    
    if (tf.text.length > 0) {
        
        UITextField *tf1 = [self viewWithTag:tf.tag + 1];
        [tf1 becomeFirstResponder];
        
    }
}


- (void)ynTextFieldDeleteBackward:(HXCTextFild *)textField{
    
    if (!(textField.text.length > 0)) {
        
        UITextField *tf = [self viewWithTag:textField.tag - 1];
        [tf becomeFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.text = nil;
}
@end
