//
//  HeaderViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HeaderViewController.h"
#import "HomeToolBar.h"
#import "HeaderCell.h"

#define HomeToolBarH    (120)
#define SDHeight (kScreenHeight/3)
#define HomeHeight HomeToolBarH + SDHeight
#define SectionHeight (75)

@interface HeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *sdArray;

@property (nonatomic, strong) HomeToolBar *toolBar;

@property (nonatomic, assign) CGFloat laseContentOffsetY;

@property (strong, nonatomic) UIView *sdView;//名言view

@property (strong, nonatomic) UIView *sectionView;

@end

@implementation HeaderViewController

- (UIView *)sdView{
    
    if (!_sdView) {
        
        _sdView = [[[NSBundle mainBundle] loadNibNamed:@"SDView" owner:self options:nil] objectAtIndex:0];
        _sdView.frame = CGRectMake(0, -(SDHeight + HomeToolBarH), kScreenWidth, SDHeight);
    }
    return _sdView;
}


- (UIView *)sectionView{

    if (!_sectionView) {
        
        _sectionView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderSectionView" owner:self options:nil] objectAtIndex:0];
        _sectionView.frame = CGRectMake(0, 0, kScreenWidth, SectionHeight);
    }
    
    return _sectionView;
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        
        _tableView.contentInset = UIEdgeInsetsMake(HomeHeight, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(HomeHeight, 0, 0, 0);

        _tableView.sectionFooterHeight = 0.5;
        
        
        MJWeakSelf
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_tableView.mj_header endRefreshing];
            });
            
            [weakSelf.tableView reloadData];
        }];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        
        [_tableView addSubview:self.sdView];
        [_tableView addSubview:self.toolBar];
    }
    
    return _tableView;
}

- (HomeToolBar *)toolBar{
    
    if (!_toolBar) {
        
        HomeToolBarItem *item1 = [HomeToolBarItem itemWithImage:[UIImage imageNamed:@"icon_qiandao"] title:@"一键签到"];
        HomeToolBarItem *item2 = [HomeToolBarItem itemWithImage:[UIImage imageNamed:@"icon_report"] title:@"写汇报"];
        HomeToolBarItem *item3 = [HomeToolBarItem itemWithImage:[UIImage imageNamed:@"icon_shenpi"] title:@"发起审批"];
        HomeToolBarItem *item4 = [HomeToolBarItem itemWithImage:[UIImage imageNamed:@"icon_search"] title:@"搜索"];
        _toolBar = [[HomeToolBar alloc] initWithToolBarItems:@[item1, item2, item3, item4]];
        _toolBar.frame = CGRectMake(0,-HomeToolBarH, kScreenWidth, HomeToolBarH);
    }
    
    return _toolBar;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [HeaderCell getHeightWithIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeaderCell *cell = [HeaderCell tempWithTableView:tableView andListArr:nil andIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"HeaderSectionView" owner:self options:nil] objectAtIndex:0];
    view.frame = CGRectMake(0, 0, kScreenWidth, SectionHeight);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [btn setTitle:@"添加+" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:NAVBARCOLOR forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _laseContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat tableViewOffsetY = scrollView.contentOffset.y;

    if (tableViewOffsetY < -(SDHeight + HomeToolBarH)) {
        _toolBar.frame = CGRectMake(0, tableViewOffsetY + SDHeight, kScreenWidth, HomeToolBarH);
        _sdView.frame = CGRectMake(0, tableViewOffsetY , kScreenWidth, SDHeight);
    } else {
        _toolBar.frame = CGRectMake(0, -HomeToolBarH, kScreenWidth, HomeToolBarH);
        _sdView.frame = CGRectMake(0, -(SDHeight + HomeToolBarH), kScreenWidth, SDHeight);
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat tableViewOffsetY = scrollView.contentOffset.y;

    if (tableViewOffsetY < -(HomeHeight) || tableViewOffsetY > -SDHeight) {
        return;
    }

    if (tableViewOffsetY > _laseContentOffsetY) {
        // 向上滑
        if (tableViewOffsetY > -(HomeHeight) + 30) {
            [self.tableView setContentOffset:CGPointMake(0, -SDHeight) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -(HomeHeight)) animated:YES];
        }
    } else {
        // 向下滑
        if (tableViewOffsetY < -SDHeight - 30) {
            [self.tableView setContentOffset:CGPointMake(0, -(HomeHeight)) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -SDHeight) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat tableViewOffsetY = scrollView.contentOffset.y;

    if (tableViewOffsetY < -(HomeHeight) || tableViewOffsetY > -SDHeight) {
        return;
    }

    if (tableViewOffsetY > _laseContentOffsetY) {
        // 向上滑
        if (tableViewOffsetY > -(HomeHeight) + 20) {
            [self.tableView setContentOffset:CGPointMake(0, -SDHeight) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -(HomeHeight)) animated:YES];
        }
    } else {
        // 向下滑
        if (tableViewOffsetY < -SDHeight - 20) {
            [self.tableView setContentOffset:CGPointMake(0, -(HomeHeight)) animated:YES];
        } else {
            [self.tableView setContentOffset:CGPointMake(0, -SDHeight) animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
