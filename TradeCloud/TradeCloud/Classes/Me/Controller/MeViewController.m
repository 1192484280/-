//
//  MeViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MeViewController.h"
#import "MineHeaderView.h"
#import "SetViewController.h"
#import "MyInfoViewController.h"


#define SDHeight   (250)

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,MineHeaderViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MineHeaderView *headerView;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (MineHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SDHeight)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"设置";
    cell.textLabel.textColor = FontColor;
    cell.imageView.image = [UIImage imageNamed:@"icon_set"];
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
    SetViewController *setVC = [[SetViewController alloc] init];
    [setVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)lookAtMe{
    
    MyInfoViewController *VC = [[MyInfoViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
