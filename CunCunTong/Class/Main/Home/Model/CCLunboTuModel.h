//
//  CCLunboTuModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/5/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCLunboTuModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              types;
@end

NS_ASSUME_NONNULL_END
