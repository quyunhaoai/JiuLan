//
//  CCShopCarListModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCShopCarListModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , assign) NSInteger              limit;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * play_price;
@property (nonatomic , copy) NSString              * old_price;
@property (nonatomic , copy) NSString              * total_play_price;
@property (nonatomic , assign) NSInteger              center_sku_id;
@end

NS_ASSUME_NONNULL_END
