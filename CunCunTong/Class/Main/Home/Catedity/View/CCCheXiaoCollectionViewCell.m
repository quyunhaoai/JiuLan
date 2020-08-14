//
//  CCCheXiaoCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCheXiaoCollectionViewCell.h"

@implementation CCCheXiaoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.headImage.layer.cornerRadius = 5;
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0, 0, 0, 0.2)];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    self.tagContentView.GBbackgroundColor = [UIColor whiteColor];
    self.tagContentView.signalTagColor = krgb(255,95,33);
    self.tagContentView.canTouch = NO;
}
- (IBAction)addAction:(UIButton *)sender {
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(clickButtonWithType:item:)]) {
        if (self.isGoodsType) {
            [self.deleaget clickButtonWithType:0 item:self.model];
        } else {
            [self.deleaget clickButtonWithType:0 item:self.chexiaomodel];
        }
    }
    if (self.deleaget && [self.deleaget respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.deleaget jumpBtnClicked:self.chexiaomodel];
    }
}

#pragma mark - model
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.goods_image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = model.goods_name;

    NSString *pricestr = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
    NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLbel.attributedText = attributedString;//商品价格
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
- (void)setChexiaomodel:(CCChexiaoListModel *)chexiaomodel {
    _chexiaomodel = chexiaomodel;
    self.tagContentView.hidden = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_chexiaomodel.image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = _chexiaomodel.goods_name;

    NSString *pricestr =  STRING_FROM_0_FLOAT(_chexiaomodel.play_price);
    NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLbel.attributedText = attributedString;//商品价格
}
@end
