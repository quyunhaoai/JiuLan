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
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.2)];
    [[CCTools sharedInstance] addborderToView:self.manJianLab width:0.5 color:krgb(255,95,33)];
    self.manJianLab.layer.cornerRadius = 2;
    
    self.tagContentView.GBbackgroundColor = [UIColor whiteColor];
    self.tagContentView.signalTagColor = krgb(255,95,33);
    self.tagContentView.canTouch = NO;
}

- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    self.titleLab.text = _model.goods_name;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
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
            string = [NSString stringWithFormat:@"满%ld减%ld元",mmm.full,mmm.cut];
        } else if (mmm.types == 1){
            string = [NSString stringWithFormat:@"满%ld打%ld折",mmm.full,mmm.discount];
        } else {
            string = [NSString stringWithFormat:@"满%ld送%@",mmm.full,mmm.give];
        }
        self.manJianLab.text = string;
        CGFloat width = [string widthForFont:FONT_10];
        self.manJianLab.width = width +10;
    } else {
        self.manJianLab.hidden = YES;
        self.manjianBgImage.hidden = YES;
    }
    NSMutableArray *arr = [NSMutableArray array];
    if (_model.selfsupport) {
        [arr addObject:@"直营"];
    }
    if (_model.promote != nil) {
        if (_model.promote.types == 0) {
            [arr addObject:@"特价"];
        } else {
            [arr addObject:@"折扣"];
        }
    }
    if (_model.is_recommend) {
        [arr addObject:@"HOT"];
    }
    if (_model.is_new) {
        [arr addObject:@"新品"];
    }
    [self.tagContentView setTagWithTagArray:arr];
}

@end
