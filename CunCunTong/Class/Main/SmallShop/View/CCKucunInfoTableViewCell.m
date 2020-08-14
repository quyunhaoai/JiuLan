
//
//  CCKucunInfoTableViewCell.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKucunInfoTableViewCell.h"

@implementation CCKucunInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titlelab.textColor = COLOR_333333;
    self.detailLab.textColor = COLOR_666666;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame{
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width = SCREEN_WIDTH - margin*2;
    [super setFrame:frame];
}
@end
