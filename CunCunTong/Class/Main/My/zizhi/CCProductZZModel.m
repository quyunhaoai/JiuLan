

//
//  CCProductZZModel.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCProductZZModel.h"
@implementation Centergoodsqualifyphoto_setItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end
@implementation CCProductZZModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"centergoodsqualifyphoto_set":[Centergoodsqualifyphoto_setItem class],
    };
}
@end
