//
//  AddApprovalViewController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/7.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "AddApprovalViewController.h"
#import "NewApprovalModel.h"
#import "NewApprovalStore.h"
#import "CommonStore.h"
#import "CreatApprovalModel.h"
#import "ApprovalModelBaseCell.h"
#import "OptionsModel.h"
#import "ApprovalModelBaseCell.h"
#import "ApprovalModelUrlCell.h"
#import "CreatApprovalList.h"
#import "CreatApprovalDataModel.h"
#import "ApprovalIdsArrayModel.h"
#import "ManySelectView.h"

@interface AddApprovalViewController ()<UITableViewDelegate,UITableViewDataSource,ApprovalModelBaseCellDelegate>

@property (strong, nonatomic) CreatApprovalDataModel *_manySelectModel;//临时容器。存放多选model
@property (strong, nonatomic) NSIndexPath *_indexPath;

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *dataArr;

@property (strong, nonatomic) CreatApprovalUrlModel *urlModel;

//必填参数为value的字典
@property (strong, nonatomic) NSMutableDictionary *requireDic;

//多选数组
@property (copy, nonatomic) NSArray *manyArr;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) ManySelectView *manySelectView;

@end


@implementation AddApprovalViewController

- (ManySelectView *)manySelectView{
    
    if (!_manySelectView) {
        
        CGFloat height = self.manyArr.count * 50 + 40 + 14 + 50;
        
        if (self.manyArr.count > 8 ) {
            
            height = 8 * 50 + 40 + 14 + 50;
        }
        
        _manySelectView = [[ManySelectView alloc] initWithFrame:CGRectMake(10, kScreenHeight, kScreenWidth - 20, height) andArr:self.manyArr];
        
        MJWeakSelf
        _manySelectView.finishBlock = ^(NSArray *selectedArr) {
          
            [weakSelf didBgViewClick];
            
            if (selectedArr.count > 0) {
                
                
                NSMutableString *str = [NSMutableString string];
                for (int i = 0; i < selectedArr.count; i++) {
                    
                    OptionsModel *model = selectedArr[i];
                    if (i == selectedArr.count - 1) {
                        
                        [str appendFormat:@"%@",model.name];
                        
                    }else{
                        
                        [str appendFormat:@"%@,",model.name];
                    }
                }
                [[CreatApprovalList sharedInstance].approvalDic setObject:str forKey:weakSelf._manySelectModel.value_name];
            }else{
                
                [[CreatApprovalList sharedInstance].approvalDic setObject:@"请选择" forKey:weakSelf._manySelectModel.value_name];
            }
            
    
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:weakSelf._indexPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [self.view addSubview:_manySelectView];
    }
    
    return _manySelectView;
}


- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgViewClick)]];
    }
    return _bgView;
}

- (void)didBgViewClick
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.manySelectView.y = kScreenHeight;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
}

#pragma mark - 盛放必填参数的字典
- (NSMutableDictionary *)requireDic{
    
    if (!_requireDic) {
        
        _requireDic = [NSMutableDictionary dictionary];
    }
    
    return _requireDic;
    
}
- (NSArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSArray array];
    }
    
    return _dataArr;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
    }
    
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.dataArr.count;
    }else{
        
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CreatApprovalDataModel *model = self.dataArr[indexPath.row];
        
        return [ApprovalModelBaseCell getHeightWithModel:model];
        
    }else{
        
        return [ApprovalModelUrlCell getHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CreatApprovalDataModel *model = self.dataArr[indexPath.row];
        
        ApprovalModelBaseCell *cell = [ApprovalModelBaseCell tempWithTableView:tableView andModel:model];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        [cell setModel:model];
        
        return cell;
    }else{
        
        ApprovalModelUrlCell *cell = [ApprovalModelUrlCell tempWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.urlModel];
        
        return cell;
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CreatApprovalList sharedInstance].approvalDic = [NSMutableDictionary dictionary];
    
    [self setNavBar];
    
    [self.view addSubview:self.tableView];
    
    [self refresh];
    
    //[self.view addSubview:self.manySelectView];
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:self.model.name];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(onPostBtn)];
    
}

