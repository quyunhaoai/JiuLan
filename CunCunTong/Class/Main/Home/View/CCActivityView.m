//
//  CCActivityView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCActivityView.h"
#import "NKAlertView.h"
@implementation CCActivityView




- (void)setupUI {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304)];
    headView.backgroundColor = kWhiteColor;
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 10;
    [self addSubview:headView];
    UIImageView *imageBgview = ({
        
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"弹窗背景图片1")];
         
        view;
    });
    [headView addSubview:imageBgview];
    [imageBgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(180);
    }];
    UIImageView *imageview = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view;
    });
    [headView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageBgview.mas_centerY);
        make.centerX.mas_equalTo(imageBgview.mas_centerX);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(119);
    }];
    self.activiteImage = imageview;
    UILabel *desLab = ({
        UILabel *view = [UILabel new];
        view.textColor = KKColor(51, 51, 51, 1.0);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view ;
    });
    [headView addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageBgview.mas_bottom).mas_offset(15);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"立即抢购" forState:UIControlStateNormal];
        [view.titleLabel setTextColor:kWhiteColor];
        [view.titleLabel setFont:FONT_14];
        [view setBackgroundImage:IMAGE_NAME(@"弹窗按钮") forState:UIControlStateNormal];
        [view setUserInteractionEnabled:YES];
         [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [headView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(43);
        make.top.mas_equalTo(desLab.mas_bottom).mas_offset(19);
    }];
    
    
    UIButton *closeBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setBackgroundImage:IMAGE_NAME(@"叉号白色") forState:UIControlStateNormal];
        [view setUserInteractionEnabled:YES];
        [view setTag:222];
         [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(28);
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(19);
    }];
}

- (void)commentBtnClick:(UIButton *)button {
    if (button.tag == 222) {
        NKAlertView *vvv =(NKAlertView *)button.superview.superview;
        [vvv hide];
    }
}





@end
