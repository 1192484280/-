//
//  FactoryController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "FactoryController.h"
#import "SearchView.h"
#import "FactoryCell.h"

#define AlertHeight 180

@interface FactoryController ()<UITableViewDelegate,UITableViewDataSource,FactoryCellDelegate>

@property (strong, nonatomic) SearchView *searchView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listArr;

@end

@implementation FactoryController

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
        [_listArr addObject:@"1"];
        [_listArr addObject:@"2"];
        [_listArr addObject:@"3"];
        [_listArr addObject:@"4"];
    }
    
    return _listArr;
}


- (SearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) andplaceHoder:@"搜索客户名称"];
    }
    return _searchView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top)) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        _tableView.tableHeaderView = self.searchView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [FactoryCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FactoryCell *cell = [FactoryCell tempWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.section = indexPath.section;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row < self.listArr.count) {
            
            [self.listArr removeObjectAtIndex:indexPath.row];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self.view addSubview:self.tableView];
    
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"工厂管理"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
    
    
}

#pragma mark - 添加客户
- (void)onAdd{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
