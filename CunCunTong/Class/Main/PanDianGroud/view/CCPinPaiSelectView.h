//
//  CCPinPaiSelectView.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/6/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCPinPaiSelectView : CCBaseView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString *selectName;  // 
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSoureArray;  // <#des#> 
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCatedity)(NSString *name,NSInteger prodroutId);
@end

NS_ASSUME_NONNULL_END
