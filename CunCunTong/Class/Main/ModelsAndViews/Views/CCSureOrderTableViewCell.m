//
//  CCSureOrderTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSureOrderTableViewCell.h"

@implementation CCSureOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 70, 104, 60, 17)];
    numberButton.shakeAnimation = YES;
    numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
    numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
    
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
        NSLog(@"%f",number);
    };
    numberButton.userInteractionEnabled = NO;
    self.numberBtn = numberButton;
    [self.contentView addSubview:numberButton];
    
    UILabel *selectLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:selectLab];
    [selectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    UILabel *sumLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:sumLab];
    [sumLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(-35);
        make.right.mas_equalTo(self).mas_offset(110);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *sumPriceLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:sumPriceLab];
    [sumPriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(-35);
        make.right.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(17);
    }];
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 5;
//    UILabel *numberTitle = ({
//        UILabel *view = [UILabel new];
//        view.textColor = COLOR_333333;
//        view.font = FONT_13;
//        view.lineBreakMode = NSLineBreakByTruncatingTail;
//        view.backgroundColor = [UIColor clearColor];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"购买数量";
//        view ;
//    });
//    [self.contentView addSubview:numberTitle];
//    [numberTitle mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_offset(10);
//        make.left.mas_equalTo(self).mas_offset(20);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(17);
//    }];
//       UILabel *sumpriceLab = ({
//         UILabel *view = [UILabel new];
//         view.textColor = COLOR_333333;
//         view.font = FONT_13;
//         view.lineBreakMode = NSLineBreakByTruncatingTail;
//         view.backgroundColor = [UIColor clearColor];
//         view.textAlignment = NSTextAlignmentRight;
//         view.text = @"共2件，小计：";
//         view ;
//     });
//     [self.contentView addSubview:sumpriceLab];
//     [sumpriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
//         make.top.mas_equalTo(numberButton.mas_bottom).mas_offset(10);
//         make.right.mas_equalTo(self).mas_offset(-10);
//         make.width.mas_equalTo(260);
//         make.height.mas_equalTo(17);
//     }];
//     self.nameLab.text = @"马卡龙网红七色堇精致蛋糕";
//     self.priceLab.text = @"¥39.00";
//     self.subLab.text = @"口味：芒果味";
//     self.numberLab.text = @"x2";
    
}
- (void)setModel:(Mcarts_setItem *)model {
    _model = model;
//    self.nameLab.text = @"马卡龙网红七色堇精致蛋糕";
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:IMAGE_NAME(@"")];
    NSString *price =[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_model.price)];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:19.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLab.attributedText = attributedString;
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *str in _model.specoption_set) {
        [string appendString:str];
    }
    self.subLab.text = string;
    self.numberLab.text = [NSString stringWithFormat:@"x%ld",_model.count];
    self.numberBtn.currentNumber = _model.count;
}
- (void)setCarModel:(CartsItem *)carModel {
    _carModel = carModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_carModel.image] placeholderImage:IMAGE_NAME(@"")];
    NSString *price =[NSString stringWithFormat:@"¥%@",STRING_FROM_0_FLOAT(_carModel.play_price)];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:17.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLab.attributedText = attributedString;
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *str in _carModel.specoption_set) {
        [string appendString:str];
    }
    self.subLab.text = string;
    self.numberLab.text = [NSString stringWithFormat:@"x%ld",_carModel.count];
    self.numberBtn.currentNumber = _carModel.count;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//2
//NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"收货地址：河南省 郑州市 二七区 长江路街道             \n长江路与连云路交叉口正商城2号楼 "];
//[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 54)];
//[attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 54)];
+ (CGFloat)height {
    return 97.f;
}
@end
