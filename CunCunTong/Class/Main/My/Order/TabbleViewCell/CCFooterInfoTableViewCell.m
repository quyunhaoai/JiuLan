


//
//  CCFooterInfoTableViewCell.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/12.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCFooterInfoTableViewCell.h"
#import "KKButton.h"
@implementation CCFooterInfoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = COLOR_e5e5e5;
    [self addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.numberOfLines = 1;
        view ;
    });
    [self addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(247, 14));
        make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
    }];
    self.sumLab = addressLab;
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });

    [self addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(217, 14));
        make.top.mas_equalTo(addressLab.mas_bottom).mas_offset(10);
    }];
    self.sumPriceLab = mobleNumberLab;

    UIView *line1 = [[UIView alloc] init];
    [self addSubview:line1];
    line1.backgroundColor = COLOR_e5e5e5;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(mobleNumberLab.mas_bottom).mas_offset(10);
    }];
    self.line1View = line1;
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view.titleLabel setTextColor:kWhiteColor];
        [view.titleLabel setFont:FONT_14];
        [view setBackgroundColor:kMainColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
        [view setUserInteractionEnabled:YES];
        view ;
    });
    [self addSubview:sureBtn];
    [sureBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(85);
    }];
    self.sureBtn = sureBtn;
    UIButton *sureBtn2 = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitleColor:kMainColor forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_14];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
        [view setUserInteractionEnabled:YES];
        view ;
    });
    [self addSubview:sureBtn2];
    [sureBtn2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sureBtn.mas_left).mas_offset(-10);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(85);
    }];
    self.sureBtn2 = sureBtn2;
}
- (void)setBackModel:(CCBackOrderListModel *)backModel {
    _backModel = backModel;
    NSString *str = [NSString stringWithFormat:@"共%ld件 合计：¥%@",_backModel.amount,STRING_FROM_0_FLOAT(_backModel.total_play_price)];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_backModel.total_play_price)]]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_backModel.total_play_price)]]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    _sumLab.attributedText = textColor;
    _sumPriceLab.text = [NSString stringWithFormat:@"下单时间：%@",_backModel.create_time];
//    if (_backModel.status == 8) {
//        subtitleLab.hidden = YES;
//        UIButton *sureBtn2 = ({
//            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitle:@"确认收款" forState:UIControlStateNormal];
//            [view setBackgroundColor:kWhiteColor];
//            [view.titleLabel setFont:FONT_14];
//            [view setTitleColor:kMainColor forState:UIControlStateNormal];
//            view.tag = section;
//            [view setUserInteractionEnabled:YES];
//            [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            view.layer.cornerRadius = 5;
//            view.layer.borderWidth = 0.5;
//            view.layer.borderColor = kMainColor.CGColor;
//            view.layer.masksToBounds = YES;
//            view ;
//        });
//        [contentVie addSubview:sureBtn2];
//        [sureBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(85);
//            make.right.mas_equalTo(-15);
//            make.height.mas_equalTo(34);
//            make.bottom.mas_equalTo(contentVie.mas_bottom).mas_offset(-2);
//        }];
//    }else if(model.status == 1 || model.status == 11){
//        subtitleLab.hidden = YES;
//        UIButton *sureBtn2 = ({
//            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitle:@"删除订单" forState:UIControlStateNormal];
//            [view setBackgroundColor:kWhiteColor];
//            [view.titleLabel setFont:FONT_14];
//            [view setTitleColor:kMainColor forState:UIControlStateNormal];
//            view.tag = section;
//            [view setUserInteractionEnabled:YES];
//            [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            view.layer.cornerRadius = 5;
//            view.layer.borderWidth = 0.5;
//            view.layer.borderColor = kMainColor.CGColor;
//            view.layer.masksToBounds = YES;
//            view ;
//        });
//        [contentVie addSubview:sureBtn2];
//        [sureBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(85);
//            make.right.mas_equalTo(-15);
//            make.height.mas_equalTo(34);
//            make.bottom.mas_equalTo(contentVie.mas_bottom).mas_offset(-2);
//        }];
//    }
    
}
- (void)setModel:(CCMyOrderModel *)model {
    _model = model;
    NSString *str = [NSString stringWithFormat:@"共%ld件 合计：¥%@",model.count,STRING_FROM_0_FLOAT(model.total_play_price)];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(model.total_play_price)]]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(model.total_play_price)]]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    _sumLab.attributedText = textColor;
    _sumPriceLab.text = [NSString stringWithFormat:@"下单时间：%@",model.create_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
