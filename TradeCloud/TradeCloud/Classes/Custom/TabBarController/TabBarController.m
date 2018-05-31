//
//  TabBarController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "TabBarController.h"
#import "HeaderViewController.h"
#import "NewsViewController.h"
#import "MailListViewController.h"
#import "WorkViewController.h"
#import "MeViewController.h"
#import "LoginViewController.h"

@interface TabBarController ()

@property (copy, nonatomic) NSArray *vcArr;
@property (copy, nonatomic) NSArray *titleArr;
@property (copy, nonatomic) NSArray *normalImgArr;
@property (copy, nonatomic) NSArray *selectedImgArr;

@end

@implementation TabBarController


- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        _vcArr = @[[HeaderViewController class],[NewsViewController class],[MailListViewController class],[WorkViewController class],[MeViewController class]];
    }
    
    return _vcArr;
}

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"首页",@"消息",@"通讯录",@"工作台",@"我"];
    }
    
    return _titleArr;
}

- (NSArray *)normalImgArr{
    
    if (!_normalImgArr) {
        
        _normalImgArr = @[@"icon_tabBar01_normal",@"icon_tabBar02_normal",@"icon_tabBar03_normal",@"icon_tabBar04_normal",@"icon_tabBar05_normal"];
    }
    
    return _normalImgArr;
}

- (NSArray *)selectedImgArr{
    
    if (!_selectedImgArr) {
        
        _selectedImgArr = @[@"icon_tabBar01_selected",@"icon_tabBar02_selected",@"icon_tabBar03_selected",@"icon_tabBar04_selected",@"icon_tabBar05_selected"];
    }
    
    return _selectedImgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i =0; i<self.vcArr.count;i++) {

        [self addChildVCWithClass:self.vcArr[i] andTitle:self.titleArr[i] andNormalImg:self.normalImgArr[i] andSelectImg:self.selectedImgArr[i]];
    }

}

- (void)addChildVCWithClass:(Class)class andTitle:(NSString *)title andNormalImg:(NSString *)normalImg andSelectImg:(NSString *)selectedImg{
    
    UIViewController *VC = [[class alloc] init];
    VC.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    nav.tabBarItem.title = title;
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVBARCOLOR} forState:UIControlStateSelected];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    nav.tabBarItem.image = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
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
