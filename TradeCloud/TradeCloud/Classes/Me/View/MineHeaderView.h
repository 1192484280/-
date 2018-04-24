//
//  MineHeaderView.h
//  JuHuiLife
//
//  Created by zhangming on 2018/2/5.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeaderViewDelegate<NSObject>

- (void)lookAtMe;

@end

@interface MineHeaderView : UIView


@property (weak, nonatomic) id<MineHeaderViewDelegate> delegate;


@end
