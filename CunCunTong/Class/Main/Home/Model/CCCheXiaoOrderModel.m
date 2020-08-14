
//
//  CCCheXiaoOrderModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCheXiaoOrderModel.h"
@implementation Person_info
@end


@implementation CartsItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}

@end

@implementation CCCheXiaoOrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"carts":[CartsItem class],
             @"person_info":[Person_info class],
    };
}
@end