- (void)onPostBtn{
    
    
    
    [self.view endEditing:YES];
    

    NSArray *requireArr = [self.requireDic allKeys];
    
    //判断必填参数是否都填完
    for (int i =0; i<requireArr.count; i++) {
        
        NSString *key = requireArr[i];
        
        if ([[CreatApprovalList sharedInstance].approvalDic[key] isKindOfClass:[NSString class]]) {
            
            NSString *value = [CreatApprovalList sharedInstance].approvalDic[key];
            if (!(value.length > 0) || [value isEqualToString:@"请选择"]) {
                
                [self showMBPError:[NSString stringWithFormat:@"请补充%@",self.requireDic[key]]];
                return;
            }
            
        }else{
            
            NSArray *arr = [CreatApprovalList sharedInstance].approvalDic[key];
            if (!(arr.count > 0)) {
                
                [self showMBPError:[NSString stringWithFormat:@"请补充%@",self.requireDic[key]]];
                return;
            }
            
        }

    }
    
    if (!([CreatApprovalList sharedInstance].peopleArr.count > 0)) {
        
        [self showMBPError:@"请添加审批人"];
        return;
    }
    
    //把审批人id分割添加进参数字典
    NSMutableString *peopleIds = [NSMutableString string];
    for (int i = 0; i < [CreatApprovalList sharedInstance].peopleArr.count; i++) {
        
        ApprovalIdsArrayModel *people = [CreatApprovalList sharedInstance].peopleArr[i];
        
        if (i == [CreatApprovalList sharedInstance].peopleArr.count - 1) {
            
            [peopleIds appendFormat:@"%@",people.uid];
            
        }else{
            
            [peopleIds appendFormat:@"%@,",people.uid];
        }
    }
    
    [[CreatApprovalList sharedInstance].approvalDic setObject:peopleIds forKey:@"wait_checker_ids"];
    
    //判断是否有多图上传
    BOOL isExist = NO;
    for (CreatApprovalDataModel *model in self.dataArr) {
        
        NSInteger type = [model.type intValue];
        if (type == 6) {
            
            isExist = YES;
        }
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view makeToastActivity:CSToastPositionCenter];;
    
    if (!isExist) {
        
        [self postStore];
    }else{
        
        
        for (int i =0; i < requireArr.count; i++) {
            
            NSString *key = requireArr[i];
            
            if ([[CreatApprovalList sharedInstance].approvalDic[key] isKindOfClass:[NSArray class]]) {
                
                NSArray *imgArr = [CreatApprovalList sharedInstance].approvalDic[key];
                
                if ([imgArr[0] isKindOfClass:[UIImage class]]) {
                    
                    
                    //信号量实现请求完一次接口再请求一次
                    NSMutableArray *imgUrlArr = [NSMutableArray array];
                    
                    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
                    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    
                    MJWeakSelf
                    for (int i =0; i<imgArr.count; i++) {
                        
                        
                        //任务1
                        dispatch_async(quene, ^{
                            
                            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                            CommonStore *store = [[CommonStore alloc] init];
                            [store upPhoto:imgArr[i] Success:^(NSString *imgUrl) {
                                
                                [imgUrlArr addObject:imgUrl];
                                
                                dispatch_semaphore_signal(semaphore);
                                
                                if (i == imgArr.count - 1) {
                                    
                                    [[CreatApprovalList sharedInstance].approvalDic setObject:[imgUrlArr mj_JSONString] forKey:key];
                                    [weakSelf postStore];
                                }
                                
                            } Failure:^(NSError *error) {
                                
                                
                            }];
                            
                        });
                        
                        
                    }
                }
                
            }
        
    }
}
}
- (void)postStore{
    
    NewApprovalStore *store = [[NewApprovalStore alloc] init];
    MJWeakSelf
    [store postApprovalWithId:self.model.template_id Dic:[CreatApprovalList sharedInstance].approvalDic Success:^{
        
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.view hideToastActivity];
        [weakSelf showMBPError:@"成功提交审批！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //创建新模板后发送通知
            NSNotification *notification = [NSNotification notificationWithName:CreatNewApprovalNotification object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            
        });
        
    } Failure:^(NSError *error) {
        
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.view hideToastActivity];
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}

- (void)refresh{
    
    MJWeakSelf
    NewApprovalStore *store = [[NewApprovalStore alloc] init];
    [store getModelDetailWithId:self.model.template_id Success:^(CreatApprovalModel *model) {
        
        NSArray *dataArr = [CreatApprovalDataModel mj_objectArrayWithKeyValuesArray:model.data];
        
        weakSelf.dataArr = dataArr;
        weakSelf.urlModel = model.url;
        
        NSArray *arr = [ApprovalIdsArrayModel mj_objectArrayWithKeyValuesArray:model.url.approval_ids_array];
        
        [CreatApprovalList sharedInstance].peopleArr = [NSMutableArray arrayWithArray:arr];
        
        for (CreatApprovalDataModel *model in dataArr) {

            NSInteger type = [model.type intValue];
            
            if (type == 7 || type == 8 || type == 9 || type == 10) {
             
                [[CreatApprovalList sharedInstance].approvalDic setObject:@"请选择" forKey:model.value_name];
            }else{
                
                [[CreatApprovalList sharedInstance].approvalDic setObject:@"" forKey:model.value_name];
            }
            
            NSInteger require = [model.require intValue];
            
            if (require == 1) {
                
                [weakSelf.requireDic setObject:model.label_name forKey:model.value_name];
            }
            
            
        }
        
        [weakSelf.tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}


#pragma mark - 点击多选
- (void)onManySelectBtnwithArr:(NSArray *)arr withModel:(CreatApprovalDataModel *)model andIndexPath:(NSIndexPath *)indexPath{
    
    self._manySelectModel = model;
    self._indexPath = indexPath;
    
    //测试
//    NSMutableArray *larr = [NSMutableArray array];
//
//    for (int i =0; i< 2; i++) {
//
//        [larr addObject:arr[i]];
//    }
    
    self.manyArr = [NSArray arrayWithArray:arr];
    
    [self.view insertSubview:self.bgView belowSubview:self.manySelectView];
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat height = self.manyArr.count * 50 + 40 + 14 + 50;
        
        if (self.manyArr.count > 8 ) {
            
            height = 8 * 50 + 40 + 14 + 50;
        }
        self.manySelectView.y = kScreenHeight - (iPhoneX_Top) - height - (iPhoneX_Bottom);
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
