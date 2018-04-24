//
//  CustomerAddController.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^myblock)(void);

@interface CustomerAddController : BaseViewController

@property (strong, nonatomic) myblock block;

- (void)returnMyBlock:(myblock)block;

@end
