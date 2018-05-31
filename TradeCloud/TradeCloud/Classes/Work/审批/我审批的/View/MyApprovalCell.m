//
//  MyApprovalCell.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/3.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "MyApprovalCell.h"
#import "MyApprovalModel.h"
#import "MyApprovalViewModel.h"
#import "FieldDataModel.h"

@interface MyApprovalCell()

@property (weak, nonatomic) UILabel *titleLa;

@property (weak, nonatomic) UILabel *timeLa;

@property (strong, nonatomic) UILabel *desLa;

@property (strong, nonatomic) UILabel *valueLa;

@end

@implementation MyApprovalCell


+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    static NSString *cellId = @"CELL";
    
    MyApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell = [[MyApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    UILabel *titleLa = [[UILabel alloc] init];
    [self addSubview:titleLa];
    titleLa.font = [UIFont boldSystemFontOfSize:17];
    self.titleLa = titleLa;
    
    UILabel *timeLa = [[UILabel alloc] init];
    [self addSubview:timeLa];
    timeLa.textAlignment = NSTextAlignmentRight;
    timeLa.font = [UIFont systemFontOfSize:15];
    timeLa.textColor = FontColor;
    self.timeLa = timeLa;
    
    UILabel *desLa = [[UILabel alloc] init];
    [self addSubview:desLa];
    desLa.numberOfLines = 0;
    self.desLa = desLa;
    
    UILabel *valueLa = [[UILabel alloc] init];
    [self addSubview:valueLa];
    valueLa.numberOfLines = 0;
    self.valueLa = valueLa;
    
}


- (void)setFrameModel:(MyApprovalViewModel *)frameModel{
    
    _frameModel = frameModel;
    
    self.titleLa.text = frameModel.model.title;
    self.timeLa.text = frameModel.model.add_time_zh;
    [self setDesLabelWith:self.desLa withModel:frameModel];
    [self setValueLabelWith:self.valueLa withModel:frameModel];
    
    self.titleLa.frame = frameModel.titleFrame;
    self.timeLa.frame = frameModel.timeFrame;
    self.timeLa.centerY = self.titleLa.centerY;
    self.desLa.frame = frameModel.desLaFrame;
    self.valueLa.frame = frameModel.valueLaFrame;
    
    
}


- (void)setDesLabelWith:(UILabel *)la withModel:(MyApprovalViewModel *)frameModel{
    
    NSMutableString *str = [NSMutableString string];
    NSArray *laArr = [FieldDataModel mj_objectArrayWithKeyValuesArray:frameModel.model.field_data];
    for (int i = 0; i < laArr.count; i++) {
        
        FieldDataModel *model = laArr[i];
        if (i == laArr.count - 1) {
            
            [str appendFormat:@"%@",model.label_name];
        }else{
            
            [str appendFormat:@"%@\n",model.label_name];
        }
    }
    
    la.attributedText = [str stringWithParagraphlineSpeace:8 textColor:FontColor textFont:[UIFont systemFontOfSize:17]];
}

- (void)setValueLabelWith:(UILabel *)la withModel:(MyApprovalViewModel *)frameModel{
    
    NSMutableString *str = [NSMutableString string];
    NSArray *laArr = [FieldDataModel mj_objectArrayWithKeyValuesArray:frameModel.model.field_data];
    for (int i = 0; i < laArr.count; i++) {
        
        FieldDataModel *model = laArr[i];
        if (i == laArr.count - 1) {
            
            [str appendFormat:@"%@",model.value];
        }else{
            
            [str appendFormat:@"%@\n",model.value];
        }
    }
    
    la.attributedText = [str stringWithParagraphlineSpeace:8 textColor:FontColor textFont:[UIFont systemFontOfSize:17]];
}
    
  
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
