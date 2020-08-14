//
//  CCActiveListMdoel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCActiveListMdoel.h"
//@implementation Promote
//@end

@implementation CCActiveListMdoel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"promote":[Promote class],
             @"reduce":[ReduceItem class],
    };
}
@end
