//
//  CCOrderListModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Mcarts_setItem :NSObject
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * errmsg;
@property (nonatomic , assign) NSInteger              mcarts_id;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              price;
@property (nonatomic , assign) NSInteger              total_price;
@property (nonatomic , assign) NSInteger              old_price;
@property (nonatomic , assign) NSInteger              total_old_price;

@end
@interface ResultsItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , assign) NSInteger              goods_status;
@property (nonatomic , copy) NSString              * extra_info;
@property (nonatomic , assign) NSInteger              goods_total_price;
@property (nonatomic , assign) NSInteger              goods_total_old_price;
@property (nonatomic , strong) NSArray <Mcarts_setItem *>              * mcarts_set;

@end
@interface CCOrderListModel : BaseModel
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * place1;
@property (nonatomic , copy) NSString              * place2;
@property (nonatomic , copy) NSString              * place3;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , assign) NSInteger              balance;
@property (nonatomic , assign) BOOL              has_coupon;
@property (nonatomic , assign) NSInteger              coupon_id;
@property (nonatomic , copy) NSString              * coupon_info;
@property (nonatomic , strong) NSArray <NSNumber *>              * mcarts_id_list;
@property (nonatomic , assign) NSInteger              order_status;
@property (nonatomic , assign) NSInteger              order_total_price;
@property (nonatomic , assign) NSInteger              order_total_old_price;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              mcarts_count;
@property (nonatomic , strong) NSArray <ResultsItem *>              * results;
@end

NS_ASSUME_NONNULL_END
