//
//  MapHeaderView.h
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface MapHeaderView : UIView

@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) UIImageView *localIm;
@property (strong, nonatomic) UISearchBar *searchBar;

@end
