//
//  CCNowPayViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/4.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCNowPayViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *m_total_order_id;
@property (assign, nonatomic) BOOL isCheXiao; 
@end

NS_ASSUME_NONNULL_END
