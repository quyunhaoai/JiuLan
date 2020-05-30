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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 70, 104, 60, 17)];
    numberButton.shakeAnimation = YES;
    numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
    numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
    
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
        NSLog(@"%f",number);
    };
    
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
    UILabel *numberTitle = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_13;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"购买数量";
        view ;
    });
    [self.contentView addSubview:numberTitle];
    [numberTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
    }];
       UILabel *sumpriceLab = ({
         UILabel *view = [UILabel new];
         view.textColor = COLOR_333333;
         view.font = FONT_13; 
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentRight;
         view.text = @"共2件，小计：";
         view ;
     });
     [self.contentView addSubview:sumpriceLab];
     [sumpriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(numberButton.mas_bottom).mas_offset(10);
         make.right.mas_equalTo(self).mas_offset(-10);
         make.width.mas_equalTo(260);
         make.height.mas_equalTo(17);
     }];
     self.nameLab.text = @"马卡龙网红七色堇精致蛋糕";
     self.priceLab.text = @"¥39.00";
     self.subLab.text = @"口味：芒果味";
     self.numberLab.text = @"x2";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height {
    return 175.f;
}
@end
