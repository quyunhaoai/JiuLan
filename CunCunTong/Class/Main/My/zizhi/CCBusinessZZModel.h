//
//  CCBusinessZZModel.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/18.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Supplierqualifyphoto_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              market_qualify_id;

@end
@interface CCBusinessZZModel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , strong) NSArray <Supplierqualifyphoto_setItem *>              * marketqualifyphoto_set;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              check_status;
@property (nonatomic , assign) NSInteger              market_id;
@end

NS_ASSUME_NONNULL_END
