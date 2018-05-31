//
//  MyApprovalViewModel.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/9.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalViewModel.h"
#import "MyApprovalModel.h"
#import "FieldDataModel.h"

@implementation MyApprovalViewModel

- (void)setModel:(MyApprovalModel *)model{
    
    _model = model;
    
    [self setModelFrame];
    
    [self setCellHeight];
    
}

- (void)setModelFrame{
    
    //标题
    CGFloat titleX = SPACING ;
    CGFloat titleY = SPACING ;
    CGFloat titleH = 21;
    CGSize textSize = [self.model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, titleH) options:NSStringDrawingUsesLineFragmentOrigin attributes:FONT context:nil].size;
    self.titleFrame = (CGRect){{titleX,titleY},textSize};
    
//    //状态
//    CGFloat imX = CGRectGetMaxX(self.titleFrame) + 10;
//    CGFloat imY = SPACING;
//    CGFloat imW = 45;
//    CGFloat imH = 25;
//    self.imFrame = CGRectMake(imX, imY, imW, imH);
    
    //日期
    CGFloat timeX = kScreenWidth - 120;
    CGFloat timeY = SPACING;
    CGFloat timeW = 100;
    CGFloat timeH = 21;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //多label
    self.desLaFrame = self.titleFrame;
    
    if (self.model.field_data.count > 0) {
        
        NSMutableString *str = [NSMutableString string];
        
        NSArray *laArr = [FieldDataModel mj_objectArrayWithKeyValuesArray:self.model.field_data];
        
        //按时间排序
        NSInteger DesMostLength = 0;
        NSInteger ValueMostLength = 0;
        for (int i=0;i < laArr.count;i++) {
            
            FieldDataModel *model = laArr[i];
            
            if (model.label_name.length > DesMostLength){
                
                DesMostLength = model.label_name.length;
                
            }
            
            if (model.value.length > ValueMostLength){
                
                ValueMostLength = model.label_name.length;
                
            }
        }
        
        
        for (int i = 0; i < laArr.count; i++) {
            
            FieldDataModel *model = laArr[i];
            if (i == laArr.count - 1) {
                
                [str appendFormat:@"%@",model.label_name];
            }else{
                
                [str appendFormat:@"%@\n",model.label_name];
            }
        }
        CGFloat height = [str getSpaceLabelHeightwithSpeace:8 withFont:[UIFont systemFontOfSize:17] withWidth:DesMostLength * 20 ];
        
        
        self.desLaFrame = CGRectMake(titleX, CGRectGetMaxY(self.titleFrame) + SPACING, DesMostLength * 20,  height);
     
        self.valueLaFrame = CGRectMake(CGRectGetMaxX(self.desLaFrame) + 20, CGRectGetMaxY(self.titleFrame) + SPACING, ValueMostLength * 20,  height);
    }
    
    
}

- (void)setCellHeight{
    
    self.cellHeight = CGRectGetMaxY(self.desLaFrame) + SPACING;
}
@end
