//
//  CCGoodsDetail.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "STBaseModel.h"
@interface photoInfo :NSObject
@property (nonatomic , assign) CGFloat              width;
@property (nonatomic , assign) CGFloat              height;
@property (nonatomic , strong) UIImage              *image;
@property (nonatomic,copy) NSString *url;  // 
@end
@interface ReduceItem :NSObject
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              full;
@property (nonatomic , assign) NSInteger              cut;
@property (nonatomic,copy) NSString *give;
@property (nonatomic,assign) NSInteger discount;
@end
NS_ASSUME_NONNULL_BEGIN
@interface Promote :NSObject
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              limit_stock;
@property (nonatomic , assign) CGFloat              now_price;
@property (nonatomic , assign) CGFloat              old_price;

@end
@interface CCGoodsDetail : STBaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_image;
@property (nonatomic , assign) BOOL              selfsupport;//直营
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , assign) BOOL              is_new;//新品
@property (nonatomic , strong) Promote              * promote;
@property (strong, nonatomic) NSArray<ReduceItem *>   *reduce;
@property (nonatomic, assign) NSInteger center_sku_id;//center_sku_id

@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , assign) BOOL              ready;
@property (nonatomic , assign) BOOL              is_model;
@property (nonatomic , copy) NSString              * num;
@property (nonatomic , assign) BOOL              is_delete;
@property (nonatomic , assign) BOOL              is_active;//特价 秒杀 折扣
@property (nonatomic , assign) BOOL              is_closed;
@property (nonatomic , assign) BOOL              is_recommend;//热门
@property (nonatomic , assign) BOOL              is_grid_play_price;
@property (nonatomic , assign) BOOL              same_price;
@property (nonatomic , assign) BOOL              ai_retail_price;
@property (nonatomic , assign) NSInteger              model_centergoods_id;
@property (nonatomic , assign) NSInteger              center_id;
@property (nonatomic , assign) NSInteger              supplier_id;
@property (nonatomic , assign) NSInteger              goods_id;
@end

NS_ASSUME_NONNULL_END
