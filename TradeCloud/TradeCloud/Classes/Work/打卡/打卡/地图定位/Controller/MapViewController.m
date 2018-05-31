//
//  MapViewController.m
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "MapViewController.h"
#import "MapHeaderView.h"
#import "MapCell.h"
#import "AllSearchViewController.h"

#define MAPHEIGHT kScreenWidth / 16 * 12

@interface MapViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate,BMKPoiSearchDelegate>
{
    CGFloat locaLatitude; //经度
    CGFloat locaLongitude; //纬度
    BMKGeoCodeSearch *_searcher;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) MapHeaderView *headerView;

@property (strong, nonatomic) BMKLocationService *locationManager;

@property (strong , nonatomic) BMKPoiSearch *poiSearch;

@property (strong, nonatomic) NSMutableArray *pointArr;

//保存当前位置的容器
@property (strong, nonatomic) BMKPoiInfo *locationInfo;

@property (strong, nonatomic) NSIndexPath *selectPath; //存放被点击的哪一行的标志

@end

@implementation MapViewController

-(void)viewWillDisappear:(BOOL)animated
{
    _locationManager.delegate = nil;
    _poiSearch.delegate = nil;
    _searcher.delegate = nil;
    
}




- (MapHeaderView *)headerView{
    
    if (!_headerView) {
        
        
        _headerView = [[MapHeaderView alloc] initWithFrame:CGRectMake(0,-1, kScreenWidth, MAPHEIGHT)];
        _headerView.searchBar.delegate = self;
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, kScreenHeight - (iPhoneX_Top) - (self.headerView.height))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    
    self.locationInfo.address = @"定位中...";
    
    [self addLocation];
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"选择当前位置"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onSureBtn)];
    
}

- (void)onSureBtn{
    
    if(![self.locationInfo.address isEqualToString:@"定位中..."]){
        
        
        if (self.locationBlock != nil) {
            
            self.locationBlock(self.locationInfo);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnLocationBlock:(locationBlock)block{
    
    self.locationBlock = block;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MapCell getHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.pointArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MapCell *cell = [MapCell tempWithTableView:tableView];
    cell.model = self.pointArr[indexPath.row];
    
    if (_selectPath == indexPath){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.locationInfo = self.pointArr[indexPath.row];
    
    [self.headerView.mapView setCenterCoordinate:self.locationInfo.pt animated:YES];
    
    int newRow = (int)[indexPath row];
    int oldRow = (int)(_selectPath != nil) ? (int)[_selectPath row]:-1;
    if (newRow != oldRow){
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectPath];
        
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _selectPath = [indexPath copy];
    }
}
- (void)addLocation{
    
    //初始化实例
    _locationManager = [[BMKLocationService alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager startUserLocationService];
    
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    [_locationManager stopUserLocationService];
    
    [self.headerView.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    //[self.headerView.mapView updateLocationData:userLocation];
    
    locaLatitude = userLocation.location.coordinate.latitude;//纬度
    locaLongitude = userLocation.location.coordinate.longitude;//经度
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//接收反向地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        BMKPoiInfo *info= [[BMKPoiInfo alloc]init];
        info.name = @"定位中...";
        info.address = result.address;
        info.pt = result.location;
        
        self.locationInfo = info;
        self.locationInfo.name = result.address;
        
        self.pointArr = [[NSMutableArray alloc] initWithObjects:info, nil];
        [self.pointArr addObjectsFromArray:result.poiList];
        
        [_tableView reloadData];
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    
}

#pragma mark - 点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    
    //附近云检索，其他检索方式见详细api
    BMKNearbySearchOption *nearBySearchOption = [[BMKNearbySearchOption alloc]init];
    nearBySearchOption.pageIndex = 0; //第几页
    nearBySearchOption.pageCapacity = 10;  //最多几页
    nearBySearchOption.keyword = searchBar.text;   //检索关键字
    nearBySearchOption.location = (CLLocationCoordinate2D){
        locaLatitude,locaLongitude}; // poi检索点
    nearBySearchOption.radius = 1000; //检索范围 m
    BOOL flag = [_poiSearch poiSearchNearBy:nearBySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark --BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        [self.view endEditing:YES];
        
        
        //跳转
        AllSearchViewController *VC = [[AllSearchViewController alloc] init];
        VC.listArr = poiResult.poiInfoList;
        [VC returnOnLocalBlack:^(NSString *flag) {
            
            self.headerView.mapView.centerCoordinate = [SingleManager sharedInstance].selectedLocalInfo.pt;
            
            //发起反向地理编码检索
            BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                                    BMKReverseGeoCodeOption alloc]init];
            reverseGeoCodeSearchOption.reverseGeoPoint = [SingleManager sharedInstance].selectedLocalInfo.pt;
            BOOL flagg = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
            
            if(flagg)
            {
                //NSLog(@"反geo检索发送成功");
            }
            else
            {
                //NSLog(@"反geo检索发送失败");
            }
            
        }];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
