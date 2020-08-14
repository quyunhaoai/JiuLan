//
//  CCDaySales.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCDaySales.h"

@implementation CCDaySales
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"],
             @"ccoperator":@"operator",
    };
}
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"goods_order_set":[Goods_order_setItem class],
//             @"person_info":[Person_info class],
//    };
//}
@end
