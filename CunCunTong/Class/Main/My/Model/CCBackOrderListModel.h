//
//  CCBackOrderListModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Batch_setItem :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              live_time;
@property (nonatomic , copy) NSString              * expire_date;

@end
@interface CCBackOrderListModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * play_unit;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray <Batch_setItem *>              * batch_set;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * check_time;
@property (nonatomic , copy) NSString              * finish_time;
@property (nonatomic , copy) NSString              * pay_time;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * back_reason;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic , assign) CGFloat              total_play_price;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , assign) NSInteger              status;

@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;

@property (nonatomic , copy) NSString              * recive_time;
@property (nonatomic , copy) NSString              * refuse_reason;
@property (nonatomic , copy) NSString              * remark;

@property (nonatomic , assign) NSInteger              audit_level;
@property (nonatomic , assign) NSInteger              types;

@property (nonatomic , assign) NSInteger              count;

@property (nonatomic , strong) NSArray <NSNumber *>              * auditor1_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor2_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor3_set;
@end

NS_ASSUME_NONNULL_END
