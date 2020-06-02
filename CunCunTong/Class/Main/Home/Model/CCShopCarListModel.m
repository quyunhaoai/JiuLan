
//
//  CCShopCarListModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopCarListModel.h"

@implementation CCShopCarListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end
