//
//  LWQ_CheXiaoRuKuCell.m
//  CunCunDriverEnd
//
//  Created by aa on 2020/6/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "LWQ_CheXiaoRuKuCell.h"

@implementation LWQ_CheXiaoRuKuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //0
    _nameLabel.textColor=[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    //
    _detailLabel.textColor=[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    _priceLabel.textColor=[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    _countLabel.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    _totPriceLabel.textColor=[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    _ciaoJiLabel.textColor=[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    self.headerImage.layer.cornerRadius = 5;
    self.headerImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setItem:(Child_order_setItem *)item {
    _item = item;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:item.image]];
    self.nameLabel.text=item.goods_name;
    
    self.priceLabel.text=[NSString stringWithFormat:@"￥%ld",item.play_price];
    self.totPriceLabel.text=[NSString stringWithFormat:@"￥%ld",item.total_play_price];
    self.countLabel.text=[NSString stringWithFormat:@"x%ld",item.amount];
    self.totNumberLabel.text=[NSString stringWithFormat:@"共%ld%@",item.amount,item.unit];
    if (_item.specoption_set.count) {
        self.detailLabel.text = [NSString stringWithFormat:@"%@",_item.specoption_set[0]];
    }
}
@end
