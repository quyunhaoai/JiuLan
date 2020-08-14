//
//  NSString+number.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/7/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "NSString+number.h"

@implementation NSString (number)
+ (NSString*)removeFloatAllZeroByString:(NSString *)testNumber {
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.doubleValue)];
    return outNumber;
}

@end
