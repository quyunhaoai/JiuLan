
//
//  CCGoodsDetailInfoModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/5/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsDetailInfoModel.h"
//@implementation Promote
//@end
//

//@implementation ChildrenItem
//@end


@implementation Spec_setItem
@end


@implementation Arguments_setItem
@end


@implementation Sku_promote
@end


@implementation Sku_setItem
@end


@implementation Address
@end


@implementation Coupon_setItem
@end
@implementation CCGoodsDetailInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"spec_set":[Spec_setItem class],
             @"arguments_set":[Arguments_setItem class],
             @"sku_set":[Sku_setItem class],
             @"coupon_set":[Coupon_setItem class],
    };
}
@end
