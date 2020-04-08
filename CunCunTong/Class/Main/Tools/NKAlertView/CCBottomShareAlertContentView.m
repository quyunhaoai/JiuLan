//
//  CCBottomShareAlertContentView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBottomShareAlertContentView.h"
#import "ImageTitleButton.h"

@implementation CCBottomShareAlertContentView


- (void)setupUI {

    self.backgroundColor = kWhiteColor;
    NSArray *arr = @[@"微信",@"朋友圈",@"QQ"];
    NSArray *aaa = @[@"微信logo",@"朋友圈logo",@"QQlogo"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(30, 0, 0, 0) padding:CGSizeMake(0, 50)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(aaa[i]) forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [tolAry addObject:button];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:30 tailSpacing:166];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@66).mas_offset(15);
        make.height.equalTo(@54);
    }];

    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.frame = CGRectMake(0, self.height-54, Window_W, 5);
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = krgb(255,157,52);
    rightBtn.tag = 12;
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = kWhiteColor;
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 49, CGRectGetWidth(self.frame), 49);

}
- (void)botBtnClick:(UIButton *)button {
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

@end
