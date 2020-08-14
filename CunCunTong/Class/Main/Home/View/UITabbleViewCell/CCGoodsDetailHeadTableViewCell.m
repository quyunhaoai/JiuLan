//
//  CCGoodsDetailHeadTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsDetailHeadTableViewCell.h"

@implementation CCGoodsDetailHeadTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setupUI {
    
    UILabel *titelLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_15;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 0;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self.contentView addSubview:titelLab];
    [titelLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_equalTo(Window_W-20);
        make.height.mas_equalTo(17);
    }];
    self.goodsTitleLab = titelLab;
    UILabel *pricelab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_13;
        view.numberOfLines = 1;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self.contentView addSubview:pricelab];
    [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    self.priceLab = pricelab;
    UILabel *pricelab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_13;
        view.numberOfLines = 1;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self.contentView addSubview:pricelab2];
    [pricelab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pricelab.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    self.priceLab2 = pricelab2;
    UILabel *kucunLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_12;
        view.numberOfLines = 1;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self.contentView addSubview:kucunLab];
    [kucunLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(Window_W*0.3);
        make.height.mas_equalTo(17);
    }];
    self.kuCunLab = kucunLab;
    UIImageView *icon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.image = IMAGE_NAME(@"库存图标");
        view;
    });
    [self.contentView addSubview:icon];
    [icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(kucunLab.mas_left).mas_offset(-5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(16);
    }];
}
@end
