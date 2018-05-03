//
//  CountViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/30.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CountViewController.h"
#import <FSCalendar.h>
#import "CountHeaderView.h"
#import "CountCell.h"


@interface CountViewController ()<FSCalendarDelegate,FSCalendarDataSource,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    void * _KVOContext;
}
@property (weak , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *headerView;

@end

@implementation CountViewController

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[CountHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 280)];
        
    }
    
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = NormalBgColor;
        _tableView.tableHeaderView = self.headerView;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.calendar.mas_bottom).offset(0.5);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(-(TAB_BAR_HEIGHT));
        }];

    }
    
    return _tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CountCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CountCell *cell = [CountCell tempWithTableView:tableView];
    
    return cell;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *iphoneXHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [self.view addSubview:iphoneXHeaderView];
    iphoneXHeaderView.backgroundColor = [UIColor orangeColor];
    if (iPhoneX) {
        
        iphoneXHeaderView.height = 34;
    }
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    // In loadView(Recommended) or viewDidLoad
    FSCalendar *calendar = [[FSCalendar alloc] init];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(400);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(iphoneXHeaderView.mas_bottom);
        
        
    }];
    self.calendar = calendar;
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    
    self.calendar.scope = FSCalendarScopeWeek;
    
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
    
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iphoneXHeaderView.frame)+20, 45, 30)];
    [btn setImage:[UIImage imageNamed:@"icon_back_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onBack{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}
#pragma mark - <FSCalendarDelegate>
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    [calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(bounds.size.height));
        // Do other updates
    }];
    [self.view layoutIfNeeded];
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
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
