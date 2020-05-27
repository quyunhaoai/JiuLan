//
//  CCOrderDetailFooterView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailFooterView.h"
#import "KKButton.h"
@implementation CCOrderDetailFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}       229+36
*/
- (void)setupUI {
    self.backgroundColor = kWhiteColor;
    KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 11;
    [rightBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 25));
        make.centerX.mas_equalTo(self).mas_offset(0);
    }];
    [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(rightBtn.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_13;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"商品金额：";
        view ;
    });
    [self addSubview:titleLab];
    [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *titleLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_13;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"优惠：";
        view ;
    });
    [self addSubview:titleLab2];
    [titleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    UILabel *subtitleLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_16;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"¥189.00";
        view ;
    });
    [self addSubview:subtitleLab];
    [subtitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *subtitleLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_16;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"¥0.00";
        view ;
    });
    [self addSubview:subtitleLab2];
    [subtitleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subtitleLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(titleLab2.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *sumTextLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_16;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"合计：";
        view ;
    });
    [self addSubview:sumTextLab];
    [sumTextLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *sumTextLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(253,103,51);
        view.font = STFont(19);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"¥189.00";
        view ;
    });
    [self addSubview:sumTextLab2];
    [sumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];

    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(sumTextLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(10);
    }];
    NSMutableArray *toaArry = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 5; i++) {
        UILabel *TextLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_666666;
            view.font = FONT_13;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view.text = @"下单时间：2019-12-25  18:00";
            view ;
        });
        [self addSubview:TextLab];
        [toaArry addObject:TextLab];
        [TextLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line2.mas_bottom).mas_offset(7+20*i);
            make.left.mas_equalTo(self).mas_offset(10);
            make.width.mas_equalTo(Window_W/2);
            make.height.mas_equalTo(17);
        }];
    }
    
    
    
    
    
    
    
    
    
    
}
- (void)botBtnClick:(UIButton *)button {
    
}
@end
