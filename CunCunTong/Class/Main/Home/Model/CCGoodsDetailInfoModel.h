//
//  CCGoodsDetailInfoModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/5/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
#import "CCGoodsDetail.h"
#import "GHDropMenuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Spec_setItem :NSObject
@property (nonatomic , assign) NSInteger              spec_id;
@property (nonatomic , copy) NSString              * spec_name;
@property (nonatomic , strong) NSArray <ChildrenItem *>              * children;

@end


@interface Arguments_setItem :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * value;

@end


@interface Sku_promote :NSObject
@property (nonatomic , assign) NSInteger              limit;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              limit_stock;
@property (nonatomic , assign) CGFloat              old_price;
@property (nonatomic , assign) CGFloat              now_price;
@property (nonatomic , assign) NSInteger              full;
@property (nonatomic , assign) NSInteger              give;
@end

@interface Grid_play_priceItem :NSObject
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              down_limit;
@property (nonatomic , assign) NSInteger              up_limit;

@end

@interface Sku_setItem :NSObject
@property (nonatomic , assign) NSInteger              sku_id;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , assign) BOOL              is_grid_play_price;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , strong) Sku_promote              * sku_promote;
@property (nonatomic , strong) NSArray <NSNumber *>     * specoption_id_set;
@property (nonatomic,copy) NSString                     *specoption_str;
@property (nonatomic , copy) NSString                   * unit;
@property (nonatomic , strong) NSArray <Grid_play_priceItem *>              * grid_play_price;
@end


@interface Address :NSObject
@property (nonatomic , copy) NSString              * place1;
@property (nonatomic , copy) NSString              * place2;
@property (nonatomic , copy) NSString              * place3;
@property (nonatomic , copy) NSString              * address;

@end


@interface Coupon_setItem :NSObject
@property (assign, nonatomic) NSInteger cut;
@property (assign, nonatomic) NSInteger types;
@property (nonatomic,copy) NSString *discount;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * begin_time;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) BOOL              use_selfimage;
@property (nonatomic , copy) NSString              * selfimage;

@end
@interface CCGoodsDetailInfoModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , assign) CGFloat                play_price;
@property (nonatomic , assign) CGFloat                retail_price;
@property (nonatomic , assign) NSInteger              sales;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , strong) NSArray <NSString *>              * goodsimage_set;
@property (nonatomic , strong) Promote              * promote;
@property (nonatomic , strong) NSArray <NSString *>              * reduce;
@property (nonatomic , strong) NSArray <Spec_setItem *>              * spec_set;
@property (nonatomic , strong) NSArray <Arguments_setItem *>              * arguments_set;
@property (nonatomic , strong) NSArray <NSString *>              * detailimage_set;
@property (nonatomic , strong) NSArray <Sku_setItem *>              * sku_set;
@property (nonatomic , strong) Address              *address;
@property (nonatomic , strong) NSArray <Coupon_setItem *>              * coupon_set;
@end

NS_ASSUME_NONNULL_END
