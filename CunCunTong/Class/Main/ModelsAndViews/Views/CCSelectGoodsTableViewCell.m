//
//  CCMyOrderModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectGoodsTableViewCell.h"
#import "CCMyOrderModel.h"
@implementation CCSelectGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.salesTimeLab.textColor = COLOR_333333;
    self.numberLabel.textColor = COLOR_999999;
    self.stateLab.textColor = krgb(254,102,50);
    self.contentView.backgroundColor = kWhiteColor;
//    [self.contentbgView setCornerRadius:10.0 withShadow:YES withOpacity:0.5];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5;
    self.imageLeft.constant = 25;
    self.selectBtn.hidden = NO;
}
- (void)setModel:(BaseModel *)model {
    CCMyOrderModel *mymodel = (CCMyOrderModel *)model;
    self.orderNumberLab.text = [NSString stringWithFormat: @"订单号：%@",mymodel.order_num];
//    self.iconImageView sd_setImageWithURL:[NSURL URLWithString:mymodel.] placeholderImage:<#(nullable UIImage *)#>
    self.goodsNameLab.text = @"七色堇面包0蔗糖";
    self.subTypeLab.text = @"芒果味";
    self.stateLab.text = @"待发货";
    self.singePriceLab.text = @"¥189.00";
    self.numberLabel.text = @"×20";
    // 设置字体颜色NSForegroundColorAttributeName，取值为 UIColor对象，默认值为黑色
    NSString *str = @"共20件商品 合计：¥189.00";
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:@"¥189.00"]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:@"¥189.00"]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    self.sumLab.attributedText = textColor;
    self.salesTimeLab.text = @"下单时间：2019-12-25 08:00:00";
    if (mymodel.isSelectView) {
        self.imageLeft.constant = 25;
        self.selectBtn.hidden = NO;
    }
}
- (void)setMainOrderModel:(CCMyOrderModel *)mainOrderModel {
    _mainOrderModel = mainOrderModel;
    
    
}
- (void)setGoodsModel:(Goods_order_setItem *)goodsModel {
    _goodsModel = goodsModel;
    self.goodsNameLab.text = _goodsModel.goods_name;
    if (_mainOrderModel.status >= 1) {
        self.downDateLab.hidden = NO;
        self.downDateLab.font = FONT_12;
        self.downDateLab.textColor = COLOR_666666;
        if (_goodsModel.total_play_price == _goodsModel.total_old_play_price) {
            self.downDateLab.text = [NSString stringWithFormat:@"实付款￥%ld",_goodsModel.total_play_price];
        } else {
            self.downDateLab.text = [NSString stringWithFormat:@"总价￥%ld 优惠￥%ld 实付款￥%ld",_goodsModel.total_old_play_price,_goodsModel.total_old_play_price-_goodsModel.total_play_price,_goodsModel.total_play_price];
        }
    } else {
        self.downDateLab.hidden = YES;
    }
}
- (void)setSkuModel:(Sku_order_setItem *)skuModel {
    _skuModel = skuModel;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[self IsChinese:_skuModel.image]] placeholder:IMAGE_NAME(@"")];
    self.subTypeLab.text = skuModel.specoption;
    self.singePriceLab.text =[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_skuModel.play_price)];
    self.numberLabel.text = [NSString stringWithFormat:@"×%ld",_skuModel.amount];
    self.goodsNameLab.text = _skuModel.goods_name;
    NSString *str = [NSString stringWithFormat:@"共%ld件 合计：¥%ld",_skuModel.amount,(long)_skuModel.total_play_price];
    NSString *Strw = [NSString stringWithFormat:@"¥%ld",(long)_skuModel.total_play_price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    self.sumPriceLab.attributedText = textColor;

}
- (void)setBackgoodsModel:(CCBackOrderListModel *)backgoodsModel {
    _backgoodsModel = backgoodsModel;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[self IsChinese:_backgoodsModel.image]] placeholder:IMAGE_NAME(@"")];
    self.singePriceLab.text =[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_backgoodsModel.play_price)];
    self.numberLabel.text = [NSString stringWithFormat:@"×%ld",_backgoodsModel.amount];
    self.goodsNameLab.text = _backgoodsModel.goods_name;
    NSString *str = [NSString stringWithFormat:@"共%ld件 合计：¥%ld",_backgoodsModel.amount,(long)_backgoodsModel.total_play_price];
    NSString *Strw = [NSString stringWithFormat:@"¥%ld",(long)_backgoodsModel.total_play_price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    self.sumPriceLab.attributedText = textColor;
    if (_backgoodsModel.specoption_set.count) {
        if (_backgoodsModel.specoption_set.count) {
            NSMutableString *string = [[NSMutableString alloc] init];
            if (_backgoodsModel.specoption_set.count == 1) {
                [string appendString:_backgoodsModel.specoption_set[0]];
            } else {
                [string appendString:_backgoodsModel.specoption_set[0]];
                for (NSString *item in _backgoodsModel.specoption_set) {
                    if ([item isEqual:string]) {
                        continue;
                    }
                    [string appendFormat:@",%@",item];
                }
            }
            self.subTypeLab.text = string;
        }
    } else {
        self.subTypeLab.text = @"";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectBtnActon:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:andInView:andCommonCell:)]) {
        [self.delegate clickButtonWithType:0 item:self.skuModel andInView:sender andCommonCell:self.index];
    }
}
//判断是否有中文
- (NSString *)IsChinese:(NSString *)str {
    NSString *newString = str;
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            NSString *oldString = [str substringWithRange:NSMakeRange(i, 1)];
            NSString *string = [oldString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            newString = [newString stringByReplacingOccurrencesOfString:oldString withString:string];
        } else{
            
        }
    }
    return newString;
}
+ (CGFloat)height {
    return 161;
}

@end
