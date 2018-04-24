//
//  CALayer+PauseAmimate.h
//  MyCampus
//
//  Created by zhangming on 2017/12/19.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAmimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
