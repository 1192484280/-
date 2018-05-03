//
//  WorkClockController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/23.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "WorkClockController.h"
#import "WorkHeaderView.h"
#import "WorkClockCell.h"

//百度地图
//引入base相关所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

//引入计算工具所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>


@interface WorkClockController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,WorkHeaderViewDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) WorkHeaderView *headerView;

//百度地图
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property BOOL isGeoSearch;

@end

@implementation WorkClockController

static const float LATITUDE = 38.865416;
static const float LONGITUDE = 121.533896;

//地图定位
- (BMKLocationService *)locService {
    
    if (!_locService) {
        
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        
    }
    return _locService;
    
}

//检索对象
- (BMKGeoCodeSearch *)geocodesearch {
    
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
        
    }
    return _geocodesearch;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.locService startUserLocationService];//启动定位服务
    
}

- (WorkHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[WorkHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 380)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headerView;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top) - (TAB_BAR_HEIGHT)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = NormalBgColor;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WorkClockCell getHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkClockCell *cell = [WorkClockCell tempWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = NormalBgColor;
    return view;
}

#pragma mark - 定位失败
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"地图定位失败======%@",error);
}

#pragma mark - 位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(LATITUDE,LONGITUDE));
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    
    
    if (distance < 50) {
        
        self.headerView.title = @"您已进入打卡范围";
    }

    
    //关闭坐标更新
    [self.locService stopUserLocationService];
    
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0)) {
        
        //发送反编码请求
        //[self sendBMKReverseGeoCodeOptionRequest];
        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
        [self reverseGeoCodeWithLatitude:latitude withLongitude:longitude];
        
    }else{
        NSLog(@"位置为空");
        
    }
        
}




#pragma mark ----反向地理编码
- (void)reverseGeoCodeWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude {
    //发起反向地理编码检索
    CLLocationCoordinate2D coor;
    coor.latitude = [latitude doubleValue];
    coor.longitude = [longitude doubleValue];
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coor;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if (flag) {
        NSLog(@"反地理编码成功");
        //可注释
        
    } else {
        NSLog(@"反地理编码失败");
        //可注释
    }
    
}

//发送成功,百度将会返回东西给你
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        NSString *address1 = result.address;// result.addressDetail ///层次化地址信息
        NSLog(@"我的位置在 %@",address1); //保存位置信息到模型
        self.headerView.location = address1;
        
    }
}

- (void)photoBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWorkPhoto:)]) {
        
        [self.delegate onWorkPhoto:btn];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
