
//
//  CCChexiaoListModel.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCChexiaoListModel.h"

@implementation CCChexiaoListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ccid": @[@"id", @"ID", @"book_id"]};
}
@end
