//
//  CCShareOutView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/8/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShareOutView.h"
#import "NKAlertView.h"

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation CCShareOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"图片已保存到本地相册";
        titleLab.textColor = COLOR_333333;
        titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 10, CGRectGetWidth(frame), 40);
        
        // shop_invite_icon
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        imgView.frame = CGRectMake(20,  CGRectGetMaxY(titleLab.frame) + 10, CGRectGetWidth(frame) - 40, CGRectGetHeight(frame) - (CGRectGetMaxY(titleLab.frame) + 10 + 60));
        self.goodsImage = imgView;
        UIView *botVIew = [[UIView alloc] init];
        [self addSubview:botVIew];
        botVIew.frame = CGRectMake(0, CGRectGetHeight(frame) - 50, CGRectGetWidth(frame), 50);
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = kMainColor;
        leftBtn.tag = 11;
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:leftBtn];
        leftBtn.frame = CGRectMake(20, 1, (CGRectGetWidth(frame) - 40) * 1.0, 40);
        leftBtn.layer.masksToBounds = YES;
        leftBtn.layer.cornerRadius = 20;
        self.bottomBtn = leftBtn;
    }
    return self;
}

- (void)botBtnClick:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"去QQ分享"]) {
        [self openQQchat];
    } else {
        [self openWechat];
    }
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}
-(void)openQQchat{
    NSURL * url = [NSURL URLWithString:@"mqq://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [MBManager showBriefAlert:@"您的设备未安装QQ"];
    }
}
-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [MBManager showBriefAlert:@"您的设备未安装微信APP"];
    }
}
@end
