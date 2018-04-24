//
//  SetViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "SetViewController.h"
#import "AccountSecurityViewController.h"
#import "MessageNotificationViewController.h"
#import "CleanViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *titleArr;

@end

@implementation SetViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"账号与安全",@"新消息通知",@"一键清理"];
    }
    
    return _titleArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 10;
        _tableView.sectionFooterHeight = 10;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"设置"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArr[indexPath.section];
    cell.textLabel.textColor = FontColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            
            [self accountSafetyVC];
            break;
        case 1:
            
            [self newsVC];
            break;
        
        default:
            
            [self cleanVC];
            break;
    }
    
}

- (void)accountSafetyVC{
    
    AccountSecurityViewController *cleanVC = [[AccountSecurityViewController alloc] init];
    [self.navigationController pushViewController:cleanVC animated:YES];
}

- (void)newsVC{
    
    MessageNotificationViewController *cleanVC = [[MessageNotificationViewController alloc] init];
    [self.navigationController pushViewController:cleanVC animated:YES];
}

- (void)cleanVC{
    
    CleanViewController *cleanVC = [[CleanViewController alloc] init];
    [self.navigationController pushViewController:cleanVC animated:YES];
    
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
