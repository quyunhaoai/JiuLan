
//
//  CCSalesTableModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSalesTableModel.h"
@implementation Hot_10Item

@end

@implementation CCSalesTableModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
//}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hot_10":[Hot_10Item class],
             @"unhot_10":[Hot_10Item class],
    };
}
@end
