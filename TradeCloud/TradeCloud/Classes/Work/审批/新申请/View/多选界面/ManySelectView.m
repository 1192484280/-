//
//  ManySelectView.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/17.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "ManySelectView.h"
#import "ManySelectHeaderView.h"
#import "ManySelectCell.h"
#import "OptionsModel.h"

@interface ManySelectView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *bodyView;

@property (strong, nonatomic) ManySelectHeaderView *headerView;

@property (strong, nonatomic) UIButton *footerBtn;

@property (copy, nonatomic) NSArray *listArr;

@property (strong, nonatomic) NSMutableArray *selectArr;

@end

@implementation ManySelectView

- (NSMutableArray *)selectArr{
    
    if (!_selectArr) {
        
        _selectArr = [NSMutableArray array];
    }
    
    return _selectArr;
}

- (UIView *)bodyView{
    
    if (!_bodyView) {
        
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 65)];
        _bodyView.backgroundColor = [UIColor whiteColor];
        _bodyView.layer.cornerRadius = 10;
        
        [_bodyView addSubview:self.headerView];
        
        [_bodyView addSubview:self.tableView];
        
    }
    
    return _bodyView;
}
- (UIButton *)footerBtn{
    
    if (!_footerBtn) {
        
        _footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bodyView.frame) + 5, self.width, 50)];
        _footerBtn.layer.cornerRadius = 10;
        _footerBtn.backgroundColor = [UIColor whiteColor];
        [_footerBtn addTarget:self action:@selector(onSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [_footerBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_footerBtn setTitleColor:[UIColor colorWithHexString:@"#157EFB"] forState:UIControlStateNormal];
        _footerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    
    return _footerBtn;
}

- (void)onSureBtn{
    
    if (_finishBlock) {
        
        _finishBlock(self.selectArr);
    }
}
- (ManySelectHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[ManySelectHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, self.width, 0.5)];
        line.backgroundColor = DetailColor;
        line.alpha = 0.5;
        [_headerView addSubview:line];
    }
    
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.bodyView.height - 40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 10;
        _tableView.separatorColor = DetailColor;
        //_tableView.bounces = NO;//取消弹性
    }
    
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OptionsModel *model = self.listArr[indexPath.row];
    
    ManySelectCell *cell = [ManySelectCell tempWithTableView:tableView];
    
    [cell setOptionModel:model andSelectArr:self.selectArr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OptionsModel *model = self.listArr[indexPath.row];
    
    ManySelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.selectBtn.selected = !cell.selectBtn.selected;
    
    if (cell.selectBtn.selected) {
        
        [self.selectArr addObject:model];
    }else{
        
        [self.selectArr removeObject:model];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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

- (instancetype)initWithFrame:(CGRect)frame andArr:(NSArray *)listArr{
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self setUI:listArr];
    }
    
    return self;
}

- (void)setUI:(NSArray *)listArr{
    
    self.listArr = listArr;
    
    [self addSubview:self.bodyView];
    
    
    [self addSubview:self.footerBtn];
}

@end
