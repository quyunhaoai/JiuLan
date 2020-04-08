
//
//  CCOrderDetailHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailHeadView.h"

@implementation CCOrderDetailHeadView
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
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(addressLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    UIImageView *areaIcon2 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"待收货图标")];
         
        view;
    });
    
    [self addSubview:areaIcon2];
    [areaIcon2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self).mas_offset(-20);;
    }];
    UILabel *nameLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"【村村惠紫云镇赵家村便利店】已签收";
        view ;

    });
    [self addSubview:nameLab2];
    [nameLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(50);
        make.size.mas_equalTo(CGSizeMake(267, 24));
        make.bottom.mas_equalTo(self).mas_offset(-20);
    }];
    UIImageView *areaIcon3 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"右箭头灰")];
         
        view;
    });
    
    [self addSubview:areaIcon3];
    [areaIcon3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 11));
        make.bottom.mas_equalTo(self).mas_offset(-28);;
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);	
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button masMakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.height.mas_equalTo(46);
    }];
}
- (void)buttonClick:(UIButton *)button {
    if (self.ClickBack) {
        self.ClickBack(1);
    }
}
@end
