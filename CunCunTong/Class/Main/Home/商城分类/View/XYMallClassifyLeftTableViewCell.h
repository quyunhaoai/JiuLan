//
//  XYMallClassifyLeftTableViewCell.h
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 商城分类左边的标题cell
 */
@interface XYMallClassifyLeftTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
