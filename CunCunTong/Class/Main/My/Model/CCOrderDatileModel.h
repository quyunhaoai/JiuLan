//
//  CCOrderDatileModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
#import "CCMyOrderModel.h"
#import "CCCheXiaoOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDatileModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * pay_time;
@property (nonatomic , copy) NSString              * receive_time;
@property (nonatomic , copy) NSString              * send_time;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) CGFloat              total_play_price;
@property (nonatomic , assign) CGFloat              pay_price;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * coupon;
@property (nonatomic , copy) NSString              * postinfo;
@property (nonatomic , strong) NSArray <Goods_order_setItem *>              * goods_order_set;
@property (nonatomic , strong) Person_info              * person_info;
@end

NS_ASSUME_NONNULL_END
