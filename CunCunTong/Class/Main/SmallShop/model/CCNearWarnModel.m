
//
//  CCNearWarnModel.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/6/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNearWarnModel.h"
@implementation Spec_id
@end


@implementation Specoption_id
@end


@implementation Specoption_setItem

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Spec_id":[Spec_id class],
             @"Specoption_id":[Specoption_id class],
    };
}
@end

@implementation CCNearWarnModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"specoption_set":[Specoption_setItem class],
    };
}
@end
