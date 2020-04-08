
//
//  BottomAlert3ContentView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BottomAlert3ContentView.h"
#import "NKAlertView.h"
#import "CCTextCustomYinhangKaTableViewCell.h"
#import "KKButton.h"
#import "CCAddBlankCarViewController.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlert3ContentView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BottomAlert3ContentView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 43.f;
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
        titleLab.text = @"选择银联卡";
        titleLab.textColor = COLOR_333333;
        titleLab.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 50);
        
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 126);
        [self.tableView registerNib:CCTextCustomYinhangKaTableViewCell.loadNib forCellReuseIdentifier:@"cell12345"];
        
        
        KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"添加银行卡付款" forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setImage:IMAGE_NAME(@"加号") forState:UIControlStateNormal];
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 56, CGRectGetWidth(frame)-44-100, 46);
        [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:19];
        
        UIImageView *icon = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"右箭头灰"];
            view;
        });
        [self addSubview:icon];
        [icon masMakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(rightBtn);
            make.right.mas_equalTo(self).mas_offset(-40);
            make.size.mas_equalTo(CGSizeMake(6, 11));
        }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTextCustomYinhangKaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell12345"];
    return cell;
}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (self.btnClick) {
        self.btnClick();
    }
//    CCAddBlankCarViewController *vc = [CCAddBlankCarViewController new];
//    [[self.superview.superview viewController].navigationController pushViewController:vc animated:YES];
}

@end
