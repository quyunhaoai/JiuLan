//
//  CCLunboTuModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/5/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCLunboTuModel.h"

@implementation CCLunboTuModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}

@end
