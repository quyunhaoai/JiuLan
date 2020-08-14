//
//  CCSureOrderViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCSureOrderHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCSureOrderViewController : CCBaseTableViewController
- (instancetype)initWithTypes:(NSString *)types withmcarts:(NSArray *)mcarts withCenter_sku_id:(NSString *)center_sku_id withCount:(NSString *)count;
@property (strong, nonatomic)  CCSureOrderHeadView *hhhView;
@property (assign, nonatomic) BOOL isCheXiao;




@end

NS_ASSUME_NONNULL_END
