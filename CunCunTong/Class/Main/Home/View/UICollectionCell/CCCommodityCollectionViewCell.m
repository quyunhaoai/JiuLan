//
//  CCCommodityCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommodityCollectionViewCell.h"

@implementation CCCommodityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.1)];
}

- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    self.titleLab.text = _model.goods_name;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.now_price);
    //46-90
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
    //46-90 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
    self.subTitleLab.attributedText = attributedString;
    if (model.reduce.count) {
        ReduceItem *mmm = _model.reduce[0];
        NSString *string = @"";
        if (mmm.types == 0) {
            string = [NSString stringWithFormat:@" 领券  满%ld减%ld元",mmm.full,mmm.cut];
        } else if (mmm.types == 1){
            string = [NSString stringWithFormat:@" 领券  满%ld打%ld折",mmm.full,mmm.discount];
        } else {
            string = [NSString stringWithFormat:@" 领券  满%ld送%@",mmm.full,mmm.give];
        }
        self.manJianLab.text = string;
        CGFloat width = [string widthForFont:FONT_10];
        self.manjianBGWidthConstraint.constant = width+10;
    } else {
        self.manJianLab.hidden = YES;
        self.manjianBgImage.hidden = YES;
    }

}

@end
