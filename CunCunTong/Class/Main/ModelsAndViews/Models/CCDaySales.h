//
//  CCDaySales.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCDaySales : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * addman;
@property (nonatomic , copy) NSString              * ccoperator;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              total_retail_price;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , assign) NSInteger              category_id;
@property (nonatomic , assign) NSInteger              market_id;
@property (nonatomic , assign) NSInteger              center_id;
@end

NS_ASSUME_NONNULL_END
