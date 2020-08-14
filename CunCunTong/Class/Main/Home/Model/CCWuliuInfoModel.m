//
//  CCWuliuInfoModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWuliuInfoModel.h"
@implementation From
@end


@implementation To
@end


@implementation CrossItem
@end

@implementation CCWuliuInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"To":[To class],
             @"From":[From class],
             @"cross":[CrossItem class],
    };
}
@end
