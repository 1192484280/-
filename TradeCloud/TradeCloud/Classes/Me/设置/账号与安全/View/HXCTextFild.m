//
//  HXCTextFild.m
//  CodeDemo
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HXCTextFild.h"

@implementation HXCTextFild

- (void)deleteBackward{
    
    [super deleteBackward];
    
    if ([self.hxcdelegate respondsToSelector:@selector(ynTextFieldDeleteBackward:)]) {
        
        [self.hxcdelegate ynTextFieldDeleteBackward:self];
        
    }
}

@end
