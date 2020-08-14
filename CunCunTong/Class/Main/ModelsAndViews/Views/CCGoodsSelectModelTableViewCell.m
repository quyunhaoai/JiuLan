//
//  CCGoodsSelectModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsSelectModelTableViewCell.h"

@implementation CCGoodsSelectModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView setCornerRadius:5.0 withShadow:YES withOpacity:0.5];
    self.goodsGuiGelab.textColor = COLOR_666666;
    self.goodsDanwLab.textColor = COLOR_666666;
    self.goodsNumberlabel.textColor = COLOR_666666;
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BaseModel *)model {
    CCGoodsSelectModel *mmm = (CCGoodsSelectModel *)model;
    self.models = mmm;
    self.goodsTitle.text = mmm.goods_name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:mmm.image] placeholderImage:IMAGE_NAME(@"")];
    if (mmm.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (mmm.specoption_set.count == 1) {
            [string appendString:mmm.specoption_set[0]];
        } else {
            [string appendString:mmm.specoption_set[0]];
            for (NSString *item in mmm.specoption_set) {
                if ([item isEqual:string]) {
                    continue;
                }
                [string appendFormat:@",%@",item];
            }
        }
        self.goodsGuiGelab.text =[NSString stringWithFormat:@"规格：%@",string];
    }
    self.goodsDanwLab.text =[NSString stringWithFormat:@"单位：%@",mmm.retail_unit];
    self.goodsNumberlabel.text =[NSString stringWithFormat:@"库存：%ld",mmm.retail_stock];
}

- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)] ) {
        [self.delegate clickButtonWithType:sender.isSelected item:self.models];
    }
}

+ (CGFloat)height {
    return 133;
}
@end
