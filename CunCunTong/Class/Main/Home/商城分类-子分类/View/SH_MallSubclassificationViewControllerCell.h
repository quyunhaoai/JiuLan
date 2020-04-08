//
//  SH_MallSubclassificationViewControllerCell.h
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AKMallSelectModel.h"
//#import "SH_GoodsDetailModel.h"


@interface SH_MallSubclassificationViewControllerCell : UITableViewCell
//@property (nonatomic, strong) AKMallSelectGoodsModel  *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
//@property (nonatomic, strong) SH_GoodsDetailModel  *goodsModel;
@property (nonatomic, strong) UIView *lineview;
@end
