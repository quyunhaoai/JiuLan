//
//  CCMyGoodsList.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMyGoodsList : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * bar_code;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * brand;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@property (nonatomic , copy) NSString              * play_unit;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , copy) NSString              * retail_unit;
@property (nonatomic , assign) NSInteger              retail_price;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              count_price;
@property (nonatomic,copy) NSString *up_warn;  //
@property (nonatomic,copy) NSString *down_warn;  // 
//@property (nonatomic , assign) NSInteger              id;
//@property (nonatomic , copy) NSString              * goods_name;
//@property (nonatomic , copy) NSString              * image;
//@property (nonatomic , copy) NSString              * bar_code;
//@property (nonatomic , copy) NSString              * category;
//@property (nonatomic , copy) NSString              * brand;
//@property (nonatomic , copy) NSString              * play_unit;
//@property (nonatomic , assign) NSInteger              play_price;
//@property (nonatomic , copy) NSString              * retail_unit;
@property (nonatomic , assign) NSInteger              stock_price;
//@property (nonatomic , assign) NSInteger              retail_price;
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , copy) NSString              * expire_date;
@property (nonatomic , assign) NSInteger              stock;
@end

NS_ASSUME_NONNULL_END
