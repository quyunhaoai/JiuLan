//
//  CCChexiaoListModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCChexiaoListModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , assign) CGFloat              play_price;
@end

NS_ASSUME_NONNULL_END
