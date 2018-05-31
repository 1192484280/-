//
//  SubmitApprovalingController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "SubmitApprovalingController.h"
#import "MyApprovalCell.h"
#import "MyApprovalModel.h"
#import "MyApprovalViewModel.h"
#import "SubmitStore.h"
#import "MyApprovalList.h"

@interface SubmitApprovalingController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *listArr;

@property (strong, nonatomic) NSMutableArray *frameList;

@property (copy, nonatomic) NSString *keywords;

@end

@implementation SubmitApprovalingController

- (NSMutableArray *)listArr{
    
    if(!_listArr){
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 90 - (iPhoneX_Top) - (TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyApprovalViewModel *model = self.frameList[indexPath.section];
    
    return model.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyApprovalCell *cell = [MyApprovalCell tempWithTableView:tableView];

    cell.frameModel = self.frameList[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MyApprovalList sharedInstance].selectedModel = self.listArr[indexPath.section];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedCell:)]) {
        
        [self.delegate selectedCell:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    [self.view addSubview:self.tableView];
    
    //实现搜索通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchBtn:) name:SubmitApprovingtNotification object:nil];
}

#pragma mark - 实现搜索通知方法
- (void)onSearchBtn:(NSNotification *)notifiCation{
    
    self.keywords = notifiCation.userInfo[@"keywords"];
    [self refresh];
    
}


- (void)refresh{
 
    SubmitStore *store = [[SubmitStore alloc] init];
    
    NSString *staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    NSString *status = @"2";
    
    MJWeakSelf
    [store getSubListWithStaff_id:staff_id andStatus:status andPage:self.page andKeywords:self.keywords Success:^(NSArray *listArr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        
        if (weakSelf.page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:listArr];
            
        }
        
        if (haveMore) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            
            
        }else{
            
            [weakSelf showMBPError:@"没有更多数据"];
            weakSelf.tableView.mj_footer.hidden = YES;
            
        }
        
        self.frameList = [NSMutableArray array];
        for (MyApprovalModel *model in self.listArr) {
            
            MyApprovalViewModel *viewModel = [[MyApprovalViewModel alloc] init];
            viewModel.model = model;
            [self.frameList addObject:viewModel];
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

#pragma mark - DZNEmptyDataSetDelegate
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"img_null"];
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.page = 1;
    self.keywords = @"";
    [self refresh];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
