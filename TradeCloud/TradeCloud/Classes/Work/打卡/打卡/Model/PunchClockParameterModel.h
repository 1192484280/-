//
//  PunchClockParameterModel.h
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PunchClockParameterModel : NSObject

/*必填*/


/**
 * 公司id
 */
@property (nonatomic, copy) NSString *company_id;

/**
 * 部门id
 */
@property (nonatomic, copy) NSString *department_id;

/**
 * 员工id
 */
@property (nonatomic, copy) NSString *staff_id;

/**
 * 打卡类型
 */
@property (nonatomic, copy) NSString *type_status;

/**
 * 员工照片
 */
@property (nonatomic, copy) NSString *image;

/**
 * 打卡位置
 */
@property (nonatomic, copy) NSString *location;

/*选填*/

/**
 * 备注
 */
@property (nonatomic, copy) NSString *note;

@end
