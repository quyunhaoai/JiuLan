//
//  CCNowpayOrderModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
#import "CCGoodsDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
//@interface Coupon_setItem :NSObject
//@property (nonatomic , assign) NSInteger              ccid;
//@property (nonatomic , copy) NSString              * begin_time;
//@property (nonatomic , copy) NSString              * end_time;
//@property (nonatomic , copy) NSString              * name;
//@property (nonatomic , assign) NSInteger              types;
//@property (nonatomic , assign) BOOL              use_selfimage;
//@property (nonatomic , copy) NSString              * selfimage;
//@property (nonatomic , copy) NSString              * cut;
//
//@end
@interface CCNowpayOrderModel : BaseModel
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , assign) CGFloat               order_total_price;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              balance;
@property (nonatomic , strong) NSArray <Coupon_setItem *>              * coupon_set;
@end

NS_ASSUME_NONNULL_END
