//
//  CCBalance.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBalance : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , copy) NSString              * finish_time;
@property (nonatomic , copy) NSString              * m_total_order;
@property (nonatomic , assign) NSInteger              price;
@property (nonatomic , copy) NSString              * m_back_order;
@property (nonatomic , assign) NSInteger              direct;
@end

NS_ASSUME_NONNULL_END
