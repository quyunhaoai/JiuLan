//
//  CCOrderDetailTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailTableViewCell.h"

@implementation CCOrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.outBtn.layer.cornerRadius = 5;
    self.outBtn.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:157.0f/255.0f blue:52.0f/255.0f alpha:1.0f] CGColor];
    self.outBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 113;;
}
@end
