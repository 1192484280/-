//
//  NSString+Extension.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/1.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  判断是否为邮箱格式
 */
- (BOOL)isEmail;

/**
 * md5加密
 */
- (NSString *) md5HexDigest;

/**
 * 富文本
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font;

/**
 * 富文本行高
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

@end
