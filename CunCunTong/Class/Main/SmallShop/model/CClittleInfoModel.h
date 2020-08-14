//
//  CClittleInfoModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CClittleInfoModel : BaseModel
@property (nonatomic , assign) NSInteger              in_count;
@property (nonatomic , assign) NSInteger              in_price;
@property (nonatomic , assign) NSInteger              out_count;
@property (nonatomic , assign) NSInteger              out_price;
@property (nonatomic , assign) NSInteger              now_count;
@property (nonatomic , assign) NSInteger              now_price;
@property (nonatomic , assign) NSInteger              near_count;
@property (assign, nonatomic) NSInteger up_count;    //
@property (assign, nonatomic) NSInteger down_count;    // 
@end

NS_ASSUME_NONNULL_END
/*{
  "in_count": 86,  # 进货数
  "in_price": 84210,  # 进货金额
  "out_count": 0,  # 销售数
  "out_price": 0,  # 销售金额
  "now_count": 68,  # 库存数
  "now_price": 80600,  # 库存金额
  "near_count": 68  # 临期数
}**/
