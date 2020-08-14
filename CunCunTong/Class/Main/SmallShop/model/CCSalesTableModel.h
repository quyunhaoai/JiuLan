//
//  CCSalesTableModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Hot_10Item :NSObject
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * goods_name;

@end

@interface CCSalesTableModel : BaseModel
@property (nonatomic , strong) NSArray <Hot_10Item *>              * hot_10;
@property (nonatomic , strong) NSArray <Hot_10Item *>              * unhot_10;
@end

NS_ASSUME_NONNULL_END
