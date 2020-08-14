//
//  CCTimeSelectViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCTimeSelectViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *selename;
@property (nonatomic,copy) NSString *sku_id;  // 
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,NSInteger ID);
@end

NS_ASSUME_NONNULL_END
