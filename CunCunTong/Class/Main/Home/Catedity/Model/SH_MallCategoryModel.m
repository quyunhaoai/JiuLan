//
//  MallCategoryModel.m
//  XiYuanPlus
//
//  Created by xy on 2018/4/19.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "SH_MallCategoryModel.h"
@implementation SH_WithDrawalsCategoryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end
@implementation SH_MallCategoryModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children":[SH_WithDrawalsCategoryModel class],
    };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end



