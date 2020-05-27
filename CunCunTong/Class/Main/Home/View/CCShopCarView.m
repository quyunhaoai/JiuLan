//
//  CCShopCarView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopCarView.h"

//@implementation CCShopCarView

#import "CCShopBottomView.h"
#import "CCShopCarTableViewCell.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "KKButton.h"
@interface CCShopCarView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CCShopCarView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"已优惠30元";
        titleLab.textColor = kMainColor;
        titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 31);
        titleLab.backgroundColor = krgb(232,255,254);
        self.tableView.frame = CGRectMake(0, 71, CGRectGetWidth(frame), CGRectGetHeight(frame) - 71);
        [self.tableView registerNib:CCShopCarTableViewCell.loadNib forCellReuseIdentifier:@"cell12345"];
        KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"清空购物车" forState:UIControlStateNormal];
        [rightBtn setImage:IMAGE_NAME(@"删除图标") forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(Window_W-90, 41, 80, 20);
        [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 121.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell12345"];
    return cell;
}

- (void)botBtnClick:(UIButton *)btn
{
    CCShopBottomView *alertView = (CCShopBottomView *)[self.superview.superview viewWithTag:10000];
    [alertView hide];
}

//@end





@end
