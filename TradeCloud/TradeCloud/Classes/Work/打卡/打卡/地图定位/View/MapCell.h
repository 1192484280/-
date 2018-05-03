//
//  MapCell.h
//  JuHuiLife
//
//  Created by zhangming on 2018/1/31.
//  Copyright © 2018年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface MapCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *address;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)cell;

@property (strong, nonatomic) BMKPoiInfo *model;

@end
