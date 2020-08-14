
//
//  CCMyGoodsListTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKuCunListTableViewCell.h"

@implementation CCKuCunListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.bgView setCornerRadius:5 withShadow:YES withOpacity:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setWarnModel:(CCMyGoodsList *)warnModel {
    _warnModel = warnModel;
    self.goodsTitle.text = warnModel.goods_name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_warnModel.image] placeholderImage:IMAGE_NAME(@"")];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品类：%@",warnModel.category]];
       [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, warnModel.category.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, warnModel.category.length)];
       self.pinTypeLab.attributedText = attributedString;
       //
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品牌：%@",warnModel.brand]];
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3,  warnModel.brand.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, warnModel.brand.length)];
       self.pinpaiLab.attributedText = attributedString1;
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",(long)_warnModel.play_price]];
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //80 text-style1
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
       self.inPriceLab.attributedText = attributedString3;
       
       //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"建议零售价：%ld",(long)_warnModel.retail_price]];
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 6)];
       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 6)];

       //100 text-style1
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
       self.salesPriceLab.attributedText = attributedString4;

}
- (void)setTemModel:(CCTemGoodsModel *)temModel {
    _temModel = temModel;
    self.goodsTitle.text = _temModel.goods_name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_temModel.image] placeholderImage:IMAGE_NAME(@"")];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品类：%@",_temModel.category]];
       [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, _temModel.category.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, _temModel.category.length)];
       self.pinTypeLab.attributedText = attributedString;
       //
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品牌：%@",_temModel.brand]];
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3,  _temModel.brand.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, _temModel.brand.length)];
       self.pinpaiLab.attributedText = attributedString1;
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",(long)_temModel.play_price]];
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //80 text-style1
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_temModel.play_price].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_temModel.play_price].length)];
       self.inPriceLab.attributedText = attributedString3;
       
       //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"建议零售价：%ld",(long)_temModel.retail_price]];
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 6)];
       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 6)];

       //100 text-style1
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_temModel.retail_price].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_temModel.retail_price].length)];
       self.salesPriceLab.attributedText = attributedString4;
    
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"临期单位：%@",_temModel.play_unit]];
    [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0,5)];
    [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];

       //100 text-style1
    [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_temModel.play_unit].length)];
    [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_temModel.play_unit].length)];
       self.unitLab.attributedText = attributedString5;
}
+ (CGFloat)height {
    return 171;
}
@end
