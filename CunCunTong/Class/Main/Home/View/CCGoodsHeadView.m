//
//  CCGoodsHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCGoodsHeadView.h"

@implementation CCGoodsHeadView


- (void)setupUI {
    
    UILabel *titelLab = ({
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
    [self addSubview:titelLab];
    [titelLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(16);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W-20);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *pricelab = ({
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
    [self addSubview:pricelab];
    [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(16);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    UILabel *pricelab2 = ({
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
    [self addSubview:pricelab2];
    [pricelab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pricelab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *kucunLab = ({
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
    [self addSubview:kucunLab];
    [kucunLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(16);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(Window_W*0.3);
        make.height.mas_equalTo(17);
    }];
    
    UIImageView *icon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.image = IMAGE_NAME(@"库存图标");
        view;
    });
    [self addSubview:icon];
    [icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titelLab.mas_bottom).mas_offset(16);
        make.right.mas_equalTo(kucunLab.mas_left).mas_offset(-5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(16);
    }];
}

@end
