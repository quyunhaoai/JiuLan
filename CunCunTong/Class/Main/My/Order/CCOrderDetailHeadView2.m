
//
//  CCOrderDetailHeadView2.m
//  CunCunTong
//
//  Created by GOOUC on 2020/8/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailHeadView2.h"

@implementation CCOrderDetailHeadView2
-(void)setupUI {
    UIImageView *imageBgView = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view.backgroundColor = kWhiteColor;
        view;
    });
    
    [self addSubview:imageBgView];
    [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"收货地址图标2")];
        view;
    });
    
    [self addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(17, 24));
        make.top.mas_equalTo(self).mas_offset(23);;
    }];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(17);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    [self addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(50);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    self.nameLab = nameLab;
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 2;
        view ;
    });
    [self addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(50);
        make.size.mas_equalTo(CGSizeMake(247, 34));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
    }];
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_999999;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    
    [self addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(nameLab).mas_offset(0);
    }];
    self.addressLab = addressLab;
    self.numberLab = mobleNumberLab;
    
}


@end
