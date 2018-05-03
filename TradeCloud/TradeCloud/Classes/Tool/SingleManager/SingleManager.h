//
//  SingleManager.h
//  聚汇万家
//
//  Created by zhangming on 17/7/17.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SingleManager : NSObject

@property (strong , nonatomic) BMKPoiInfo *selectedLocalInfo;

+ (instancetype)sharedInstance;

@end
