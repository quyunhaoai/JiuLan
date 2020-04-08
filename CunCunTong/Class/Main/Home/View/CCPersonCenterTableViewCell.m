//
//  CCPersonCenterTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPersonCenterTableViewCell.h"
@interface CCPersonCenterTableViewCell ()


@end
@implementation CCPersonCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.font = FONT_14;
    self.titleLab.textColor = krgb(51, 51, 51);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
