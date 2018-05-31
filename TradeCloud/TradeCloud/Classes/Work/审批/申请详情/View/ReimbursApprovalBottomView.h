//
//  ReimbursApprovalBottomView.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/22.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReimbursApprovalBottomView : UIView

//同意/驳回回调
@property (nonatomic, copy) void(^passBlock)(void);
@property (nonatomic, copy) void(^refuseBlock)(void);

//催办/撤销回调
@property (nonatomic, copy) void(^urgeBlock)(void);
@property (nonatomic, copy) void(^RevokeBlock)(void);


/**
 * myHandle   判断是我处理的页面还是我提交的页面
 */
- (instancetype)initWithFrame:(CGRect)frame withPage:(BOOL)myHandle;
@end
