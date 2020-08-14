//
//  CCGoodsSelectModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCGoodsSelectModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * bar_code;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * retail_unit;
@property (nonatomic , assign) NSInteger              retail_stock;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@end

NS_ASSUME_NONNULL_END
