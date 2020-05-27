//
//  CCGoodsSelectModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsSelectModelTableViewCell.h"

@implementation CCGoodsSelectModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView setCornerRadius:5.0 withShadow:YES withOpacity:0.5];
    self.goodsGuiGelab.textColor = COLOR_666666;
    self.goodsDanwLab.textColor = COLOR_666666;
    self.goodsNumberlabel.textColor = COLOR_666666;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {

    self.goodsTitle.text = @"农夫山泉矿泉水【123456】";
    self.goodsImageView.image = IMAGE_NAME(@"详情页图片");
    self.goodsGuiGelab.text = @"规格：500ml";
    self.goodsDanwLab.text = @"单位：瓶";
    self.goodsNumberlabel.text = @"库存：50";

}
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;

}

+ (CGFloat)height {
    return 133;
}
@end
