//
//  CCCateBaseMode.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ChildItemcccc :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * name;

@end

@interface ChildItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <ChildItemcccc *>              * child;

@end

@interface CCCateBaseMode : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <ChildItem *>              * child;
@end

NS_ASSUME_NONNULL_END
