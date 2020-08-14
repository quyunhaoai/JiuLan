//
//  CCAddPanDianModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAddPanDianModel.h"
@implementation Batch_setItemBBB

@end

@implementation Child_setItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"batch_set":[Batch_setItemBBB class],
    };
}
@end

@implementation CCAddPanDianModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"],
             @"ccoperator":@"operator",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child_set":[Child_setItem class],
    };
}
@end
