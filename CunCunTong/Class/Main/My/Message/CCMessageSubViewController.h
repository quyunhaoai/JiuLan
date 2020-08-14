//
//  CCMessageSubViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMessageSubViewController : CCBaseTableViewController
- (instancetype)initWithType:(NSInteger )types;
@property (nonatomic,copy) NSString *navTitle;  
@property (nonatomic,assign) NSInteger types;
@end

NS_ASSUME_NONNULL_END
