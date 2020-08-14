//
//  CCMyOrderModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Sku_order_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic, assign) NSInteger             center_sku_id;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * specoption;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic , assign) CGFloat              total_play_price;
@property (nonatomic , copy) NSString              * goods_name;
@property (assign, nonatomic) BOOL can_back;
@property (nonatomic , assign) NSInteger              center_goods_id;
@property (nonatomic , copy) NSString              * promote;

@end
@interface Goods_order_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , assign) NSInteger              total_play_price;
@property (nonatomic , assign) NSInteger              total_old_play_price;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * reduce;
@property (nonatomic , strong) NSArray <Sku_order_setItem *>              * sku_order_set;

@end
@interface CCMyOrderModel : BaseModel
@property (assign, nonatomic) BOOL isSelectView;
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) CGFloat              total_play_price;
@property (nonatomic , assign) CGFloat              pay_price;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * coupon;
@property (nonatomic , copy) NSString              * postinfo;
@property (nonatomic , strong) NSArray <Goods_order_setItem *>              * goods_order_set;
@property (assign, nonatomic) BOOL SelectButton;
@property (nonatomic , copy) NSString              * end_time;

@end

NS_ASSUME_NONNULL_END
