//
//  CCAddPanDianModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Batch_setItemBBB :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic , strong) NSArray <NSNumber *>              * stock_set;
@property (nonatomic , assign) BOOL              can_del;
@property (nonatomic , strong) NSArray <NSNumber *>              * sys_stock_set;

@end
@interface Child_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * bar_code;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * retail_unit;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              center_sku_id;
@property (nonatomic , assign) NSInteger              market_id;
@property (nonatomic , assign) NSInteger              retail_stock;


@property (nonatomic , strong) NSArray <NSString *>              * unit_set;

@property (nonatomic , strong) NSArray <Batch_setItemBBB *>              * batch_set;


@end
@interface CCAddPanDianModel : BaseModel
@property (nonatomic , assign) NSInteger             ccid;
@property (nonatomic , copy) NSString              * addman;
@property (nonatomic , copy) NSString              * ccoperator;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              total_retail_price;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , assign) NSInteger              category_id;
@property (nonatomic , assign) NSInteger              market_id;
@property (nonatomic , assign) NSInteger              center_id;
@property (nonatomic , strong) NSArray <Child_setItem *>              * child_set;
@end

NS_ASSUME_NONNULL_END
