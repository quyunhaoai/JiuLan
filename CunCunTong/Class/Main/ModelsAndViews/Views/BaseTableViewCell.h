//
//  BaseTableViewCell.h
//  lianxi_3
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 张静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface BaseTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView model:(BaseModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)setModel:(BaseModel *)model;

@end
