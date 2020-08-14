//
//  CCCommendityNoQuanCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommendityNoQuanCollectionViewCell.h"
#import "GBTagListView2.h"
@implementation CCCommendityNoQuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.2)];
    self.subLab.textColor = kPriceRedCOLOR;
    self.isZhiYLab.layer.cornerRadius = 2;
    self.isZhiYLab.layer.masksToBounds = YES;

    self.tagContentView.GBbackgroundColor = [UIColor whiteColor];
    self.tagContentView.signalTagColor = krgb(255,95,33);
    self.tagContentView.canTouch = NO;
}
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    self.titleLab.text = _model.goods_name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[CCTools sharedInstance]IsChinese:_model.goods_image]]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
    //46-90
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //46-90 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
    self.subLab.attributedText = attributedString;
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
    if (_model.reduce.count) {
        for (ReduceItem *item in _model.reduce) {//类型：0-满减，1-满折，2-满赠
            if (item.types == 0) {
                
            } else if (item.types == 1){
                
            } else if (item.types == 2){
                
            }
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
