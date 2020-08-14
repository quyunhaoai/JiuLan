//
//  CCOutTimeSelectDateViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/8/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCTimeSelectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCOutTimeSelectDateViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *selename;
@property (nonatomic,copy) NSString *sku_id;  //
@property (nonatomic,copy) NSString *types;  //
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,CCTimeSelectModel *timeModel);
@end

NS_ASSUME_NONNULL_END
