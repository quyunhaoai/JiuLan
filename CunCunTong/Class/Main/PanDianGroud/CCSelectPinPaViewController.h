//
//  CCSelectPinPaViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCSelectPinPaViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *selename;  // 
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,NSInteger ID);
@end

NS_ASSUME_NONNULL_END
