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
    self.orderNumberLab.textColor       = COLOR_333333;
    self.buyTepyLab.textColor           = COLOR_666666;
    self.buyNumberLab.textColor         = COLOR_666666;
    self.buyPriceLab.textColor          = COLOR_666666;
    self.fillDateLab.textColor          = COLOR_666666;
}
- (void)setModel:(BaseModel *)model {
    
    self.orderNumberLab.text = @"LR2019101001";
    self.buyTepyLab.text = @"销售录入分类：饮品";
    self.buyNumberLab.text = @"销售数量：200";
    NSString *str = @"销售金额：¥56.00";
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(255,69,4)
                      range:[str rangeOfString:@"¥56.00"]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(16)
                      range:[str rangeOfString:@"56.00"]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_12
                      range:[str rangeOfString:@"￥"]];
    self.buyPriceLab.attributedText = textColor;
    self.fillDateLab.text = @"录入日期：2019-10-10";

    [self.stateBtn setTitle:@"完成" forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
@end
