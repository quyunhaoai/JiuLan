//
//  CCEverDayTeCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCEverDayTeCollectionViewCell.h"

@implementation CCEverDayTeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //Base style for 分割线1
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(10, 1165, 355, 1)];
    style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 0.08;
    [self.contentView addSubview:style];
    [style mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
       self.contentView.layer.cornerRadius =2.0f;
       self.contentView.layer.borderWidth =1.0f;
       self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
       self.contentView.layer.masksToBounds =YES;

       self.layer.shadowColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:0.18f].CGColor;
       self.layer.shadowOffset = CGSizeMake(0,2.0f);
       self.layer.shadowRadius =2.0f;
       self.layer.shadowOpacity =1.0f;
       self.layer.masksToBounds =NO;
    
    self.icon_iamgeView.layer.cornerRadius = 5;
}
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    
    self.titleLab.text = _model.goods_name;
    [self.icon_iamgeView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.now_price);
    //
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"抢购价："];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f] range:NSMakeRange(0, 4)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
    //46-90
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //46-90 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length)];
    [attributedString1 appendAttributedString:attributedString];
    self.subLab.attributedText = attributedString1;
    self.deleteLab.text = [NSString stringWithFormat:@"￥%ld",(long)_model.promote.old_price];
}
@end
