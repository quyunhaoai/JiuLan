//
//  CCBackOrderModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBackOrderModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic,copy) NSString *play_unit;  //
@property (nonatomic , assign) NSInteger              count;
@property (strong, nonatomic) NSArray              *specoption_set;
@end

NS_ASSUME_NONNULL_END
