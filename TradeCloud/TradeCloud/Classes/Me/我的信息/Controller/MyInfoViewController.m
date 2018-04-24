//
//  MyInfoViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoCell.h"
#import "NameViewController.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *titleArr;

@end

@implementation MyInfoViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@[@"头像"],@[@"姓名",@"性别"],@[@"手机",@"座机"],@[@"邮箱"]];
    }
    
    return _titleArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 9.5;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArr.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MyInfoCell getHeightWithIndexPath:indexPath];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyInfoCell *cell = [MyInfoCell tempWithTableView:tableView andIndexPath:indexPath];
    
    [cell reciveTitle:self.titleArr[indexPath.section][indexPath.row] andIndex:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            [self goHeaderImg];
            break;
        
        default:
            [self goName:self.titleArr[indexPath.section][indexPath.row]];
            break;
    }
}

- (void)goHeaderImg{
    
    
}

- (void)goName:(NSString *)title{
    
    NameViewController *VC = [[NameViewController alloc] init];
    VC.name = title;
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"我的信息"];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
