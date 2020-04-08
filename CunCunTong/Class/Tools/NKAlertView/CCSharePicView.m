//
//  CCSharePicView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "CCSharePicView.h"
#import "NKAlertView.h"
@implementation CCSharePicView


- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;

    // shop_invite_icon
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"详情页图片"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self addSubview:imgView];
    imgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - (65));
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = @"Restaurant";
    titleLab.textColor = COLOR_333333;
    titleLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLab];
    titleLab.frame = CGRectMake(0, CGRectGetHeight(imgView.frame), CGRectGetWidth(self.frame), 15);
    
    UILabel *selectLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:selectLab];
    [selectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(-15);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.tag = 12;
    [rightBtn setImage:IMAGE_NAME(@"下载保存按钮") forState:UIControlStateNormal];
    [rightBtn setTitleColor:NKColorWithRGB(0xFED953) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake((CGRectGetWidth(self.frame) - 37), CGRectGetHeight(self.frame)-35, 22, 19);


}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 11) {
        
    }else
    {
        
    }
}








@end
