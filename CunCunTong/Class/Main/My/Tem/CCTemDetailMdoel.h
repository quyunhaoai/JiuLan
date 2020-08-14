//
//  CCTemDetailMdoel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCTemDetailMdoel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * check_time;
@property (nonatomic , copy) NSString              * pay_time;
@property (nonatomic , copy) NSString              * finish_time;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * play_unit;
@property (nonatomic , assign) NSInteger              diff_price;
@property (nonatomic , assign) NSInteger              total_diff_price;
@property (nonatomic , strong) NSArray <NSString *>              * image_set;
@property (nonatomic , copy) NSString              * status_str;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              action_price;
@property (nonatomic , copy) NSString              * reason;
@property (nonatomic , assign) NSInteger              audit_level;
@property (nonatomic , assign) NSInteger              center_sku_id;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor1_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor2_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor3_set;
@end

NS_ASSUME_NONNULL_END
