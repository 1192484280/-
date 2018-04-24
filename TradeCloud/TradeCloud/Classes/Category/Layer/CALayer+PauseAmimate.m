//
//  CALayer+PauseAmimate.m
//  MyCampus
//
//  Created by zhangming on 2017/12/19.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "CALayer+PauseAmimate.h"

@implementation CALayer (PauseAmimate)

- (void)pauseAnimate
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resumeAnimate
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}


@end
