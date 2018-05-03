//
//  HXCTextFild.h
//  CodeDemo
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXCTextFild;

@protocol HXCTextFildDelegate <NSObject>
- (void)ynTextFieldDeleteBackward:(HXCTextFild *)textField;
@end

@interface HXCTextFild : UITextField

@property (weak, nonatomic) id<HXCTextFildDelegate> hxcdelegate;

@end
