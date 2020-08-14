//
//  CCSelectGoodsViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCSelectGoodsViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *catedity;
@property (nonatomic,copy) NSString *paindianID;
@property (assign, nonatomic) BOOL isSales; 
@end

NS_ASSUME_NONNULL_END
