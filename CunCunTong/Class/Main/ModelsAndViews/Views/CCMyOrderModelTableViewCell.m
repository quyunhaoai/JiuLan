//
//  CCMyOrderModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyOrderModelTableViewCell.h"
#import "CCMyOrderModel.h"
@implementation CCMyOrderModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.salesTimeLab.textColor = COLOR_333333;
    self.numberLabel.textColor = COLOR_999999;
    self.stateLab.textColor = krgb(254,102,50);
    [self.contentbgView setCornerRadius:10.0 withShadow:YES withOpacity:0.5];
}
- (void)setModel:(BaseModel *)model {
    CCMyOrderModel *mymodel = (CCMyOrderModel *)model;
    self.orderNumberLab.text = @"订单号：123456789";
    self.iconImageView.image = IMAGE_NAME(@"首页课程图片 2");
    self.goodsNameLab.text = @"七色堇面包0蔗糖";
    self.subTypeLab.text = @"芒果味";
    self.stateLab.text = @"待发货";
    self.singePriceLab.text = @"¥189.00";
    self.numberLabel.text = @"×20";
    // 设置字体颜色NSForegroundColorAttributeName，取值为 UIColor对象，默认值为黑色
    NSString *str = @"共20件商品 合计：¥189.00";
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:@"¥189.00"]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:@"¥189.00"]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    self.sumLab.attributedText = textColor;
    self.salesTimeLab.text = @"下单时间：2019-12-25 08:00:00";
    if (mymodel.isSelectView) {
        self.imageLeft.constant = 25;
        self.selectBtn.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectBtnActon:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

+ (CGFloat)height {
    return 161;
}
@end
