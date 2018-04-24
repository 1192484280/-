//
//  PunchClockViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "PunchClockViewController.h"
#import "SMPagerTabView.h"
#import "WorkClockController.h"
#import "OutClockController.h"

@interface PunchClockViewController ()<SMPagerTabViewDelegate>

@property (weak, nonatomic) UISegmentedControl *tap;
@property (nonatomic, strong) NSMutableArray *vcArr;
@property (nonatomic, strong) SMPagerTabView *segmentView;

@end

@implementation PunchClockViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setNavBar];
    
    [self setUI];
}

- (void)setUI{
    
    _vcArr = [NSMutableArray array];
    
    WorkClockController *workVC = [[WorkClockController alloc]initWithNibName:nil bundle:nil];
    
    OutClockController *outVC = [[OutClockController alloc]initWithNibName:nil bundle:nil];
    
    [_vcArr addObject:workVC];
    [_vcArr addObject:outVC];
    
    self.segmentView.delegate = self;
    
    [_segmentView buildUI];
    
    
}
- (void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
    
    UISegmentedControl *tap = [[UISegmentedControl alloc] initWithItems:@[@"上下班打卡",@"外出打卡"]];
    tap.frame = CGRectMake(100, 100, 150, 30);
    tap.tintColor = [UIColor whiteColor];
    [tap addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    tap.selectedSegmentIndex = 0;
    self.navigationItem.titleView = tap;
    self.tap = tap;
}

- (void)selectItem:(UISegmentedControl *)sender {
    
    [self.segmentView selectTabWithIndex:sender.selectedSegmentIndex animate:YES];
    
}

- (void)back{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_vcArr count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _vcArr[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    if (number == 1) {
        
        self.tap.selectedSegmentIndex = 1;
        
    }else if (number == 0){
        
        self.tap.selectedSegmentIndex = 0;
    }
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (TAB_BAR_HEIGHT) - (iPhoneX_Top))];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
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
