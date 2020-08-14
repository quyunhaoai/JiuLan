//
//  CCTemSelectDateViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCTimeSelectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCTemSelectDateViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *selename;
@property (nonatomic,copy) NSString *sku_id;  //
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,CCTimeSelectModel *timeModel);
@end

NS_ASSUME_NONNULL_END
