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
@property (nonatomic , assign) NSInteger              now_price;
@property (nonatomic , assign) NSInteger              old_price;

@end
@interface CCGoodsDetail : STBaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_image;
@property (nonatomic , assign) BOOL              selfsupport;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) BOOL              is_new;
@property (nonatomic , strong) Promote              * promote;
@property (strong, nonatomic) NSArray<ReduceItem *>   *reduce;   
@end

NS_ASSUME_NONNULL_END
