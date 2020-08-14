//
//  CCTimeSelectModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCTimeSelectModel : BaseModel
@property (nonatomic , copy) NSString              * product_date;
@property (nonatomic , assign) NSInteger              play_price;

@property (nonatomic , assign) NSInteger              action_price;
@property (nonatomic , assign) NSInteger              diff_price;

@property (nonatomic,copy) NSString *max_count;  // 
@end

NS_ASSUME_NONNULL_END
