//
//  WorkViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "WorkViewController.h"

#import "ReportViewController.h"
#import "NoticeViewController.h"
#import "FileManagerViewController.h"
#import "PunchClockTabController.h"
#import "ApprovalTabController.h"
#import "CustomerController.h"
#import "OrderController.h"
#import "FactoryController.h"
#import "OrderCostController.h"

#define HeaderHeight (180)
@interface WorkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *headerView;

@property (copy, nonatomic) NSArray *titleArr;
@property (copy, nonatomic) NSArray *imgArr;
@property (copy, nonatomic) NSArray *vcArr;

@end

@implementation WorkViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        
        _titleArr = @[@[@"打卡"],@[@"审批",@"汇报"],@[@"公告",@"文件管理"],@[@"客户管理",@"订单管理"],@[@"工厂管理",@"订单成本管理"]];
    }
    return _titleArr;
}

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        
        _imgArr = @[@[@"icon_daka"],@[@"icon_shenhe",@"icon_huibao"],@[@"icon_gonggao",@"icon_wenjianjia"],@[@"icon_gonggao",@"icon_wenjianjia"],@[@"icon_gonggao",@"icon_wenjianjia"]];
    }
    
    return _imgArr;
}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
       
        _vcArr = @[@[[PunchClockTabController class]],@[[ApprovalTabController class],[ReportViewController class]],@[[NoticeViewController class],[FileManagerViewController class]],@[[CustomerController class],[OrderController class]],@[[FactoryController class],[OrderCostController class]]];
    }
    
    return _vcArr;
}

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"WorkHeaderView" owner:self options:nil]objectAtIndex:0];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, HeaderHeight);
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top) - (TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.sectionFooterHeight = 10;
        _tableView.sectionHeaderHeight = 10;
        
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.textLabel.textColor = FontColor;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
    CGSize itemSize = CGSizeMake(25, 25);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *VC = [[[self.vcArr[indexPath.section][indexPath.row] class] alloc] init];
    
    if (indexPath.section < 2) {
        
        if (indexPath.row<1) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
