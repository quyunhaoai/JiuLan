//
//  CCTemGoodsModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCTemGoodsModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * bar_code;
@property (nonatomic , copy) NSString              * brand;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              retail_price;
@property (nonatomic , copy) NSString              * play_unit;
@end

NS_ASSUME_NONNULL_END
/**        {
    "id": 19,
    "goods_name": "低钠食用盐",
    "image": "http://qny.chimprove.top/1592534782雪天盐主图70079.png",
    "bar_code": "555555",
    "specoption_set": [],
    "brand": "苏盐",
    "category": "食品",
    "play_price": 65.0,
    "retail_price": 80.0,
    "play_unit": "箱"
}*/
