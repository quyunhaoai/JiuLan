//
//  CCPersonCenterViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *CellIdentifier = @"UITableViewCell";
#import "CCPersonCenterViewController.h"
#import "CCPersonHeaderView.h"
#import "CCPersonCenterTableViewCell.h"

#import "CCBalanceViewController.h"
#import "CCLoginRViewController.h"
#import "CCExpressKDFRViewController.h"
#import "CCMyOrderViewController.h"
#import "CCDaySalesViewController.h"
#import "CCWarningReminderViewController.h"
#import "CCMyAddressViewController.h"
#import "CCMyInfoViewController.h"
#import "CCNeedViewController.h"
#import "CCComplaintListTableViewController.h"
#import "CCMessageViewController.h"
#import "CCBaseNavController.h"
@interface CCPersonCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)CCPersonHeaderView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *iconArray;
@property (strong, nonatomic) NSArray *controllerArray;

@end

@implementation CCPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubViews];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)addSubViews {

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    self.headerView.frame = CGRectMake(0, 0, Window_W, 257);
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:CCPersonCenterTableViewCell.className bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    XYWeakSelf;
    [self.headerView.headerImage addTapGestureWithBlock:^(UIView *gestureView) { 
        CCMyInfoViewController *vc = [CCMyInfoViewController new];
        CCBaseNavController *nav = [[CCBaseNavController alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    [self.headerView.moreButtonView addTapGestureWithBlock:^(UIView *gestureView) {//查看 更多
        CCMyOrderViewController *vc = [CCMyOrderViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.headerView.click = ^(NSInteger tag) {
        CCMyOrderViewController *vc = [CCMyOrderViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    UIButton *rightBtn = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"消息图标-1") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 1;
         [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn.frame = CGRectMake(0, 0, 25, 25);
    UIButton *rightBtn2 = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"设置图标") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 2;
         [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn2.frame = CGRectMake(0, 0, 25, 25);
    [self customNavBarWithtitle:@"" andLeftView:@"" andRightView:@[rightBtn2,rightBtn]];
    self.navTitleView.backgroundColor = kClearColor;
    self.navTitleView.splitView.backgroundColor = kClearColor;
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
}

- (void)rightBtAction:(UIButton *)btn {
    if (btn.tag == 1) {
        CCMessageViewController *vc = [CCMessageViewController new];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }else {
        CCMyInfoViewController *vc = [CCMyInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark Get
- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"余额图标",
                       @"销售录入图标",
                       @"快递分润图标",
                       @"预警图标",
                       @"需求图标",
                       @"投诉图标",
                       @"要货图标",
                       @"地址图标",
                       @"退出图标",
        ];
    }
    return _iconArray;
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"账户余额",
                        @"日销售录入",
                        @"快递分润",
                        @"预警提醒",
                        @"需求上报",
                        @"投诉中心",
                        @"一键要货",
                        @"收货地址",
                        @"退出登录",
        ];
    }
    return _titleArray;
}

- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[@"CCBalanceViewController",
                        @"CCDaySalesViewController",
                        @"CCExpressKDFRViewController",
                        @"CCWarningReminderViewController",
                        @"CCNeedViewController",
                        @"CCComplaintListTableViewController",
                        @"一键要货",
                        @"CCMyAddressViewController",
                        @"退出登录",
        ];
    }
    return _controllerArray;
}

- (CCPersonHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CCPersonHeaderView alloc] init];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

- (void)refreshTableViewData {
    [self.tableView.mj_header beginRefreshing];
}

/// 添加下拉刷新
- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kClearColor;
    cell.iconImageVice.image = IMAGE_NAME(self.iconArray[indexPath.row]);
    cell.titleLab.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCBaseViewController *vc = [NSClassFromString(self.controllerArray[indexPath.row]) new];
    [self.navigationController pushViewController:vc animated:YES];
}


















@end
