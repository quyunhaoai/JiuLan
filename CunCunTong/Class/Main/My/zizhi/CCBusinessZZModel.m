//
//  CCBusinessZZModel.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/18.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBusinessZZModel.h"
@implementation Supplierqualifyphoto_setItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end
@implementation CCBusinessZZModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"marketqualifyphoto_set":[Supplierqualifyphoto_setItem class],
    };
}
@end
