//
//  MailListViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MailListViewController.h"
#import "SearchView.h"
#import "MailListCell.h"
#import "MailDetailViewController.h"

@interface MailListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) SearchView *searchView;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MailListViewController

- (SearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) andplaceHoder:@"搜索姓名"];
        
    }
    return _searchView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - (iPhoneX_Top) - (TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0.5;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MailListCell getHeight];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MailListCell *cell = [MailListCell tempWithTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MailDetailViewController *VC = [[MailDetailViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    la.text = @"    开发部";
    return la;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
