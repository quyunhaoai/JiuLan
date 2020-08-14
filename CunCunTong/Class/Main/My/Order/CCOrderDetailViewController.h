//
//  CCOrderDetailViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDetailViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *orderID;
@property (assign, nonatomic) BOOL ischeXiao; 
@end

NS_ASSUME_NONNULL_END
