//
//  CCGoodsDetail.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsDetail.h"
@implementation ReduceItem
@end
@implementation Promote
@end

@implementation CCGoodsDetail
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"reduce":[ReduceItem class],
    };
}
@end
