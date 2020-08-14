//
//  CCTemGoodsSelectViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCTemGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCTemGoodsSelectViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *selectName;  // 
/*
 *   block
 */
@property (copy, nonatomic) void(^clickSelectGoods)(CCTemGoodsModel *model);


@end

NS_ASSUME_NONNULL_END
