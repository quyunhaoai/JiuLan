


//
//  CCConPlainListMOdel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCConPlainListMOdel.h"

@implementation Child_order_setItem
@end

@implementation CCConPlainListMOdel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child_order_set":[Child_order_setItem class],
    };
}
@end
