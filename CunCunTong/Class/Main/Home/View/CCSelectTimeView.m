//
//  CCSelectTimeView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectTimeView.h"

@implementation CCSelectTimeView


- (void)setupUI {
    UILabel *titleLab = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(51,51,51);
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 1;
        view ;
        
    });
    titleLab.text = @"选择日期";
    [self addSubview:titleLab];
    KKButton *forntBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [forntBtn setBackgroundColor:kWhiteColor];
    [forntBtn.titleLabel setFont:FONT_12];
    [forntBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [forntBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    [forntBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    forntBtn.layer.cornerRadius = 10;
    forntBtn.layer.masksToBounds = YES;
    [self addSubview:forntBtn];
    
    UILabel *titleLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(51,51,51);
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view ;
        
    });
    titleLab2.text = @"至";
    [self addSubview:titleLab2];
    KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:kWhiteColor];
    [backBtn.titleLabel setFont:FONT_12];
    [backBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [backBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    [backBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 10;
    backBtn.layer.masksToBounds = YES;
    [self addSubview:backBtn];
    
    [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(20);
    }];
    [forntBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
    [titleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(forntBtn.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab2.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
        [forntBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}





@end
