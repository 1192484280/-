//
//  MapHeaderView.m
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "MapHeaderView.h"

@interface MapHeaderView()



@end

@implementation MapHeaderView

- (UISearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        _searchBar.placeholder = @"查询位置";
        _searchBar.barTintColor = [UIColor orangeColor];

    }
    return _searchBar;
}

- (BMKMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc]initWithFrame:self.bounds];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.showsUserLocation = YES;//显示定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
        _mapView.zoomLevel = 17;//地图显示比例
        
    }
    return _mapView;
}

- (UIImageView *)localIm{
    
    if (!_localIm) {
        
        _localIm = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _localIm.image = [UIImage imageNamed:@"currentLocal"];
        _localIm.center = self.center;
        
    }
    return _localIm;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    [self addSubview:self.mapView];
    
    [self addSubview:self.localIm];
    
    [self addSubview:self.searchBar];
}


@end
