//
//  CCEverDayTeTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCEverDayTeTableViewCell.h"

@implementation CCEverDayTeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headImage.layer.cornerRadius = 5;
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =krgb(255,98,24);
        view.font = STFont(10);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.borderColor = krgb(255,98,24).CGColor;
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
        view.hidden = YES;
        view ;

    });
    [self.contentView addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
    }];
    self.manjianLab = nameLab;
    
    self.tagContentView.GBbackgroundColor = [UIColor whiteColor];
    self.tagContentView.signalTagColor = krgb(255,95,33);
    self.tagContentView.canTouch = NO;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 126.f;
}

#pragma mark - model
- (void)setModel:(CCGoodsDetail *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.goods_image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = model.goods_name;

    NSString *pricestr = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
    if (self.model.promote !=nil && self.model.promote.types == 2) {
         pricestr = STRING_FROM_0_FLOAT(self.model.play_price);
     }
    NSString *price = [NSString stringWithFormat:@""];
    if (self.isTejia) {
        price = [NSString stringWithFormat:@"抢购价:￥%@",pricestr];
        //39-00
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 5)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
        
        //39-00 text-style1
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(5, price.length-5)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(5, price.length-5)];
        self.priceLbel.attributedText = attributedString;//商品价格
    } else {
        price = [NSString stringWithFormat:@"￥%@",pricestr];
        //39-00
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
        
        //39-00 text-style1
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length-1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
        self.priceLbel.attributedText = attributedString;//商品价格
    }


    
    //59-00
    if (model.promote.old_price) {
        NSString *string = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(_model.promote.old_price)];
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, string.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
        [attributedString2 addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)} range:NSMakeRange(0, string.length)];
        self.deletelab.attributedText = attributedString2;
         self.priceBottomConstraint.constant = 10;
        self.deletelab.hidden = NO;
    } else {
        self.priceBottomConstraint.constant = -15;
        self.deletelab.hidden = YES;
    }
    NSMutableArray *arr = [NSMutableArray array];
    if (_model.selfsupport) {
        [arr addObject:@"直营"];
    }
    if (_model.promote != nil) {
        if (_model.promote.types == 0) {
            [arr addObject:@"特价"];
        } else {
            [arr addObject:@"折扣"];
        }
    }
    if (_model.is_recommend) {
        [arr addObject:@"HOT"];
    }
    if (_model.is_new) {
        [arr addObject:@"新品"];
    }
    [self.tagContentView setTagWithTagArray:arr];
}
- (IBAction)addAction:(UIButton *)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        [self.delegate clickButtonWithType:0 item:self.model];
    }
}
- (void)setActiveModel:(CCActiveListMdoel *)activeModel {
    _activeModel = activeModel;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_activeModel.goods_image] placeholderImage:IMAGE_NAME(@"")];
    self.titleLabel.text = _activeModel.goods_name;
    
    NSString *pricestr = _activeModel.promote == nil ? STRING_FROM_0_FLOAT(_activeModel.play_price):STRING_FROM_0_FLOAT(_activeModel.promote.now_price);
    if (self.activeModel.promote !=nil && self.activeModel.promote.types == 2) {
         pricestr = STRING_FROM_0_FLOAT(self.activeModel.play_price);
     }
    NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
    //39-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
    
    //39-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, price.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, price.length-1)];
    self.priceLbel.attributedText = attributedString;//商品价格
    
    if (_activeModel.promote.old_price) {
        NSString *string = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(_activeModel.promote.old_price)];
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, string.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, string.length)];
        [attributedString2 addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)} range:NSMakeRange(0, string.length)];
        self.deletelab.attributedText = attributedString2;
         self.priceBottomConstraint.constant = 10;
    } else {
        self.priceBottomConstraint.constant = -15;
    }
    if (_activeModel.reduce.count) {
        ReduceItem *mmm = _model.reduce[0];
        NSString *string = @"";
        if (mmm.types == 0) {
            string = [NSString stringWithFormat:@"满%ld减%ld元",mmm.full,mmm.cut];
        } else if (mmm.types == 1){
            string = [NSString stringWithFormat:@"满%ld打%ld折",mmm.full,mmm.discount];
        } else {
            string = [NSString stringWithFormat:@"满%ld送%@",mmm.full,mmm.give];
        }
        self.manjianLab.hidden = NO;
        self.manjianLab.text = string;
        CGFloat width = [string widthForFont:FONT_10];
        [self.manjianLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width+5);
        }];
    } else {
        self.manjianLab.hidden = YES;
    }
    
    
}
@end
