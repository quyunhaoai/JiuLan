
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
- (void)setModel:(BaseModel *)model{
    CCMessageModel *mmmm = (CCMessageModel *)model;
    self.titleLab.text = mmmm.title;
    self.subLab.text = mmmm.message;
    self.timeLab.text = mmmm.create_time;
    if (mmmm.readed) {
        [self.bageView clearBadge];
    } else {
        [self.bageView showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:0];
    }
    if (mmmm.image.length>0) {
        self.subLabLeftConstraint.constant = 47;
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:mmmm.image]];
        self.goodsImageView.hidden = NO;
    } else {
        self.subLabLeftConstraint.constant = 10;
        self.goodsImageView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 142.f;
}
@end
