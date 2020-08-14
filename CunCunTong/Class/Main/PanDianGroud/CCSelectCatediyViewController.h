//
//  CCSelectCatediyViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCSelectCatediyViewController : CCBaseViewController
@property (nonatomic,copy) NSString *selectName;  // 
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,NSString *catedity1ID,NSString *catedity2ID,NSString *catedity3ID);

@end

NS_ASSUME_NONNULL_END
