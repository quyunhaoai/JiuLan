//
//  CCServiceMassageView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCServiceMassageView.h"

@implementation CCServiceMassageView



- (void)setupUI {
    self.layer.cornerRadius = 5;
    self.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];

    KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 11;
    [rightBtn setTitle:@"weixin123456" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"微信图标") forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake(0, 0, 152, 39);
    [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    self.weixinBtn = rightBtn;
    KKButton *telBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    telBtn.tag = 12;
    [telBtn setTitle:@"12345678911" forState:UIControlStateNormal];
    [telBtn setImage:IMAGE_NAME(@"小电话图标") forState:UIControlStateNormal];
    [telBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    telBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [telBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:telBtn];
    telBtn.frame = CGRectMake(0, 39, 152, 39);
    [telBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    self.telBtn = telBtn;
}
- (void)botBtnClick:(UIButton *)button {
    if (button.tag == 12) {
        NSString *telephoneNumber=button.titleLabel.text;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:str];
        [application openURL:URL];
    }

}
@end
