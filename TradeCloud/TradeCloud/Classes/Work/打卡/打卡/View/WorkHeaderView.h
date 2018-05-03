//
//  WorkHeaderView.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkHeaderViewDelegate<NSObject>

- (void)photoBtn:(UIButton *)btn;

@end

@interface WorkHeaderView : UIView

@property (weak, nonatomic) id<WorkHeaderViewDelegate>delegate;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *location;

@end
