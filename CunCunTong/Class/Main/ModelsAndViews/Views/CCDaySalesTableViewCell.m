//
//  CCDaySalesTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCDaySalesTableViewCell.h"
#import "CCDaySales.h"
@implementation CCDaySalesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.contentSubView setCornerRadius:5 withShadow:YES withOpacity:0.5];
    self.orderNumberLab.textColor       = COLOR_333333;
    self.buyTepyLab.textColor           = COLOR_666666;
    self.buyNumberLab.textColor         = COLOR_666666;
    self.buyPriceLab.textColor          = COLOR_666666;
    self.fillDateLab.textColor          = COLOR_666666;
}
- (void)setModel:(BaseModel *)model {
    CCDaySales *mmm = (CCDaySales *)model;
    self.modelsss = mmm;
    self.orderNumberLab.text =mmm.order_num;
    if (self.isSales) {
        self.buyTepyLab.text =[NSString stringWithFormat:@"销售录入分类：%@",mmm.category];
        self.buyNumberLab.text = [NSString stringWithFormat:@"销售数量：%ld",mmm.count];
        NSString *str =[NSString stringWithFormat:@"销售金额：¥%ld",mmm.total_retail_price];
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
        [textColor addAttribute:NSForegroundColorAttributeName
                          value:krgb(255,69,4)
                          range:[str rangeOfString:[NSString stringWithFormat:@"¥%ld",mmm.total_retail_price]]];
        self.buyPriceLab.attributedText = textColor;
        self.fillDateLab.text =[NSString stringWithFormat:@"录入日期：%@",mmm.date];
    } else {
        self.buyTepyLab.text =[NSString stringWithFormat:@"盘点分类：%@",mmm.category];
        self.buyNumberLab.text = [NSString stringWithFormat:@"盘点数量：%ld",mmm.count];
        NSString *str =[NSString stringWithFormat:@"盘点金额：¥%ld",mmm.total_retail_price];
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
        [textColor addAttribute:NSForegroundColorAttributeName
                          value:krgb(255,69,4)
                          range:[str rangeOfString:[NSString stringWithFormat:@"¥%ld",mmm.total_retail_price]]];
        self.buyPriceLab.attributedText = textColor;
        self.fillDateLab.text =[NSString stringWithFormat:@"盘点日期：%@",mmm.date];
    }

    if (mmm.status) {
        [self.stateBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.stateBtn setBackgroundColor:krgb(255,165,0)];
        [self.stateBtn setUserInteractionEnabled:YES];
        self.zhanCunBtn.hidden = YES;
        self.rightIcon.hidden = YES;
    } else {
        [self.stateBtn setUserInteractionEnabled:NO];
        self.zhanCunBtn.hidden = NO;
        self.rightIcon.hidden = NO;
        [self.stateBtn setBackgroundColor:krgb(204,204,204)];
    }

}
- (void)setModels:(CCDaySales *)models {
    _models= models;
    CCDaySales *mmm = models;
    self.modelsss = mmm;
    self.orderNumberLab.text =mmm.order_num;
    self.buyTepyLab.text =[NSString stringWithFormat:@"销售录入分类：%@",mmm.category];
    self.buyNumberLab.text = [NSString stringWithFormat:@"销售数量：%ld",mmm.count];
    NSString *str =[NSString stringWithFormat:@"销售金额：¥%ld",mmm.total_retail_price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                     value:krgb(255,69,4)
                     range:[str rangeOfString:[NSString stringWithFormat:@"¥%ld",mmm.total_retail_price]]];
    self.buyPriceLab.attributedText = textColor;
    self.fillDateLab.text =[NSString stringWithFormat:@"录入日期：%@",mmm.date];
    if (mmm.status) {
       [self.stateBtn setTitle:@"完成" forState:UIControlStateNormal];
       [self.stateBtn setBackgroundColor:krgb(255,165,0)];
       [self.stateBtn setUserInteractionEnabled:YES];
       self.zhanCunBtn.hidden = YES;
       self.rightIcon.hidden = YES;
    } else {
       [self.stateBtn setUserInteractionEnabled:NO];
       self.zhanCunBtn.hidden = NO;
       self.rightIcon.hidden = NO;
       [self.stateBtn setBackgroundColor:krgb(204,204,204)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
- (IBAction)clickButton:(UIButton *)sender {
    if (sender.tag == 100) {//完成
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
            [self.delegate clickButtonWithType:0 item:self.modelsss];
        }
    } else {//暂存
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
            [self.delegate clickButtonWithType:1 item:self.modelsss];
         }
    }
}




@end
