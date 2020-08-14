//
//  CCGongHuoListModel.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/6/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCGongHuoListModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) NSInteger              in_price;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              total_in_price;
@property (nonatomic , assign) NSInteger              return_price;
@property (nonatomic , assign) NSInteger              total_retail_price;
@property (nonatomic , assign) NSInteger              profit;
@property (nonatomic , assign) NSInteger              total_play_price;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic,assign) NSInteger                play_price;
@property (nonatomic,assign) NSInteger                retail_price;
@end

NS_ASSUME_NONNULL_END
