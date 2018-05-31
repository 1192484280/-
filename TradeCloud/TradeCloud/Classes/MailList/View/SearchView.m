//
//  SearchView.m
//  TradeCloud
//
//  Created by zhangming on 2018/3/27.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "SearchView.h"

@interface SearchView()<UISearchBarDelegate>


@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame andplaceHoder:(NSString *)placeHoder{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUIWithplaceHoder:placeHoder];
    }
    return self;
}

- (void)setUIWithplaceHoder:(NSString *)placeHoder{
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:self.bounds];
    searchBar.placeholder = placeHoder;
    searchBar.backgroundImage = [UIImage imageNamed:@"headerbg_03"];
    searchBar.tintColor = NAVBARCOLOR;
    searchBar.delegate = self;
    UITextField * searchField = [searchBar valueForKey:@"_searchField"];
//    [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self addSubview:searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickSearchBtn:)]) {
        
        [self.delegate ClickSearchBtn:searchBar.text];
    }
}
@end
