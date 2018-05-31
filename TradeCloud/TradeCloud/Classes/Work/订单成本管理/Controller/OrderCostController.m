//
//  OrderCostController.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostController.h"
#import "OrderCostSearchView.h"
#import "OrderCostCell.h"
#import "OrderCostDetailSearchView.h"
#import "OrderCostDetailController.h"
#import "OrderCostStore.h"
#import "OrderCostModel.h"
#import "OrderCostAddController.h"
#import "CommonStore.h"
#import "CommonModel.h"
#import "OrderCostList.h"
#import "OrderCostParameterModel.h"
#import "StaffModel.h"
#import "BRPickerView.h"

#define AlertHeight 180
#define SearchDetailHeight 260

@interface OrderCostController ()<UITableViewDelegate,UITableViewDataSource,OrderCostSearchViewDelegate,OrderCostDetailSearchViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) OrderCostSearchView *searchView;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) OrderCostDetailSearchView *detailSearchView;

@property (strong, nonatomic) NSMutableArray *listArr;

@property (assign, nonatomic) NSInteger totalMoney;

@end

@implementation OrderCostController


- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (OrderCostDetailSearchView *)detailSearchView{
    
    if (!_detailSearchView) {
        
        _detailSearchView = [[OrderCostDetailSearchView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, SearchDetailHeight)];
        _detailSearchView.delegate = self;
    }
    
    return _detailSearchView;
}

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
        
        self.detailSearchView.y = kScreenHeight;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
    }];
    
}


- (OrderCostSearchView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[OrderCostSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 94)];
        _searchView.delegate = self;
    }
    
    return _searchView;
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
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        MJWeakSelf
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [OrderCostList sharedInstance].parameterModel.page = 1;
            [weakSelf refresh];
        }];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
    return _tableView;
}

- (void)loadMoreData{
    
    [OrderCostList sharedInstance].parameterModel.page ++ ;
    
    [self refresh];
}

- (void)refresh{
    
   
    
    OrderCostStore *store = [[OrderCostStore alloc] init];
    MJWeakSelf
    [store getListWithParameterModel:[OrderCostList sharedInstance].parameterModel Success:^(NSArray *listArr, NSString *total,BOOL haveMore) {
        

        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([OrderCostList sharedInstance].parameterModel.page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
            _totalMoney = [total intValue];
            
        }else{
            
            [weakSelf.listArr addObjectsFromArray:listArr];
            _totalMoney += [total intValue];
            
            if (haveMore) {
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        
        self.searchView.total.text = [NSString stringWithFormat:@"支出金额: ¥%ld",(long)_totalMoney];
        [weakSelf.tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [OrderCostCell getHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCostCell *cell = [OrderCostCell tempWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.listArr[indexPath.section];
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
            
            OrderCostModel *model = self.listArr[indexPath.section];
            OrderCostStore *store = [[OrderCostStore alloc] init];
            
            if ([model.staff_id intValue] != [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
                
                return [self showMBPError:@"您没有权限删除此订单!"];
            }
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您将删除此订单成本" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                MJWeakSelf
                [store deleteWithId:model.cost_id Success:^{
                    
                    [weakSelf showMBPError:@"删除成功!"];
                    [weakSelf.listArr removeObjectAtIndex:indexPath.section];
                    [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                    [weakSelf refresh];
                    
                } Failure:^(NSError *error) {
                    
                    [weakSelf showMBPError:[HttpTool handleError:error]];
                }];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];

            
            
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCostModel *model = self.listArr[indexPath.section];
    
    MJWeakSelf
    OrderCostDetailController *VC = [[OrderCostDetailController alloc] init];
    VC.cost_id = model.cost_id;
    
    VC.ifEdit = NO;
    
    if ([model.staff_id intValue] == [[UserDefaultsTool getObjWithKey:@"staff_id"] intValue]) {
        
        VC.ifEdit = YES;
    }
    
    [VC returnMyBlock:^{
        
        [OrderCostList sharedInstance].parameterModel.page = 1;
        [weakSelf refresh];
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setNavBar];
    
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.detailSearchView belowSubview:self.navigationController.navigationBar];
    
    [OrderCostList sharedInstance].parameterModel = [[OrderCostParameterModel alloc] init];
    [OrderCostList sharedInstance].parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    [OrderCostList sharedInstance].parameterModel.num = @"6";
    [OrderCostList sharedInstance].parameterModel.page = 1;
    
    [self refresh];
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"订单成本管理"];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
    
    
}

- (void)onAdd{
    
    OrderCostAddController *VC = [[OrderCostAddController alloc] init];
    MJWeakSelf
    [VC returnMyBlock:^{
       
        [OrderCostList sharedInstance].parameterModel.page = 1;
        [weakSelf refresh];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)onCancelBtn{
    
    [self didBgView];
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

#pragma mark - 详细查询
- (void)onDetailSearch{
    
    [self.view endEditing:YES];
    
    [self.view insertSubview:self.bgView belowSubview:self.detailSearchView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.detailSearchView.y = kScreenHeight - SearchDetailHeight - (iPhoneX_Top);
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }];
}

#pragma mark - 导出
- (void)onExport{
    
    [self.view endEditing:YES];
    NSLog(@"导出");
}

#pragma mark - 查询
- (void)onSearchDetailSearchBtn{
    
    [self.view endEditing:YES];
    [OrderCostList sharedInstance].parameterModel.page = 1;
    
    [self didBgView];
    
    [self refresh];
    
}

#pragma mark - 开始日期
- (void)onStartDateBtn:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    NSDate *minDate = [NSDate setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        
        [btn setTitle:selectValue forState:UIControlStateNormal];
        
        [OrderCostList sharedInstance].parameterModel.start_time = selectValue;
        
    } cancelBlock:^{
        
        
    }];
    
}

#pragma mark - 结束日期
- (void)onEndDateBtn:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    NSDate *minDate = [NSDate setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        
        [btn setTitle:selectValue forState:UIControlStateNormal];
        
        [OrderCostList sharedInstance].parameterModel.end_time = selectValue;
        
    } cancelBlock:^{
        
        
    }];
    
}

#pragma mark - 支出类型
- (void)onPayTypeBtn:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getPayTypeListArrSuccess:^(NSArray *listArr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择支出类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (int i = 0; i< listArr.count; i++) {
            
            CommonModel *model = listArr[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [btn setTitle:model.value forState:UIControlStateNormal];
                
                [OrderCostList sharedInstance].parameterModel.pay_type_id = model.uid;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    } Failure:^(NSError *error) {
        
    }];
}

#pragma mark - 选择支出人
- (void)onPersonBtn:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    CommonStore *store = [[CommonStore alloc] init];
    
    MJWeakSelf
    [store getStaffListSuccess:^(NSArray *arr) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择支出人" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        for (StaffModel *model in arr) {
            
            [alert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [btn setTitle:model.name forState:UIControlStateNormal];
                
                [OrderCostList sharedInstance].parameterModel.staff_id = model.staff_id;
            }]];
        }
        
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];

    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}

- (void)clickSearchBtn:(NSString *)title{
    
    [OrderCostList sharedInstance].parameterModel = [[OrderCostParameterModel alloc] init];
    [OrderCostList sharedInstance].parameterModel.staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    [OrderCostList sharedInstance].parameterModel.num = @"6";
    [OrderCostList sharedInstance].parameterModel.page = 1;
    [OrderCostList sharedInstance].parameterModel.section_number = title;
    [self refresh];
}

#pragma mark - DZNEmptyDataSetDelegate
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"img_null"];
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
