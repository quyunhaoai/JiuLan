//
//  CCOrderSelectViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCOrderSelectViewController : CCBaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *sumlab;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^blackAction)(NSMutableArray *arr);

@end

NS_ASSUME_NONNULL_END
