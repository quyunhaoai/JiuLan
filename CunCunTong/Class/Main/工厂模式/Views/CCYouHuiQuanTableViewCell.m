

//
//  CCYouHuiQuanTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCYouHuiQuanTableViewCell.h"

@implementation CCYouHuiQuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(BaseModel *)model {
    
    self.titleLab.text=@"¥ 50";

    self.subTitleLab.text=@"全场通用券";

    self.dateLab.text=@"有效期：2019年12月20日-12月31日";
    
}
- (IBAction)taskBtn:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
@end
