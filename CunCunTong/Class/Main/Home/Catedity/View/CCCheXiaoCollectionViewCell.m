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
    self.headImage.layer.cornerRadius = 5;
}
- (IBAction)addAction:(UIButton *)sender {
}

#pragma mark - model
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.goods_image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = model.goods_name;

    NSString *pricestr = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.now_price);
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
