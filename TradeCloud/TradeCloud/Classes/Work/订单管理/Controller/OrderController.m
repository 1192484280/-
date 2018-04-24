//
//  OrderController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderController.h"
#import "OrderSearchView.h"
#import "OrderCell.h"
#import "OrderAddController.h"
#import "SearchDetailView.h"
#import "OrderDetailController.h"
#import "OrderStore.h"
#import "CGXPickerView.h"
#import "CustomerStore.h"
#import "CustomerModel.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "OrderList.h"

#define AlertHeight 180
#define SearchDetailHeight 338

@interface OrderController ()<UITableViewDelegate,UITableViewDataSource, OrderSearchViewDelegate, SearchDetailViewDelegate>

@property (strong, nonatomic) OrderSearchView *searchView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) SearchDetailView *searchDetailView;

@property (strong, nonatomic) NSMutableArray *listArr;

@property (assign, nonatomic) NSInteger page;


@end

@implementation OrderController

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgView)]];
    }
    
    return _bgView;
}

- (void)didBgView{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.searchDetailView.y = kScreenHeight;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
    }];
    
}

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}

- (SearchDetailView *)searchDetailView{
    
    if (!_searchDetailView) {
        
        _searchDetailView = [[SearchDetailView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, SearchDetailHeight)];
        _searchDetailView.delegate = self;
    }
    
    return _searchDetailView;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (TAB_BAR_HEIGHT) ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.searchView;
        
        MJWeakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [OrderList sharedInstance].parameterModel.page = 1;
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
    
    return [OrderCell getHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell *cell = [OrderCell tempWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.listArr[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *model = self.listArr[indexPath.section];
    OrderDetailController *VC = [[OrderDetailController alloc] init];
    VC.order_id = model.order_id;
    VC.ifEdit = NO;
    
    if ([model.staff_id intValue] == [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
        
        VC.ifEdit = YES;
    }
    
    MJWeakSelf
    [VC returnMyBlock:^{
        
        weakSelf.page  = 1;
        [weakSelf refresh];
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
            
            OrderModel *model = self.listArr[indexPath.section];
            
            if ([model.staff_id intValue] != [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
                
                return [self showMBPError:@"您没有权限删除此订单!"];
            }
            
            OrderStore *store = [[OrderStore alloc] init];
            MJWeakSelf
            [store deleteOrderWithId:model.order_id Success:^{
                
                [weakSelf showMBPError:@"删除成功!"];
                [weakSelf.listArr removeObjectAtIndex:indexPath.section];
                [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                [weakSelf refresh];
            } Failure:^(NSError *error) {
                
                [self showMBPError:[HttpTool handleError:error]];
            }];
            
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)loadMoreData{
    
    [OrderList sharedInstance].parameterModel.page ++ ;
    [self refresh];
}

- (void)refresh{
    
    [SVProgressHUD show];
    
    OrderStore *store = [[OrderStore alloc] init];
    
    MJWeakSelf
    [store getListWithOrderParameterModel:[OrderList sharedInstance].parameterModel Success:^(NSArray *listArr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([OrderList sharedInstance].parameterModel.page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:listArr];
            if (haveMore) {
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                
            }else{
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                
            }
        }
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
    
}
- (OrderSearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[OrderSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 94)];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBar];
    
    [self.view addSubview:self.searchView];
    
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.searchDetailView belowSubview:self.navigationController.navigationBar];
    
    
    [OrderList sharedInstance].parameterModel = [[OrderParameterModel alloc] init];
    [OrderList sharedInstance].parameterModel.num = @"6";
    [OrderList sharedInstance].parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    
    [OrderList sharedInstance].parameterModel.page = 1;
    
    [self refresh];
}



- (void)setNavBar{
    
    [self setNavBarWithTitle:@"订单管理"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
}

- (void)onAdd{
    
    OrderAddController *VC = [[OrderAddController alloc] init];
    MJWeakSelf
    [VC returnMyBlock:^{
       
        weakSelf.page = 1;
        [weakSelf refresh];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 详细查询
- (void)onDetailSearch{
    
    [self.view endEditing:YES];
    
    [self.view insertSubview:self.bgView belowSubview:self.searchDetailView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.searchDetailView.y = kScreenHeight - SearchDetailHeight - (iPhoneX_Top) ;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }];
    
}

#pragma mark - 导出
- (void)onExport{
    
    [self.view endEditing:YES];
    NSLog(@"导出");
}

#pragma mark - 排序
- (void)onSortBtn:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    btn.selected = !btn.selected;
    
    MJWeakSelf
    if (btn.selected) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            btn.transform = CGAffineTransformMakeRotation(M_PI);
            
            weakSelf.listArr=(NSMutableArray *)[[weakSelf.listArr reverseObjectEnumerator] allObjects];
            
            [weakSelf.tableView reloadData];
        }];
        
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            
            weakSelf.listArr=(NSMutableArray *)[[weakSelf.listArr reverseObjectEnumerator] allObjects];
            
            [weakSelf.tableView reloadData];
        }];
        
    }
}

#pragma mark - 开始日期
- (void)onStartDateBtn:(UIButton *)btn{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    
    [CGXPickerView showDatePickerWithTitle:@"选择时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        
        [btn setTitle:selectValue forState:UIControlStateNormal];
        
        [OrderList sharedInstance].parameterModel.start_time = selectValue;
    }];
}

#pragma mark - 结束日期
- (void)onEndDateBtn:(UIButton *)btn{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    
    [CGXPickerView showDatePickerWithTitle:@"选择时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        
        [btn setTitle:selectValue forState:UIControlStateNormal];
        
        [OrderList sharedInstance].parameterModel.end_time = selectValue;
    }];
}

- (void)onTypeBtn:(UIButton *)btn{
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getGoodstypeListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [btn setTitle:model.value forState:UIControlStateNormal];
                
                [OrderList sharedInstance].parameterModel.goods_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)onStateBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"发布" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [btn setTitle:@"发布" forState:UIControlStateNormal];
        [OrderList sharedInstance].parameterModel.status = @"1";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"暂停" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        [OrderList sharedInstance].parameterModel.status = @"2";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [OrderList sharedInstance].parameterModel.status = @"3";
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

- (void)onFactoryBtn:(UIButton *)btn{
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getFactoryListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择工厂" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [btn setTitle:model.value forState:UIControlStateNormal];
                
                [OrderList sharedInstance].parameterModel.factory_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}
- (void)onCustomerBtn:(UIButton *)btn{
    
    CustomerStore *store = [[CustomerStore alloc] init];
    
    MJWeakSelf
    [store getCustomerListWithPage:@"1" andNum:@"99999" andCustomerName:nil success:^(NSArray *arr, BOOL haveMore) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (CustomerModel *model in arr) {
            
            [alert addAction:[UIAlertAction actionWithTitle:model.customer_name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [btn setTitle:model.customer_name forState:UIControlStateNormal];
                
                [OrderList sharedInstance].parameterModel.customer_id = model.customer_id;
            }]];
            
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 点击详细查询查询按钮
- (void)onSearchDetailSearchBtn{
    
    self.page = 1;
    
    [self didBgView];
    [self refresh];
}

- (void)ClickSearchBtn:(NSString *)title{
    
    [OrderList sharedInstance].parameterModel.page = 1;
    
    [OrderList sharedInstance].parameterModel.section_number = title;
    
    [self refresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
