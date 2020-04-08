//
//  CCBalanceTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBalanceTableViewCell.h"

@implementation CCBalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.textColor = COLOR_333333;
    self.subtitleLab.textColor = COLOR_999999;
    //UIFont(name: "DIN-Medium", size: 19.0)
    [self.priceLab setFont:[UIFont fontWithName:@"DIN-Medium" size:19]];
    self.priceLab.textColor = COLOR_333333;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height {
    return 58.f;
}
@end
