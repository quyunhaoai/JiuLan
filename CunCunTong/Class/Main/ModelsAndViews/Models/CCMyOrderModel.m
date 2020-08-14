//
//  CCMyOrderModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyOrderModel.h"

@implementation Sku_order_setItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"reduce":[ReduceItem class],
//    };
//}
@end


@implementation Goods_order_setItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sku_order_set":[Sku_order_setItem class],
    };
}
@end

@implementation CCMyOrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_order_set":[Goods_order_setItem class],
    };
}
@end
