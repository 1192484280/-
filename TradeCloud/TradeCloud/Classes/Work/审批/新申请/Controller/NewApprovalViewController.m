//
//  NewApprovalViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/30.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "NewApprovalViewController.h"
#import "NewApprovalCell.h"
#import "NewApprovalStore.h"
#import "NewApprovalModel.h"
#import "AddApprovalViewController.h"

@interface NewApprovalViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (copy, nonatomic) NSArray *titleArr;

@property (copy, nonatomic) NSArray *imgArr;

@property (strong, nonatomic) UILabel *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation NewApprovalViewController



- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"appro_01",@"appro_02",@"appro_03",@"appro_04",@"appro_05",@"appro_06",@"appro_07"];
    }
    
    return _imgArr;
}
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[NewApprovalCell class] forCellWithReuseIdentifier:@"CELL"];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NormalBgColor;
    
    [self setNavBarWithTitle:@"新申请"];
    
    [self.view addSubview:self.collectionView];

    [self refresh];
    
}



- (void)back{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}


- (void)refresh{
    
    [self.view makeToastActivity:CSToastPositionCenter];
    
    NewApprovalStore *store = [[NewApprovalStore alloc] init];
    
    MJWeakSelf
    [store getNewApplyModelListSuccess:^(NSArray *listArr) {
        
        self.titleArr = listArr;
        [self.collectionView reloadData];
        [weakSelf.view hideToastActivity];
    } Failure:^(NSError *error) {
        
        [self showMBPError:[HttpTool handleError:error]];
        [weakSelf.view hideToastActivity];
    }];
}
//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewApprovalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    NewApprovalModel *model = self.titleArr[indexPath.row];
    [cell reciveTitle:model.name andImg:self.imgArr[indexPath.row]];
    return cell;
    
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的大小（size）
    
    return CGSizeMake((kScreenWidth - 45)/3 , (kScreenWidth -45)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddApprovalViewController *VC = [[AddApprovalViewController alloc] init];
    NewApprovalModel *model = self.titleArr[indexPath.row];
    VC.model = model;
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
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
