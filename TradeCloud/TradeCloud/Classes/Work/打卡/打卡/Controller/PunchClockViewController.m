//
//  PunchClockViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/29.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "PunchClockViewController.h"
#import "SMPagerTabView.h"
#import "WorkClockController.h"
#import "OutClockController.h"
#import "MapViewController.h"

@interface PunchClockViewController ()<SMPagerTabViewDelegate,WorkClockControllerDelegate,OutClockControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}
@property (weak, nonatomic) UISegmentedControl *tap;
@property (nonatomic, strong) NSMutableArray *vcArr;
@property (nonatomic, strong) SMPagerTabView *segmentView;
@property (weak, nonatomic) UIButton *bbtn;
@end

@implementation PunchClockViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setNavBar];
    
    [self setUI];
}

- (void)setUI{
    
    _vcArr = [NSMutableArray array];
    
    WorkClockController *workVC = [[WorkClockController alloc]initWithNibName:nil bundle:nil];
    workVC.delegate = self;
    
    OutClockController *outVC = [[OutClockController alloc]initWithNibName:nil bundle:nil];
    outVC.delegate = self;
    
    [_vcArr addObject:workVC];
    [_vcArr addObject:outVC];
    
    self.segmentView.delegate = self;
    
    [_segmentView buildUI];
    
    
}

- (void)onWorkPhoto:(UIButton *)btn{
    
    self.bbtn = btn;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        CATransition *animation = [CATransition animation];
        
        animation.duration =1.0;
        
        animation.type =@"cameraIrisHollowOpen";
        
        
        animation.subtype = kCATransitionFromLeft;
        
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        
        [self presentViewController:picker animated:NO completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
    
}

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        
        //图片存入相册
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [self.bbtn setTitle:@"OK" forState:UIControlStateNormal];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
    
    UISegmentedControl *tap = [[UISegmentedControl alloc] initWithItems:@[@"上下班打卡",@"外出打卡"]];
    tap.frame = CGRectMake(100, 100, 150, 30);
    tap.tintColor = [UIColor whiteColor];
    [tap addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    tap.selectedSegmentIndex = 0;
    self.navigationItem.titleView = tap;
    self.tap = tap;
}

- (void)selectItem:(UISegmentedControl *)sender {
    
    [self.segmentView selectTabWithIndex:sender.selectedSegmentIndex animate:YES];
    
}

- (void)back{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_vcArr count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _vcArr[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    if (number == 1) {
        
        self.tap.selectedSegmentIndex = 1;
        
    }else if (number == 0){
        
        self.tap.selectedSegmentIndex = 0;
    }
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (TAB_BAR_HEIGHT) - (iPhoneX_Top))];
        self.segmentView.theight = 0;
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}


- (void)onRemark:(UIButton *)btn{
    
    [self showMBPError:[NSString stringWithFormat:@"%@",btn.currentTitle]];
}
- (void)onAddres:(UIButton *)btn{
    
    MapViewController *mapVC = [[MapViewController alloc] init];
    [mapVC returnLocationBlock:^(BMKPoiInfo *location) {
        [btn setTitle:location.name forState:UIControlStateNormal];
    }];
    [mapVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:mapVC animated:YES];
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
