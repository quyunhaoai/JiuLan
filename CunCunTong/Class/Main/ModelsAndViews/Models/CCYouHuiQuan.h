//
//  CCYouHuiQuan.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCYouHuiQuan : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * begin_time;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) BOOL              use_selfimage;
@property (nonatomic , copy) NSString              * cut;
@property (nonatomic , assign) BOOL              is_had;
@property (nonatomic,copy) NSString *selfimage;
@property (nonatomic,copy) NSString *discount;  
@end

NS_ASSUME_NONNULL_END
