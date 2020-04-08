//
//  BottomAlertContentView.m
//  NKAlertView
//
//  Created by 聂宽 on 2019/3/20.
//  Copyright © 2019 聂宽. All rights reserved.
//

#import "BottomAlertContentView.h"
#import "NKAlertView.h"
#import "CCTextCustomTableViewCell.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlertContentView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BottomAlertContentView

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
        titleLab.text = @"规格参数";
        titleLab.textColor = COLOR_333333;
        titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 50);
        
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 126);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = krgb(255,157,52);
        rightBtn.tag = 12;
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 23;
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 56, CGRectGetWidth(frame)-20, 46);
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
    CCTextCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1234"];
    cell.titleLab.text = @"UITableViewCell";
    cell.subTitleLab.text = @"UITableViewCell";
    return cell;
}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

@end


