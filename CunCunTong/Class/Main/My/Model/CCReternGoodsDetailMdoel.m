
//
//  CCReternGoodsDetailMdoel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReternGoodsDetailMdoel.h"

@implementation Driver_info
@end

@implementation CCReternGoodsDetailMdoel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"driver_info":[Driver_info class],
             @"batch_set":[Batch_setItem class],
    };
}
@end
