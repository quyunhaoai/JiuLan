//
//  BaseTableViewCell.m
//  lianxi_3
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 张静. All rights reserved.
//

#import "BaseTableViewCell.h"
@implementation BaseTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView model:(BaseModel *)model indexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([model class]);
    BaseTableViewCell *baseCell = [tableView dequeueReusableCellWithIdentifier:modelName forIndexPath:indexPath];
    [baseCell setModel:model];
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return baseCell;
}
- (void)setModel:(BaseModel *)model {
    NSLog(@"不执行");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
