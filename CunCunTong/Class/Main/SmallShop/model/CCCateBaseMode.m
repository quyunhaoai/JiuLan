
//
//  CCCateBaseMode.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCateBaseMode.h"
@implementation ChildItemcccc
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end

@implementation ChildItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child":[ChildItemcccc class],
    };
}
@end

@implementation CCCateBaseMode
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child":[ChildItem class],
    };
}
@end
