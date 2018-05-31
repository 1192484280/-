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
#import "LoginViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *titleArr;

@end

@implementation SetViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@[@"账号与安全",@"新消息通知",@"一键清理"],@[@"退出账号"]];
    }
    
    return _titleArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 20;
        _tableView.sectionFooterHeight = 20;
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
    
    NSArray *arr = self.titleArr[section];
    return arr.count;
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
    cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.textLabel.textColor = FontColor;
    
    if (indexPath.section == self.titleArr.count - 1) {
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                    [self accountSafetyVC];
                    break;
                case 1:
                    [self newsVC];
                    break;
                case 2:
                    [self cleanVC];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            
            [self loginOut];
            break;
        default:
            break;
    }
    
}

#pragma mark - 分割线顶到边
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
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

- (void)loginOut{
    
    MJWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出当前账号？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.view makeToastActivity:CSToastPositionCenter];
        [UserDefaultsTool deleteObjWithKey:@"staff_id"];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [weakSelf.navigationController pushViewController:loginVC animated:YES];
        });
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
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
