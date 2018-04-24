//
//  AppDelegate.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/26.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "NewsViewController.h"
#import "YYFPSLabel.h"
#import "LoginViewController.h"
#import "WorkViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *staff_id = [UserDefaultsTool getObjWithKey:@"staff_id"];
    if (staff_id) {
        
        TabBarController *tab = [[TabBarController alloc]init];
        self.window.rootViewController = tab;
        
    }else{
        
        LoginViewController *VC = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forBarMetrics:UIBarMetricsDefault];
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        [nav.navigationBar setTintColor:[UIColor whiteColor]];
        self.window.rootViewController = nav;
    }
    
    
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    [self keyBoardManager];
    
    return YES;
}

- (void)keyBoardManager{
    
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //开启
    manager.enable = YES;
    //如果产品需要当键盘弹起时，点击背景收起键盘，也是一行代码解决。
    manager.shouldResignOnTouchOutside = YES;
    
    //manager.enableAutoToolbar = NO;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
