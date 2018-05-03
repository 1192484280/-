//
//  AllSearchViewController.h
//  JuHuiLife
//
//  Created by zhangming on 2018/2/1.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^onLocalBlock)(NSString *flag);

@interface AllSearchViewController : BaseViewController

@property (copy, nonatomic) NSArray *listArr;

@property (nonatomic,strong) onLocalBlock onLocalBlock;

- (void)returnOnLocalBlack:(onLocalBlock)block;

@end
