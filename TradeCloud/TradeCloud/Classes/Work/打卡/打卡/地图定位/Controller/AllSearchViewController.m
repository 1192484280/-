//
//  AllSearchViewController.m
//  JuHuiLife
//
//  Created by zhangming on 2018/2/1.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import "AllSearchViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AllSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AllSearchViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"搜索结果"];
    
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    BMKPoiInfo *info = self.listArr[indexPath.row];
    cell.textLabel.text = info.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [SingleManager sharedInstance].selectedLocalInfo = self.listArr[indexPath.row];
    if (self.onLocalBlock !=nil) {
        self.onLocalBlock(@"");
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)returnOnLocalBlack:(onLocalBlock)block{
    
    self.onLocalBlock = block;
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
