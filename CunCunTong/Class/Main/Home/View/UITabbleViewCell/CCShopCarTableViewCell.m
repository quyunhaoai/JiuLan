//
//  CCShopCarTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopCarTableViewCell.h"

@implementation CCShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 77, 100, 30)];
    numberButton.shakeAnimation = YES;
    numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
    numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
    XYWeakSelf;
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
        NSLog(@"%f",number);
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(clickPPNumberWithItem:isAdd:indexPaht:ppnumberButton:)]) {
            [weakSelf.delegate clickPPNumberWithItem:weakSelf.Model isAdd:increaseStatus indexPaht:weakSelf.path ppnumberButton:weakSelf.ppButton];
        }
    };
    self.ppButton = numberButton;
    [self.contentView addSubview:numberButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CCShopCarListModel *)Model {
    _Model = Model;
    self.titleLab.text = _Model.goods_name;
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *str in _Model.specoption_set) {
        [string appendString:str];
    }
    self.gugeLab.text = string;
    self.kucunLab.text = [NSString stringWithFormat:@"%ld件",(long)_Model.stock];
    NSString *price =[NSString stringWithFormat:@"￥%@",_Model.total_play_price];
//    //189-00
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥189.00"];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.395f] range:NSMakeRange(0, 4)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];
//
//    //189-00 text-style1
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.395f] range:NSMakeRange(4, 12)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0f/255.0f green:103.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(4, 12)];
//    //219-00
//    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@"¥219.00"];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 8)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 8)];
    
    self.pricelab.text = price;
    
    
    self.ppButton.currentNumber = _Model.count;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_Model.image] placeholderImage:IMAGE_NAME(@"")];
}
//0
//NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"七色堇面包0蔗糖"];
//[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 9)];
//[attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 9)];
@end
