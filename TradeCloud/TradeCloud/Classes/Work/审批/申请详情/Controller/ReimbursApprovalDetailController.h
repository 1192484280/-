//
//  ReimbursApprovalDetailController.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

@interface ReimbursApprovalDetailController : BaseViewController

//判断是否需要操作（只有我审批的，待处理的需要展示底部操作按钮 ：同意/驳回）
@property (assign, nonatomic) BOOL showBottomView1;

//判断是否需要操作（只有我提交的的，审批中的需要展示底部操作按钮 ：催办/撤销）
@property (assign, nonatomic) BOOL showBottomView2;


@end
