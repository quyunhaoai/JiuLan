//
//  CCOrderDatileModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDatileModel.h"

@implementation CCOrderDatileModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_order_set":[Goods_order_setItem class],
             @"person_info":[Person_info class],
    };
}

@end
