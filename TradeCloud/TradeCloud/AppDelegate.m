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
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//百度地图引入base相关所有的头文件

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

//审批页面
#import "ApprovalTabController.h"

#define BMAK @"3h4QHm63V1qyKCwARzXedo5IoKghhllw"
#define JPushKey @"852e7b90d104039ec23002ab"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) BMKMapManager *mapManager;

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
    
    [self setBMap];
    
    [self setup_APNs];
    [self setup_JpushdidFinishLaunchingWithOptions:launchOptions];
    
    //进入app清除角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}


#pragma mark - 设置IQKeyboardManager
- (void)keyBoardManager{
    
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //开启
    manager.enable = YES;
    //如果产品需要当键盘弹起时，点击背景收起键盘，也是一行代码解决。
    manager.shouldResignOnTouchOutside = YES;
    
    //manager.enableAutoToolbar = NO;
    
}

#pragma mark - 设置百度地图
- (void)setBMap{
    
    //百度地图
    _mapManager = [BMKMapManager new];
    BOOL ret = [_mapManager start:BMAK generalDelegate:nil];
    if (!ret) {
        
        NSLog(@"百度地图启动失败");
        
    } else {
        
        NSLog(@"百度地图启动成功");
        
    }
}

#pragma mark - 设置极光推送
//添加初始化APNs代码
- (void)setup_APNs{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
}


//添加初始化JPush代码
- (void)setup_JpushdidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:nil
                 apsForProduction:0
            advertisingIdentifier:advertisingId];
    
    
}

#pragma mark - 注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


#pragma mark - 实现注册APNs失败接口（可选
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark - 添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    //接受到消息后将app角标清除
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"推送消息===%@",userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        [self goToMssageViewControllerWith:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    application.applicationIconBadgeNumber = 0;
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [self goToMssageViewControllerWith:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    application.applicationIconBadgeNumber = 0;
    [self goToMssageViewControllerWith:userInfo];
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    
    //创建新模板后发送通知
//    NSNotification *notification = [NSNotification notificationWithName:UrgeNotification object:nil userInfo:nil];
//    
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    ApprovalTabController * VC = [[ApprovalTabController alloc]init];
    [VC setSelectedIndex:1];
    // 获取导航控制器
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    
    // 跳转到对应的控制器
    [pushClassStance pushViewController:VC animated:YES];
    
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
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
