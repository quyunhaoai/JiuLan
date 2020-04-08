//
//  CCMyOrderModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyOrderModelTableViewCell.h"

@implementation CCMyOrderModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    [self.contentbgView setCornerRadius:10.0 withShadow:YES withOpacity:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height {
    return 204;
}
@end
