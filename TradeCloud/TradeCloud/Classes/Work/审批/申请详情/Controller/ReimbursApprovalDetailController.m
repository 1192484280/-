//
//  ReimbursApprovalDetailController.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/8.
//  Copyright © 2018年 zhangming. All rights reserved.
//  报销详情

#import "ReimbursApprovalDetailController.h"
#import "ApprovalDetailStore.h"
#import "MyApprovalList.h"
#import "MyApprovalModel.h"
#import "ApprovalDetailModel.h"
#import "ProcessModel.h"
#import "ZhuanShenController.h"
#import "ReimbursApprovalHeaderView.h"
#import "ReimbursApprovalBottomView.h"
#import "ReimbursTopCell.h"
#import "ReimbursMiddleCell.h"
#import "ReimbursBottomCell.h"

@interface ReimbursApprovalDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_approva_staff_id;//催办id
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ApprovalDetailModel *detailModel;

@property (strong, nonatomic) ReimbursApprovalHeaderView *headerView;
@property (strong, nonatomic) ReimbursApprovalBottomView *bottomView;

@end

@implementation ReimbursApprovalDetailController

- (ReimbursApprovalHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[ReimbursApprovalHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        
    }
    
    return _headerView;
}

- (ReimbursApprovalBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[ReimbursApprovalBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - (TAB_BAR_HEIGHT) - (iPhoneX_Top), kScreenWidth, TAB_BAR_HEIGHT) withPage:self.showBottomView1];
        
        MJWeakSelf
        _bottomView.passBlock = ^{
            
            NSLog(@"同意");
            [weakSelf handlesStoreWithStatus:@"1"];
        };
        
        _bottomView.refuseBlock = ^{
            NSLog(@"拒绝");
            [weakSelf handlesStoreWithStatus:@"2"];
        };
        
        _bottomView.urgeBlock = ^{
            
            NSLog(@"催办");
            [weakSelf urgeStore];
            
        };
        
        _bottomView.RevokeBlock = ^{
        
            NSLog(@"撤销");
            [weakSelf showMBPError:@"撤销"];
        };
        
        
    }
    
    return _bottomView;
}

#pragma mark - 同意/拒绝store
- (void)handlesStoreWithStatus:(NSString *)status{

    ApprovalDetailStore *store = [[ApprovalDetailStore alloc] init];
    MJWeakSelf
    [store handleApprovalWithStaff_id:[UserDefaultsTool getObjWithKey:@"staff_id"] andApproval_id:[MyApprovalList sharedInstance].selectedModel.approval_id andStatus:status Success:^{
        
        if ([status isEqualToString:@"1"]) {
            
            [weakSelf showMBPError:@"已同意！"];
            

        }else{
            
            [weakSelf showMBPError:@"已驳回！"];
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //审批操作后发送通知
            NSNotification *notification = [NSNotification notificationWithName:HandleApprovalNotification object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}


#pragma mark - 催办
- (void)urgeStore{

    ApprovalDetailStore *store = [[ApprovalDetailStore alloc] init];
    MJWeakSelf
    [store urgeApprovalWithStaff_id:_approva_staff_id andMsg:@"报告大王！请加快审批！！！" Success:^{
        

        [weakSelf showMBPError:@"已催办！"];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        if (self.showBottomView1 || self.showBottomView2) {
            
            _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top) - (TAB_BAR_HEIGHT));
        }else{
            
            _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX_Top));
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = NormalBgColor;
        _tableView.tableHeaderView = self.headerView;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.detailModel.field_data_desc.count;
    }else if (section == 1){
        
        return self.detailModel.field_data_content.count;
    }else{
        
        return self.detailModel.process_list.count;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 35;
        
    }else if(indexPath.section == 1){
        
        FieldDataModel *model = self.detailModel.field_data_content[indexPath.row];
        return [ReimbursMiddleCell getHeightWithIndexPath:indexPath andModel:model];
        
    }else{
        
        return [ReimbursBottomCell getHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        FieldDataModel *model = self.detailModel.field_data_desc[indexPath.row];
        ReimbursTopCell *cell = [ReimbursTopCell tempWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
        
    }else if (indexPath.section == 1){
        
        FieldDataModel *model = self.detailModel.field_data_content[indexPath.row];
        ReimbursMiddleCell *cell = [ReimbursMiddleCell tempWithTableView:tableView andIndexPath:indexPath withModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
        
    }else{
        
        ProcessModel *model = self.detailModel.process_list[indexPath.row];
        ReimbursBottomCell *cell = [ReimbursBottomCell tempWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        return 45;
    }else{
        
        return 45;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    if (section == 1) {
        
        la.text = @"    明细";
    }else{
        
        la.text = @"    审批流程";
    }
    
    la.backgroundColor = [UIColor whiteColor];
    la.font = [UIFont boldSystemFontOfSize:15];
    return la;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarWithTitle:[MyApprovalList sharedInstance].selectedModel.title];
    
    [self.view addSubview:self.tableView];
    
    if (self.showBottomView1 || self.showBottomView2) {
        
        [self.view addSubview:self.bottomView];
    }
    
    [self refresh];
}

- (void)refresh{
    
    ApprovalDetailStore *store = [[ApprovalDetailStore alloc] init];
    
    MJWeakSelf
    [store getApprovalDetailWithStaff_id:[UserDefaultsTool getObjWithKey:@"staff_id"] andApproval_id:[MyApprovalList sharedInstance].selectedModel.approval_id Success:^(ApprovalDetailModel *model) {

        weakSelf.detailModel = model;
        weakSelf.headerView.model = model;
        [weakSelf.tableView reloadData];
        
        if (weakSelf.showBottomView2) {
            
            NSArray *perArr = model.process_list;
            for (ProcessModel *model in perArr) {
                
                if ([model.title rangeOfString:@"审批中"].location != NSNotFound) {
                    
                    _approva_staff_id = model.approval_staff_id;
                }
            }
        }
        
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf showMBPError:[HttpTool handleError:error]];
    }];
}

///////*******************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ReimbursBottomViewDelegate
- (void)onPassBtn {
    
    [self showMBPError:@"通过"];
}

- (void)onRefuseBtn {
    
    [self showMBPError:@"拒绝"];
}

- (void)onTransferBtn {
    
    ZhuanShenController *VC = [[ZhuanShenController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
