//
//  MapViewController.h
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

typedef void(^locationBlock)(BMKPoiInfo *location);

@interface MapViewController : BaseViewController

@property (strong, nonatomic) locationBlock locationBlock;

- (void)returnLocationBlock:(locationBlock)block;

@end
