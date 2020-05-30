
//
//  CCMallSubClassCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/5/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMallSubClassCollectionViewCell.h"

@implementation CCMallSubClassCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self initCell];
    }
    return self;
}

- (void)initCell {
    
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 100, 100)];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 5;
    [self.contentView addSubview:self.headImage];
    self.headImage.clipsToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLbel];
    [self.contentView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(21);
        make.bottom.right.mas_equalTo(-10);
    }];
    [self.contentView addSubview:self.lineview];
    [self.contentView addSubview:self.isSelfSupportLab];
    [self.contentView addSubview:self.manjianImage];
    [self.contentView addSubview:self.manjianLab];
    [self.isSelfSupportLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(21, 14));
        make.top.mas_equalTo(_priceLbel.mas_bottom).mas_offset(5);
    }];
    [self.manjianImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.isSelfSupportLab.mas_right).mas_offset(5);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(_priceLbel.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(80 +10);
    }];
    [self.manjianLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.isSelfSupportLab.mas_right).mas_offset(5);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(_priceLbel.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(80 +10);
    }];
}

#pragma mark - getters and setters

-(UIImageView *)manjianImage {
    if (!_manjianImage) {
        _manjianImage =  ({
               UIImageView *view = [UIImageView new];
               view.contentMode = UIViewContentModeScaleToFill ;
               view.layer.masksToBounds = YES ;
               view.userInteractionEnabled = YES ;
               [view setImage:IMAGE_NAME(@"满减边框")];
               view;
           });
    }
    return _manjianImage;
}

- (UILabel *)isSelfSupportLab {
    if (!_isSelfSupportLab) {
        _isSelfSupportLab =({
            UILabel *view = [UILabel new];
            view.textColor = kWhiteColor;
            view.font = STFont(10);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = krgb(255,95,33);
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            view ;
        });
    }
    return _isSelfSupportLab;
}

- (UILabel *)manjianLab {
    if (!_manjianLab) {
        _manjianLab =({
            UILabel *view = [UILabel new];
            view.textColor = krgb(255,98,24);
            view.font = STFont(10);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _manjianLab;
}

- (UIView *)lineview {
    if (!_lineview) {
        _lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 129.5, Window_W, 0.5)];
        [self.contentView addSubview:_lineview];
        _lineview.backgroundColor = COLOR_e5e5e5;
    }
    return _lineview;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.headImage.frame)+10, 18, Window_W-122-12, 15)];
        _titleLabel.textColor = COLOR_333333;
        _titleLabel.font = FONT_14;
        _titleLabel.text = @"--";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)priceLbel {
    if (!_priceLbel) {
        _priceLbel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.titleLabel.frame), 77, Window_W-122-12, 21)];
        _priceLbel.textColor = COLOR_F42415;
        _priceLbel.font = FONT_15;
        _priceLbel.text = @"--";
    }
    return _priceLbel;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setImage:IMAGE_NAME(@"add红色") forState:UIControlStateNormal];
            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _addBtn;
}
- (void)addBtnClick:(UIButton *)button {
    
}

#pragma mark - model
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.goods_image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = model.goods_name;

    NSString *pricestr = _model.promote == nil ? STRING_FROM_INTAGER(_model.play_price):STRING_FROM_INTAGER(_model.promote.now_price);
    NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLbel.attributedText = attributedString;//商品价格

    if (model.reduce.count) {
        if (_model.selfsupport) {
            self.isSelfSupportLab.text = @"自营";
        } else if (_model.is_new) {
            self.isSelfSupportLab.text = @"新品";
        }
        ReduceItem *mmm = _model.reduce[0];
        NSString *string = @"";
        if (mmm.types == 0) {
            string = [NSString stringWithFormat:@" 领券  满%ld减%ld元",mmm.full,mmm.cut];
        } else if (mmm.types == 1){
            string = [NSString stringWithFormat:@" 领券  满%ld打%ld折",mmm.full,mmm.discount];
        } else {
            string = [NSString stringWithFormat:@" 领券  满%ld送%@",mmm.full,mmm.give];
        }
        self.manjianLab.text = string;
        CGFloat width = [string widthForFont:FONT_10];
        [self.manjianImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width +10);
        }];
        [self.manjianLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width +10);
        }];
    } else {
        self.manjianImage.hidden = YES;
        self.manjianLab.hidden = YES;
        self.isSelfSupportLab.hidden = YES;
    }
}

@end
