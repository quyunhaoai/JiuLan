//
//  CCActiveListMdoel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
#import "CCGoodsDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCActiveListMdoel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_image;
@property (nonatomic , assign) BOOL              selfsupport;
@property (nonatomic , assign) float              play_price;
@property (nonatomic , assign) BOOL              is_new;
@property (nonatomic , strong) Promote              * promote;
@property (strong, nonatomic) NSArray <ReduceItem *>*reduce;
@end

NS_ASSUME_NONNULL_END
