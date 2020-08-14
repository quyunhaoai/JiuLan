//
//  NSString+number.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/7/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (number)

//去掉小数点之后的0
+ (NSString*)removeFloatAllZeroByString:(NSString *)testNumber;
@end

NS_ASSUME_NONNULL_END
