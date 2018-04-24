//
//  OrderCostAddController.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/12.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^myblock)(void);

@interface OrderCostAddController : BaseViewController

@property (strong, nonatomic) myblock block;

- (void)returnMyBlock:(myblock)block;

@end
