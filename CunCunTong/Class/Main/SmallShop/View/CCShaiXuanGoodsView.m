//
//  CCShaiXuanGoodsView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "CCShopBottomView.h"
#import "CCTextCustomTableViewCell.h"
#import "CCSelectPinPaViewController.h"
#import "CCSelectCatediyViewController.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "CCShaiXuanGoodsView.h"


@interface CCShaiXuanGoodsView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,copy) NSString *catedity1ID;
@property (nonatomic,copy) NSString *catedity3ID;
@property (nonatomic,copy) NSString *catedity2ID;
@property (nonatomic,copy) NSString *pinpaiID;  // <#name#>
@end

@implementation CCShaiXuanGoodsView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - 41);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 11;
        [rightBtn setTitle:@"重置" forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [rightBtn setTitleColor:kMainColor forState:UIControlStateHighlighted];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 23;
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(0, CGRectGetHeight(frame) - 41, CGRectGetWidth(frame)/2, 41);
        
        UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn2.tag = 12;
        [rightBtn2 setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn2 setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [rightBtn2 setTitleColor:kMainColor forState:UIControlStateHighlighted];
        rightBtn2.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn2 addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn2.layer.masksToBounds = YES;
        rightBtn2.layer.cornerRadius = 23;
        [self addSubview:rightBtn2];
        rightBtn2.frame = CGRectMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame) - 41, CGRectGetWidth(frame)/2, 41);
        self.pinpaiID = @"";
        self.catedity1ID = @"";
        self.catedity2ID = @"";
        self.catedity3ID = @"";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = COLOR_333333;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.detailTextLabel.textColor = COLOR_999999;
        cell.detailTextLabel.font = FONT_16;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"商品分类";
        cell.detailTextLabel.text = @"全部类别";
    } else {
        cell.textLabel.text = @"品牌";
        cell.detailTextLabel.text = @"全部品牌";
    }
    UIView *line = [[UIView alloc] init];
    [cell.contentView addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(cell.contentView);
        make.height.mas_equalTo(1);
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XYWeakSelf;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        CCSelectCatediyViewController *vc = [CCSelectCatediyViewController new];
        vc.selectName = cell.detailTextLabel.text;
        vc.clickCatedity = ^(NSString * _Nonnull name, NSString * _Nonnull catedity1ID, NSString * _Nonnull catedity2ID, NSString * _Nonnull catedity3ID) {
            cell.detailTextLabel.text = name;
            weakSelf.catedity1ID = catedity1ID;
            weakSelf.catedity2ID = catedity2ID;
            weakSelf.catedity3ID = catedity3ID;
        };
        [self.superview.viewController.navigationController pushViewController:vc animated:YES];
    } else {
        CCSelectPinPaViewController *vc = [CCSelectPinPaViewController new];
        vc.selename = cell.detailTextLabel.text;
        vc.clickCatedity = ^(NSString * _Nonnull name, NSInteger ID) {
            cell.detailTextLabel.text = name;
            weakSelf.pinpaiID = STRING_FROM_INTAGER(ID);
        };
        [self.superview.viewController.navigationController pushViewController:vc animated:YES];
    }
}
- (void)botBtnClick:(UIButton *)btn
{
    if (btn.tag == 12) {
        if (self.blackID) {
            self.blackID(self.catedity1ID,self.catedity2ID,self.catedity3ID, self.pinpaiID);
        }
        NKAlertView *alertView = (NKAlertView *)self.superview;
        [alertView hide];
    } else {
        self.catedity3ID = @"";
        self.catedity2ID = @"";
        self.catedity1ID = @"";
        self.pinpaiID = @"";
        [self.tableView reloadData];
    }


}

@end
