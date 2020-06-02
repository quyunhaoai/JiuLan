

//
//  CCOrderListModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderListModel.h"
@implementation Mcarts_setItem
@end


@implementation ResultsItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"mcarts_set":[Mcarts_setItem class],
    };
}
@end

@implementation CCOrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"results":[ResultsItem class],
    };
}
@end
