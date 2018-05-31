//
//  OrderCostSearchView.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "OrderCostSearchView.h"

@interface OrderCostSearchView()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIButton *sortBtn;
@property (strong, nonatomic) UIButton *detailSearchBtn;
@property (strong, nonatomic) UIButton *exportBtn;

@end

@implementation OrderCostSearchView

- (UILabel *)total{
    
    if (!_total) {
        
        _total = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + 8, kScreenWidth , 28)];
        _total.textColor = NAVBARCOLOR;
        _total.font = [UIFont boldSystemFontOfSize:15];
        _total.textAlignment = NSTextAlignmentCenter;
    }
    
    return _total;
}

- (UISearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, 50)];
        _searchBar.placeholder = @"款号搜索";
        _searchBar.backgroundImage = [UIImage imageNamed:@"headerbg_03"];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UIButton *)sortBtn{
    
    if (!_sortBtn) {
        
        _sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.searchBar.frame), 0, 60, 50)];
        [_sortBtn setImage:[UIImage imageNamed:@"sort_btn"] forState:UIControlStateNormal];
        [_sortBtn addTarget:self action:@selector(onSort:) forControlEvents:UIControlEventTouchUpInside];
        _sortBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    
    return _sortBtn;
}


- (UIButton *)detailSearchBtn{
    
    if (!_detailSearchBtn) {
        
        _detailSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.searchBar.frame) + 8, 75, 28)];
        _detailSearchBtn.layer.cornerRadius = 12;
        _detailSearchBtn.layer.masksToBounds = YES;
        [_detailSearchBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_detailSearchBtn setTitle:@"详细查询" forState:UIControlStateNormal];
        _detailSearchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_detailSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_detailSearchBtn addTarget:self action:@selector(onDetailSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _detailSearchBtn;
}

- (UIButton *)exportBtn{
    
    if (!_exportBtn) {
        
        _exportBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 76, CGRectGetMaxY(self.searchBar.frame) + 8, 60, 28)];
        _exportBtn.layer.cornerRadius = 12;
        _exportBtn.layer.masksToBounds = YES;
        [_exportBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_exportBtn setTitle:@"导出" forState:UIControlStateNormal];
        _exportBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_exportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exportBtn addTarget:self action:@selector(onExportBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _exportBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.searchBar];
    
    [self addSubview:self.sortBtn];
    
    [self addSubview:self.total];
    
    [self addSubview:self.detailSearchBtn];
    
    //[self addSubview:self.exportBtn];
    
}

- (void)onSort:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSortBtn:)]) {
        
        [self.delegate onSortBtn:btn];
    }
}

- (void)onDetailSearchBtn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDetailSearch)]) {
        
        [self.delegate onDetailSearch];
    }
}

- (void)onExportBtn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onExport)]) {
        
        [self.delegate onExport];
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSearchBtn:)]) {
        
        [self.delegate clickSearchBtn:searchBar.text];
    }
}


@end
