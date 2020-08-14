//
//  CCNeedListModel.h
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCNeedListModel : BaseModel
@property (nonatomic,copy) NSString *create_time;  //
@property (assign, nonatomic) NSInteger id;    //
@property (nonatomic,copy) NSString *info;  //
@property (nonatomic,copy) NSString *name;  //
@property (nonatomic,copy) NSString *ccoperator;  // nam
@property (strong, nonatomic) NSArray *photo_set;   //
@property (strong, nonatomic) NSArray *image_set;   //
@property (nonatomic,copy) NSString *refuse_reason;  //
@property (assign, nonatomic) NSInteger status;    //
@property (assign, nonatomic) NSInteger amount;    //
@property (nonatomic,copy) NSString *finish_time;  //
@property (nonatomic,copy) NSString *unit;  //
@property (nonatomic,copy) NSString *reason;  //
@property (nonatomic,copy) NSString *check_time;  //


@property (nonatomic , copy) NSString              * pay_time;

@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * play_unit;
@property (nonatomic , assign) NSInteger              diff_price;

@property (nonatomic , copy) NSString              * check_person;
@property (nonatomic , copy) NSString              * status_str;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              count;

@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              action_price;

@property (nonatomic , assign) NSInteger              center_sku_id;
@end

NS_ASSUME_NONNULL_END
