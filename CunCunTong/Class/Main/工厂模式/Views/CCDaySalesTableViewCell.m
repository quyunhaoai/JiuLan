//
//  CCDaySalesTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCDaySalesTableViewCell.h"

@implementation CCDaySalesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.contentBgview setCornerRadius:10 withShadow:YES withOpacity:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
@end
