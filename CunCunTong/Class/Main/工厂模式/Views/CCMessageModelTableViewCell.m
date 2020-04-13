
//
//  CCMessageModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMessageModelTableViewCell.h"

@implementation CCMessageModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.lookDetailBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 142.f;
}
@end
