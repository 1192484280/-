//
//  ManySelectView.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManySelectView : UIView

@property (nonatomic, copy)  void(^finishBlock)(NSArray *selectedArr);

- (instancetype)initWithFrame:(CGRect)frame andArr:(NSArray *)listArr;

@end
