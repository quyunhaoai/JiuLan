//
//  CCCheXiaoOrderModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Person_info :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * place1;
@property (nonatomic , copy) NSString              * place2;
@property (nonatomic , copy) NSString              * place3;
@property (nonatomic , copy) NSString              * address;

@end


@interface CartsItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              market_id;
@property (nonatomic , assign) NSInteger              driver_id;
@property (nonatomic , assign) NSInteger              center_sku_id;
@property (nonatomic , assign) NSInteger              total_play_price;
@property (strong, nonatomic) NSArray *specoption_set;   

@end
@interface CCCheXiaoOrderModel : BaseModel
@property (nonatomic , strong) Person_info              * person_info;
@property (nonatomic , assign) CGFloat              total_price;
@property (nonatomic , assign) NSInteger              total_count;
@property (nonatomic , strong) NSArray <CartsItem *>              * carts;
@end

NS_ASSUME_NONNULL_END
