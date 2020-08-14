//
//  CCNearWarnModel.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/6/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
//#import "CCPriceSetListModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface Spec_id :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , assign) BOOL              is_delete;
@property (nonatomic , copy) NSString              * name;

@end


@interface Specoption_id :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , assign) BOOL              is_delete;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              spec_id;

@end

@interface Specoption_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) Spec_id              * spec_id;
@property (nonatomic , strong) Specoption_id         * specoption_id;
@end

@interface CCNearWarnModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic,copy) NSString *retail_unit;  // 
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * brand;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * bar_code;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , assign) NSInteger              in_price;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              retail_price;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              live_time;
@property (nonatomic , copy) NSString              * expire_date;
@property (nonatomic , assign) NSInteger              stock_price;
@property (nonatomic,copy) NSString *play_unit;  // 
@property (nonatomic , strong) NSArray <Specoption_setItem *>              * specoption_set;//specoption_set
@property (nonatomic , strong) NSArray            * goodshouse_set;
@end

NS_ASSUME_NONNULL_END
