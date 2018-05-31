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

#import "PunchStore.h"
#import "WorkClockCell.h"

@interface CountViewController ()<FSCalendarDelegate,FSCalendarDataSource,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    void * _KVOContext;
}
@property (weak , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *headerView;

@property (assign, nonatomic) NSInteger page;

@property (copy, nonatomic) NSString *selectedDate;

@property (strong, nonatomic) NSMutableArray *listArr;

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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedDate = [[StrTool getNowTime] substringToIndex:10];
    
    UIView *iphoneXHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [self.view addSubview:iphoneXHeaderView];
    iphoneXHeaderView.backgroundColor = NAVBARCOLOR;
    if (iPhoneX) {
        
        iphoneXHeaderView.height = 34;
    }
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    // In loadView(Recommended) or viewDidLoad
    FSCalendar *calendar = [[FSCalendar alloc] init];
    calendar.dataSource = self;
    calendar.delegate = self;
    //日历语言为中文
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    //允许多选,可以选中多个日期
    calendar.allowsMultipleSelection = NO;
    //如果值为1,那么周日就在第一列,如果为2,周日就在最后一列
    calendar.firstWeekday = 1;
    //周一\二\三...或者头部的2017年11月的显示方式
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
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
    
    [self calendarConfig];
}

- (void)calendarConfig{
    
    //关闭字体自适应,设置字体大小\颜色
   self.calendar.appearance.adjustsFontSizeToFitContentSize = NO;
    self.calendar.appearance.subtitleFont = [UIFont systemFontOfSize:8];
    self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
    self.calendar.appearance.weekdayTextColor = [UIColor whiteColor];
    self.calendar.appearance.selectionColor = NAVBARCOLOR;
    //日历头部颜色
    self.calendar.calendarHeaderView.backgroundColor = NAVBARCOLOR;
    self.calendar.calendarWeekdayView.backgroundColor = NAVBARCOLOR;
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
    
    self.selectedDate = [self.dateFormatter stringFromDate:date];
    self.page = 1;
    [self refresh];
    
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

- (void)refresh{
    
    PunchStore *store = [[PunchStore alloc] init];
    
    NSString *staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    
    MJWeakSelf
    [store getPunchlistWithStaff_id:staff_id andDate:self.selectedDate andPage:[NSString stringWithFormat:@"%ld",self.page] Success:^(NSArray *arr, BOOL haveMore) {
        
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
