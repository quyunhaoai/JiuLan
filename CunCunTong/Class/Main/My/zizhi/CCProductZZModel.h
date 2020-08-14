//
//  CCProductZZModel.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Centergoodsqualifyphoto_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              center_goods_qualify_id;

@end
@interface CCProductZZModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * center_goods_name;
@property (nonatomic , strong) NSArray <Centergoodsqualifyphoto_setItem *>              * centergoodsqualifyphoto_set;
@property (nonatomic , assign) NSInteger              check_status;
@property (nonatomic , assign) NSInteger              center_goods_id;
@property (nonatomic , assign) NSInteger              supplier_id;
@end

NS_ASSUME_NONNULL_END
