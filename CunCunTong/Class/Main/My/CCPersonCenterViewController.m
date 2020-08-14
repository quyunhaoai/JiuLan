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
#import "AppDelegate.h"
#import "CCBaseNavController.h"
#import "CCPersonCenterModel.h"
#import "CCAboutViewController.h"
#import "CCTemListViewController.h"
#import "WSLPictureBrowseView.h"
#import "CCNeedUpListViewController.h"
@interface CCPersonCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
       WSLPictureBrowseView *background;
}
@property (strong,nonatomic)CCPersonHeaderView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *iconArray;
@property (strong, nonatomic) NSArray *controllerArray;
@property (strong, nonatomic) CCPersonCenterModel *model;
@property (nonatomic,strong) UIButton *messageBtn;
@property (strong, nonatomic) UIView *bageView;


@end

@implementation CCPersonCenterViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    UIView *bageView = [[UIView alloc] init];
    [self.navTitleView addSubview:bageView];
    [bageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.messageBtn.mas_top).mas_offset(3);
    }];
    self.bageView = bageView;
    [kNotificationCenter addObserver:self selector:@selector(initData2) name:@"personCenter" object:nil];
}
- (void)initData2 {
    [_headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:[kUserDefaults objectForKey:headPhots]]
                               placeholderImage:IMAGE_NAME(@"村村仓logo无底色")];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/homeordercount/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCPersonCenterModel modelWithJSON:data];
            [weakSelf.bageView showBadgeWithStyle:WBadgeStyleNumber
                                            value:weakSelf.model.message_count
                                    animationType:0];
            [weakSelf.headerView.oneImageview showBadgeWithStyle:WBadgeStyleNumber
                                                           value:weakSelf.model.order_count.count0
                                                   animationType:0];
            [weakSelf.headerView.towImagevvv showBadgeWithStyle:WBadgeStyleNumber
                                                          value:weakSelf.model.order_count.count1
                                                  animationType:0];
            [weakSelf.headerView.threeImagevvv showBadgeWithStyle:WBadgeStyleNumber
                                                            value:weakSelf.model.order_count.count2
                                                    animationType:0];
            [weakSelf.headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:weakSelf.model.head_photo]
                                               placeholderImage:IMAGE_NAME(@"村村仓logo无底色")];
            [weakSelf.headerView.nameStrLab setText:[kUserDefaults objectForKey:name]];
            [kUserDefaults setObject:weakSelf.model.head_photo forKey:headPhots];
            [weakSelf.tableView reloadData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
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
    [self.tableView registerNib:[UINib nibWithNibName:CCPersonCenterTableViewCell.className
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:CellIdentifier];
    XYWeakSelf;
    [self.headerView.headerImage addTapGestureWithBlock:^(UIView *gestureView) {
        NSString *url = [kUserDefaults objectForKey:headPhots];
        if ([url isNotBlank]) {
            [weakSelf cleckImageViewAction:url];
        }
    }];
    [self.headerView.moreButtonView addTapGestureWithBlock:^(UIView *gestureView) {//查看 更多
        CCMyOrderViewController *vc = [CCMyOrderViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.headerView.click = ^(NSInteger tag) {
        CCMyOrderViewController *vc = [CCMyOrderViewController new];
        if (tag == 4) {
            vc.type = 1;
        } else {
            vc.selectIndex = tag+1;
        }
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    UIButton *rightBtn = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"消息图标-1") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 1;
         [btn addTarget:self action:@selector(rightBtAction:)
       forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn.frame = CGRectMake(0, 0, 25, 25);
    weakSelf.messageBtn = rightBtn;
    UIButton *rightBtn2 = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"设置图标") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 2;
         [btn addTarget:self action:@selector(rightBtAction:)
       forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn2.frame = CGRectMake(0, 0, 25, 25);
    [self customNavBarWithtitle:@"" andLeftView:@"" andRightView:@[rightBtn2,rightBtn]];
    self.navTitleView.backgroundColor = kClearColor;
    self.navTitleView.splitView.backgroundColor = kClearColor;
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
}

- (void)cleckImageViewAction:(NSString *)url{
    WSLPictureBrowseView * browseView = [[WSLPictureBrowseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    browseView.backgroundColor = [UIColor blackColor];
    browseView.viewController = self;
    browseView.urlArray = @[url].mutableCopy;
    background = browseView;
    [kKeyWindow addSubview:browseView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [background addGestureRecognizer:tapGesture];
    [self shakeToShow:browseView];
}
-(void)closeView{
    [background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
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
                       @"营业资质图标",
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
                        @"营业资质",
                        @"日销售录入",
                        @"快递分润",
                        @"预警提醒",
                        @"需求上报",
                        @"投诉中心",
                        @"临期优惠申请",
                        @"收货地址",
                        @"退出登录",
        ];
    }
    return _titleArray;
}

- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[@"CCBalanceViewController",
                             @"CCBusinessZiZhiViewController",
                             @"CCDaySalesViewController",
                             @"快递分润",
                             @"CCWarningReminderViewController",
                             @"CCNeedUpListViewController",
                             @"CCComplaintListTableViewController",
                             @"CCTemListViewController",
                             @"CCMyAddressViewController",
                             @"退出登录",
        ];
    }
    return _controllerArray;
}

- (CCPersonHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CCPersonHeaderView alloc] init];
        [_headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:[kUserDefaults objectForKey:headPhots]] placeholderImage:IMAGE_NAME(@"村村仓logo无底色")];
        _headerView.nameStrLab.text = [kUserDefaults objectForKey:name];
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
    if (indexPath.row == 4) {
        [cell.titleLab showNumberBadgeWithValue:self.model.warn_count];
        cell.titleLab.badgeCenterOffset = CGPointMake(-30, 0);
    } else if (indexPath.row == 0){
        cell.subTitlelab.text = [NSString stringWithFormat:@"￥%ld",self.model.balance];
        cell.subTitlelab.textColor = krgb(255,69,4);
    }
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
    NSString *str =self.controllerArray[indexPath.row];
    if ([str isEqualToString:@"退出登录"]) {
        [kUserDefaults removeObjectForKey:centerID];
        [kUserDefaults removeObjectForKey:marketID];
        [kUserDefaults removeObjectForKey:token];
        [kUserDefaults removeObjectForKey:name];
        [kUserDefaults removeObjectForKey:headPhots];
        [kUserDefaults removeObjectForKey:isOK];
        [kUserDefaults synchronize];
        [self unLogin];
        CCLoginRViewController *vc = [[CCLoginRViewController alloc] init];
        [AppDelegate sharedAppDelegate].window.rootViewController = [[CCBaseNavController alloc] initWithRootViewController:vc];
    } else if ([str isEqualToString:@"快递分润"]){
        [MBManager showBriefAlert:@"功能开发中"];
    } else {
        CCBaseViewController *vc = [NSClassFromString(self.controllerArray[indexPath.row]) new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)unLogin {
    NSDictionary *params = @{@"plat":@(0),
    };
    NSString *path = @"/app0/unlogin/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
//        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            
        }else {
//            if (msg.length>0) {
//                [MBManager showBriefAlert:msg];
//            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

-(void)dealloc {
    [kNotificationCenter removeObserver:self name:@"personCenter" object:nil];
}














@end
