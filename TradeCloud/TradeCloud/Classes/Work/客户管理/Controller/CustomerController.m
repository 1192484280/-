//
//  CustomerController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/4.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "CustomerController.h"
#import "SearchView.h"
#import "CustomerCell.h"
#import "CustomerDetailController.h"
#import "CustomerAddController.h"
#import "CustomerStore.h"

#define AlertHeight 180

@interface CustomerController ()<UITableViewDelegate,UITableViewDataSource,SearchViewDelegate>

@property (strong, nonatomic) SearchView *searchView;

@property (strong, nonatomic) UITableView *tableView;

@property (assign, nonatomic) NSInteger page;
@property (copy, nonatomic) NSString *num;
@property (copy, nonatomic) NSString *customer_name;

@property (strong, nonatomic) NSMutableArray *listArr;



@end

@implementation CustomerController

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}


- (SearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) andplaceHoder:@"搜索客户名称"];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.page = 1;
    self.num = @"6";
    self.customer_name = nil;
    
    [self setNavBar];
    
    [self.view addSubview:self.tableView];
    
    [self refresh];
    
}



- (void)setNavBar{
    
    [self setNavBarWithTitle:@"客户管理"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
}

- (void)onAdd{
    
    CustomerAddController *VC = [[CustomerAddController alloc] init];
    MJWeakSelf
    [VC returnMyBlock:^{
       
        weakSelf.page = 1;
        [weakSelf refresh];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.searchView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        
        MJWeakSelf 
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            weakSelf.page = 1;
            [weakSelf refresh];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
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
    
    return [CustomerCell getHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerCell *cell = [CustomerCell tempWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.listArr[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerModel *model = self.listArr[indexPath.section];
    CustomerDetailController *VC = [[CustomerDetailController alloc] init];
    VC.customer_id = model.customer_id;
    
    VC.ifEdit = NO;
    
    if ([model.staff_id intValue] == [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
        
        VC.ifEdit = YES;
    }
    [VC returnMyBlock:^{
        
        [self refresh];
    }];
    [self.navigationController pushViewController:VC animated:YES];
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
            
            CustomerModel *model = self.listArr[indexPath.section];
            CustomerStore *store = [[CustomerStore alloc] init];
            
            if ([model.staff_id intValue] != [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
                
                return [self showMBPError:@"您没有权限删除此订单!"];
            }
            MJWeakSelf
            [store deleteCustomerWithId:model.customer_id success:^{
                
                [weakSelf showMBPError:@"删除成功！"];
                
                [weakSelf.listArr removeObjectAtIndex:indexPath.section];
                [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                [weakSelf refresh];
                
            } failure:^(NSError *error) {
                
                [self showMBPError:[HttpTool handleError:error]];
            }];
            
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)refresh{
    
    [SVProgressHUD show];
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    [store getCustomerListWithPage:[NSString stringWithFormat:@"%ld",(long)self.page] andNum:self.num andCustomerName:self.customer_name success:^(NSArray *arr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:arr];
            if (haveMore) {
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                
            }else{
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                
            }
        }
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

- (void)loadMoreData{
    
    self.page ++ ;
    [self refresh];
}


- (void)ClickSearchBtn:(NSString *)title{
    
    self.page = 1;
    self.customer_name = title;
    [self refresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
