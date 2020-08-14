
//
//  CCMyGoodsListTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCKuCunWarnGoodsListTableViewCell.h"

@implementation CCKuCunWarnGoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.bgView setCornerRadius:5 withShadow:YES withOpacity:0.5];
    self.buyNumber.textColor = krgb(239,122,64);
    self.inNumberLab.textColor = krgb(239,122,64);
    self.goodsTitle.textColor = krgb(255,15,15);
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
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
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"库存单位：%@",_warnModel.retail_unit]];
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 5)];
       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];

       //80 text-style1
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_warnModel.retail_unit].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_warnModel.retail_unit].length)];
       self.jianyilingshouLab.attributedText = attributedString3;
       
       //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",(long)_warnModel.play_price]];
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //100 text-style1
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_warnModel.play_price].length)];
       self.inPriceLab.attributedText = attributedString4;
       
       //120
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"建议零售价：%ld",(long)_warnModel.retail_price]];
       [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 6)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 6)];

       //120 text-style1
    [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_warnModel.retail_price].length)];
       self.salesPriceLab.attributedText = attributedString5;
    self.inNumberLab.text = STRING_FROM_INTAGER(_warnModel.stock);
    self.buyNumber.text = STRING_FROM_INTAGER(_warnModel.stock_price);
    self.botttomTitleLab.text = @"库存数量";
    self.bottomTitle2Lab.text = @"库存金额";
}

+ (CGFloat)height {
    return 171;
}
@end
