//
//  CCCommendityNoQuanCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommendityNoQuanCollectionViewCell.h"

@implementation CCCommendityNoQuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.1)];
    self.subLab.textColor = kPriceRedCOLOR;
}
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    self.titleLab.text = _model.goods_name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.old_price);
    //46-90
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //46-90 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
    self.subLab.attributedText = attributedString;
}
//
//NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"活动专区"];
//[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:17.0f] range:NSMakeRange(0, 5)];
//[attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];

@end
