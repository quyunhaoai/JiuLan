
//
//  CCMyGoodsListTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKuCunGoodsListTableViewCell.h"

@implementation CCKuCunGoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.bgView setCornerRadius:5 withShadow:YES withOpacity:0.5];
    self.buyNumber.textColor = krgb(239,122,64);
//    self.inNumberLab.textColor = krgb(239,122,64);
    self.goodsTitle.textColor = krgb(255,15,15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(CCKuCunGoodsList *)model {
//    _model = model;
//    //
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:IMAGE_NAME(@"")];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品类：%@",model.goods_category3]];
//       [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
//       [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
//
//       // text-style1
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, model.goods_category3.length)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, model.goods_category3.length)];
//       self.pinTypeLab.attributedText = attributedString;
//       //
//    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品牌：%@",model.goods_brand]];
//       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
//       [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
//
//       // text-style1
//       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3,  model.goods_brand.length)];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, model.goods_brand.length)];
//       self.pinpaiLab.attributedText = attributedString1;
//    if (model.specoption_set.count) {
//        Specoption_setItem *spe = model.specoption_set[0];
//           //500-ml
//        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",spe.name]];
//           [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
//           [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
//
//           //500-ml text-style1
//        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, spe.name.length)];
//        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, spe.name.length)];
//           self.gugeLab.attributedText = attributedString2;
//    }
//       //80
//    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"供货价：%ld",(long)_model.sales]];
//       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
//       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
//
//       //80 text-style1
//       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.sales].length)];
//    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.sales].length)];
//       self.inPriceLab.attributedText = attributedString3;
//
//       //100
//    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"出货价：%ld",(long)_model.sales_price]];
//       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
//       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
//
//       //100 text-style1
//       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.sales_price].length)];
//    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.sales_price].length)];
//       self.salesPriceLab.attributedText = attributedString4;
//
//       //120
//       NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:@"零售价：120"];
//       [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
//       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
//
//       //120 text-style1
//       [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, 3)];
//       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, 3)];
//       self.jianyilingshouLab.attributedText = attributedString5;
//
//}
- (void)setWarnModel:(CCNearWarnModel *)warnModel {
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
    if (warnModel.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (warnModel.specoption_set.count == 1) {
            Specoption_setItem *spe = warnModel.specoption_set[0];
            [string appendString:spe.name];
        } else {
            Specoption_setItem *spe = warnModel.specoption_set[0];
            [string appendString:spe.name];
            for (Specoption_setItem *item in warnModel.specoption_set) {
                if ([item isEqual:spe]) {
                    continue;
                }
                [string appendFormat:@",%@",item.name];
            }
        }
           //500-ml
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",string]];
           [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
           [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

           //500-ml text-style1
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, string.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, string.length)];
           self.gugeLab.attributedText = attributedString2;
    }
       //80
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",(long)_warnModel.play_price]];
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //80 text-style1
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
       self.inPriceLab.attributedText = attributedString3;
       
       //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"临期单位：%@",_warnModel.play_unit]];
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 5)];
       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];

       //100 text-style1
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_warnModel.play_unit].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_warnModel.play_unit].length)];
       self.jianyilingshouLab.attributedText = attributedString4;
       
       //120
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"零售价：%ld",(long)_warnModel.retail_price]];
       [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //120 text-style1
    [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
       self.salesPriceLab.attributedText = attributedString5;
    self.inNumberLab.text = _warnModel.product_date;
    self.buyNumber.text = _warnModel.expire_date;
    self.kucunNumber3.text = STRING_FROM_INTAGER(_warnModel.stock);
    self.kucunNumber4.text = STRING_FROM_INTAGER(_warnModel.stock_price);
    
}
+ (CGFloat)height {
    return 171;
}
@end
