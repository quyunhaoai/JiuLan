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
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.2)];
    self.icon_iamgeView.layer.cornerRadius = 5;
    self.tagContentView.GBbackgroundColor = [UIColor whiteColor];
    self.tagContentView.signalTagColor = krgb(255,95,33);
    self.tagContentView.canTouch = NO;
}
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    
    self.titleLab.text = _model.goods_name;
    [self.icon_iamgeView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image]
                          placeholderImage:IMAGE_NAME(@"")];
     NSString *price = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
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
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(_model.promote.old_price)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
    self.deleteLab.attributedText = attrStr;
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
- (IBAction)goQuanggou:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        [self.delegate clickButtonWithType:0 item:self.model];
    }
}
@end
