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
    numberButton.tag = 0;
    XYWeakSelf;
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
        NSLog(@"%f",number);
        if (weakSelf.isVC) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(clickPPNumberWithItem:isAdd:indexPaht:ppnumberButton:withSelectButtonState:)] ) {
                [weakSelf.delegate clickPPNumberWithItem:weakSelf.Model isAdd:increaseStatus indexPaht:weakSelf.path ppnumberButton:weakSelf.ppButton withSelectButtonState:weakSelf.selectButton.isSelected];
            }
        } else {
            if (number > weakSelf.Model.stock) {
                ppBtn.currentNumber = weakSelf.Model.stock;
                [MBManager showBriefAlert:@"超出库存"];
            } else {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(clickPPNumberWithItem:isAdd:indexPaht:ppnumberButton:)]) {
                    [weakSelf.delegate clickPPNumberWithItem:weakSelf.Model isAdd:increaseStatus indexPaht:weakSelf.path ppnumberButton:weakSelf.ppButton];
                }
            }
        }
    };
    self.ppButton = numberButton;
    [self.contentView addSubview:numberButton];
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.masksToBounds = YES;
}
- (void)setIsVC:(BOOL)isVC {
    _isVC = isVC;
    if (_isVC) {
        self.ppButton.editing = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickPPNumberWithItem:isAdd:indexPaht:ppnumberButton:)]) {
        [self.delegate clickPPNumberWithItem:self.Model isAdd:sender.isSelected indexPaht:self.path ppnumberButton:nil];
    }
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
    NSString *price =[NSString stringWithFormat:@"￥%@",_Model.play_price];
    self.pricelab.text = price;
    self.ppButton.currentNumber = _Model.count;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_Model.image] placeholderImage:IMAGE_NAME(@"")];
    if (_Model.isSelect) {
        self.selectButton.selected = YES;
    } else {
        self.selectButton.selected = NO;
    }
}

@end
