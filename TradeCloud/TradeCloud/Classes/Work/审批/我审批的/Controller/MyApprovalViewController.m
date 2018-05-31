//
//  MyApprovalViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/30.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalViewController.h"
#import "WaitHandleViewController.h"
#import "HadHandleViewController.h"
#import "SearchView.h"
#import "SMPagerTabView.h"
#import "ReimbursApprovalDetailController.h"

@interface MyApprovalViewController ()<SMPagerTabViewDelegate,WaitHandleViewControllerDelegate,HadHandleViewControllerDelegate,SearchViewDelegate>
@property (nonatomic, strong) NSMutableArray *vcArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SMPagerTabView *segmentView;
@property (nonatomic, strong) SearchView *searchView;
@property (assign, nonatomic) NSInteger pageNum;

@end

@implementation MyApprovalViewController

- (SearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) andplaceHoder:@"搜索人名，标题"];
        _searchView.delegate = self;
    }
    return _searchView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"我审批的"];
    
    [self.view addSubview:self.searchView];
    
    [self setUI];

}

- (void)back{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}

- (void)setUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _vcArr = [NSMutableArray array];
    
    WaitHandleViewController *vc1 = [[WaitHandleViewController alloc]initWithNibName:nil bundle:nil];
    vc1.delegate = self;
    vc1.title = @"待处理";
    
    HadHandleViewController *vc2 = [[HadHandleViewController alloc]initWithNibName:nil bundle:nil];
    vc2.delegate = self;
    vc2.title = @"已处理";
    
    [_vcArr addObject:vc1];
    [_vcArr addObject:vc2];
    
    
    self.segmentView.delegate = self;
    
    //可自定义背景色和tab button的文字颜色等
    //开始构建UI
    [_segmentView buildUI];
    
    //起始选择一个tab
    [_segmentView selectTabWithIndex:0 animate:NO];
    
    //显示红点，点击消失
    //[_segmentView showRedDotWithIndex:0];
    
}

#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_vcArr count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _vcArr[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
    self.pageNum = number;
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), kScreenWidth, kScreenHeight - (iPhoneX_Top))];
        self.segmentView.theight = 40;
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}

- (void)selectedCell:(BOOL)showBottomView{

    ReimbursApprovalDetailController *VC = [[ReimbursApprovalDetailController alloc] init];
    VC.showBottomView1 = showBottomView;
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)ClickSearchBtn:(NSString *)title{

    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:title,@"keywords", nil];
    
    NSString *noti = [NSString string];
    if (self.pageNum == 0) {
        
        noti = WaitHandleNotification;
        
    }else{
        
        noti = HadHandleNotification;
    }
    
    NSNotification *notification = [NSNotification notificationWithName:noti object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
