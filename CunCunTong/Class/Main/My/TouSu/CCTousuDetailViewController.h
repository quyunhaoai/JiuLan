//
//  CCTousuDetailViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCConPlainListMOdel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCTousuDetailViewController : CCBaseTableViewController
@property (nonatomic,copy) NSString *tagerID;  //
@property (strong, nonatomic) CCConPlainListMOdel *model;



@end

NS_ASSUME_NONNULL_END
