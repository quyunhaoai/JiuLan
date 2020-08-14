//
//  CCWarningReminderViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWarningReminderViewController : CCBaseTableViewController
@property (assign, nonatomic) NSInteger types;    // 0: 高库存，1：低库存，2：临期
@end

NS_ASSUME_NONNULL_END
