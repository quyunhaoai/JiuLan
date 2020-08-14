//
//  CCActiveModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCActiveModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic,copy)  NSString *           center_goods_id;
@property (nonatomic,copy) NSString *category_id;  // <#name#>
@end

NS_ASSUME_NONNULL_END
