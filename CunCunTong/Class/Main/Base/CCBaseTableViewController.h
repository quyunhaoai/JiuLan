//
//  CCBaseTableViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"
#import "BaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCBaseTableViewController : CCBaseViewController



@property (nonatomic,strong) UITableView *tableView;


/**
 初始化类

 @param style 表风格类型
 @return 当前类
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;


- (void)tableViewDidSelect:(NSIndexPath *)indexPath;

- (void)addTableViewHeadRefresh;

- (void)addTableViewRefresh;





@end

NS_ASSUME_NONNULL_END
