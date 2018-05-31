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
#import "WiFiManager.h"
#import "PunchClockList.h"
#import "PunchClockParameterModel.h"
#import "PunchStore.h"

//百度地图
//引入base相关所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

//引入计算工具所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

#import "CompanyPunchInfo.h"

@interface WorkClockController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,WorkHeaderViewDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *listArr;

@property (strong, nonatomic) WorkHeaderView *headerView;

//百度地图
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property BOOL isGeoSearch;

//添加在头部视图的tempScrollView
@property (nonatomic, strong) UIScrollView *tempScrollView;

@end

@implementation WorkClockController

//static const float LATITUDE = 38.865416;
//static const float LONGITUDE = 121.533896;

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
    
    //处理审批通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:PunchClickNotification object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (WorkHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[WorkHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, PunchHeaderHeight)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
        if ([[WiFiManager GetWifiName] isEqualToString:[PunchClockList sharedInstance].punchConfig.wifi_name]) {
            
            self.headerView.title = @"您已进入打卡范围";
        }
    }
    
    return _headerView;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top) - (TAB_BAR_HEIGHT)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.tableHeaderView = self.headerView;
        
        //添加头部和尾部视图
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, PunchHeaderHeight)];
        
        _tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, PunchHeaderHeight - 20)];
        _tempScrollView.layer.cornerRadius = 2;
        [headerView addSubview:_tempScrollView];
        [_tempScrollView addSubview:self.headerView];
        
        _tableView.tableHeaderView = headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = NormalBgColor;
        
        MJWeakSelf
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.page = 1;
            [weakSelf refresh];
        }];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [_tableView.mj_header beginRefreshing];
    }
    
    return _tableView;
}

- (void)refresh{
    
    PunchStore *store = [[PunchStore alloc] init];
    
    NSString *staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    NSString *date= [[StrTool getNowTime] substringToIndex:10];
    MJWeakSelf
    [store getPunchlistWithStaff_id:staff_id andDate:date andPage:[NSString stringWithFormat:@"%ld",self.page] Success:^(NSArray *arr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        
        if (weakSelf.page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:arr];
            
        }
        
        if (haveMore) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            
            
        }else{
            
            [weakSelf showMBPError:@"没有更多数据"];
            weakSelf.tableView.mj_footer.hidden = YES;
            
        }
        
        [weakSelf.tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)loadMoreData{
    
    self.page ++ ;
    
    [self refresh];
    
}

#pragma mark -- UIScrollViewDelegate 用于控制头部视图滑动的视差效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == _tableView){
        //重新赋值，就不会有用力拖拽时的回弹
        _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, 0);
        if (offset >= 0 && offset <= PunchHeaderHeight) {
            //因为tempScrollView是放在tableView上的，tableView向上速度为1，实际上tempScrollView的速度也是1，此处往反方向走1/2的速度，相当于tableView还是正向在走1/2，这样就形成了视觉差！
            _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, - offset / 2.0f);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WorkClockCell getHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkClockCell *cell = [WorkClockCell tempWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.model = self.listArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    view.backgroundColor = NormalBgColor;
    return view;
}

#pragma mark - 定位失败
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"地图定位失败======%@",error);
    self.headerView.location = @"定位失败";
}

#pragma mark - 位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    
    /*
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(LATITUDE,LONGITUDE));
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    
    
    if (distance < 50) {
        
        if ([[WiFiManager GetWifiName] isEqualToString:@"yjs"]) {
            
            self.headerView.title = @"您已进入打卡范围";
        }
        
    }
     */
    
    
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
        
        [PunchClockList sharedInstance].parameterModel.location = address1;
    }
}

- (void)photoBtn:(UIButton *)btn{
    
    if ([UserDefaultsTool getObjWithKey:@"lastPunchTime"].length > 0) {
    
        if(![StrTool compareCurrentTime:[UserDefaultsTool getObjWithKey:@"lastPunchTime"]]){
            
            return [self showMBPError:@"距上次打卡未超过5小时，请努力工作之后再来打卡！"];
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWorkPhoto:)]) {
        
        [self.delegate onWorkPhoto:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
