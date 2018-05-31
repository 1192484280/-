//
//  ReportDetailController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ReportDetailController.h"
#import "ReportDetailHeaderView.h"

@interface ReportDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ReportDetailHeaderView *headerView;

@end

@implementation ReportDetailController

- (ReportDetailHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[ReportDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"111";
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"汇报详情"];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
