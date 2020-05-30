//
//  CCEverDayTeTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCEverDayTeTableViewCell.h"

@implementation CCEverDayTeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headImage.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 126.f;
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
    
    //59-00
    NSString *string = [NSString stringWithFormat:@"￥%ld",(long)_model.promote.old_price];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, string.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"¥59.00" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
    [attributedString2 addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)} range:NSMakeRange(0, string.length)];
    self.deletelab.attributedText = attributedString2;
}

@end
