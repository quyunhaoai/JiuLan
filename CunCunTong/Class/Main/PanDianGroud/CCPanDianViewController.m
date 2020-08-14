//
//  CCPanDianViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPanDianViewController.h"
#import "CCSelectTimeView.h"
#import "UISegmentedControl+CCStyle_OC.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "CCDaySales.h"
#import "CCNewAddPanDianViewController.h"
#import "CCPanDianDetailViewController.h"
#import "KKButton.h"
#import "CCPriceShaixuanView.h"
#import "CCPinPaiSelectView.h"
#import "CCShaiXuanAlertView.h"
#import "CCDaySalesTableViewCell.h"
@interface CCPanDianViewController ()<GHDropMenuDelegate,GHDropMenuDataSource,KKCommonDelegate>
@property (assign, nonatomic) NSInteger types;
@property (copy, nonatomic) NSString *status;
@property (nonatomic,copy) NSString *order_num;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *begin_time;
@property (nonatomic,copy) NSString *end_time;

@property (strong, nonatomic) CCShaiXuanAlertView *alert1;
@property (strong, nonatomic) CCShaiXuanAlertView *alert2;
@end

@implementation CCPanDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.types = 0;
    self.status = @"";
    self.order_num = @"";
    self.category_id = @"";
    self.begin_time = @"";
    self.end_time = @"";
    self.page = 0;
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
    [rightBtn sizeToFit];
    [self customNavBarWithtitle:@"盘点" andLeftView:@"" andRightView:@[rightBtn]];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    [self addSegmentedView];
    [self.tableView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(96+NAVIGATION_BAR_HEIGHT);
    }];
    self.baseTableView = self.tableView;
    [self addTableViewRefresh];
    [kNotificationCenter addObserver:self selector:@selector(initData1) name:@"initData" object:nil];
}
- (void)initData1{
    [self.tableView.mj_header beginRefreshing];
}
- (void)rightBtn:(UIButton *)btn {
    CCNewAddPanDianViewController *vc = [CCNewAddPanDianViewController new];
    vc.paindianID = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSegmentedView {
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"周盘" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"月盘" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    segC.layer.masksToBounds = YES;
    segC.layer.cornerRadius = 16;
    segC.layer.borderWidth = 1.0;
    segC.layer.borderColor = kMainColor.CGColor;
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 10);
        make.width.mas_equalTo(182);
        make.height.mas_equalTo(32);
    }];
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    [self setupUI];
    [self initData];
}
- (void)setupUI {
    KKButton *cateBtn = ({
        KKButton *view = [KKButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"全部状态" forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_13];
        [view setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [view setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
        view.tag = 1;
        view.userInteractionEnabled = YES;
        [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    [self.view addSubview:cateBtn];
    [cateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(Window_W/2, 44));
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+42+10);
    }];
    [cateBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    KKButton *cateBtn2 = ({
        KKButton *view = [KKButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"条件筛选" forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_13];
        [view setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [view setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
        view.userInteractionEnabled = YES;
        view.tag = 2;
        [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    [self.view addSubview:cateBtn2];
    [cateBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(Window_W/2);
        make.size.mas_equalTo(CGSizeMake(Window_W/2, 44));
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+42+10);
    }];
    [cateBtn2 layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    self.baseTableView = self.tableView;
}
- (void)requestCateData:(KKButton *)button {
    XYWeakSelf;
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:@[@{@"name":@"全部",@"id":@""},@{@"name":@"完成",@"id":@"1"},@{@"name":@"暂存",@"id":@"0"}]];
    CCShaiXuanAlertView *alert = [[CCShaiXuanAlertView alloc] initWithFrame:self.view.frame inView:self.view];
    alert.hideBlock = ^{
          [button setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
          [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
      };
    CCPinPaiSelectView *view = [[CCPinPaiSelectView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 288)];
    view.dataSoureArray = array;
    view.clickCatedity = ^(NSString * _Nonnull name, NSInteger prodroutId) {
        if ([name isEqualToString:@"全部"]) {
            weakSelf.status = @"";
        } else {
            weakSelf.status = STRING_FROM_INTAGER(prodroutId);
        }
        weakSelf.page = 0;
        [weakSelf.tableView.mj_header beginRefreshing];
        UIButton *button = (UIButton *)[self.view viewWithTag:1];
        [button setTitle:name forState:UIControlStateNormal];
        [button setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
    };
    alert.contentView =view;
    alert.hiddenWhenTapBG = YES;
    alert.type = NKAlertViewTypeTop;
    alert.customY = NAVIGATION_BAR_HEIGHT+44+42+10;
    [alert show];
    weakSelf.alert1 = alert;
}
- (void)addBtnClick:(KKButton *)button {
    if (button.tag == 1) {
        if (self.alert2) {
            [self.alert2 hide];
        }
        if (self.alert1) {
            [self.alert1 removeFromSuperview];
        }
        [button setImage:IMAGE_NAME(@"上箭头") forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [self requestCateData:button];
   
    } else {
        if (self.alert1) {
            [self.alert1 hide];
        }
        if (self.alert2) {
            [self.alert2 removeFromSuperview];
        }
        [button setImage:IMAGE_NAME(@"上箭头") forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];

        CCShaiXuanAlertView *alert = [[CCShaiXuanAlertView alloc] initWithFrame:self.view.frame inView:self.view];
        alert.hideBlock = ^{
            [button setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
            [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        };
        CCPriceShaixuanView *view = [[CCPriceShaixuanView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 224)];
        XYWeakSelf;
        view.productNameAndCodeBlack = ^(NSString * _Nonnull name, NSString * _Nonnull code, NSString * _Nonnull endTime, NSString * _Nonnull catetiyID) {
            weakSelf.order_num = name;
            weakSelf.begin_time = code;
            weakSelf.end_time = endTime;
            weakSelf.category_id = catetiyID;
            weakSelf.page = 0;
            [weakSelf initData];
            [button setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
            [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        };
        alert.contentView =view;
        alert.hiddenWhenTapBG = YES;
        alert.type = NKAlertViewTypeTop;
        alert.customY = NAVIGATION_BAR_HEIGHT +44+42+10;
        [alert show];
        self.alert2 = alert;
    }
    self.baseTableView = self.tableView;
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
                             @"types":@(self.types),
                             @"status":self.status,
                             @"category_id":self.category_id,
                             @"begin_time":self.begin_time,
                             @"end_time":self.end_time,
    };
    NSString *path = @"/app0/marketreckon/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
            if (weakSelf.page) {
                [weakSelf.dataSoureArray addObjectsFromArray:array];
            } else {
                weakSelf.dataSoureArray = array.mutableCopy;
                if (weakSelf.dataSoureArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                }
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView reloadData];
            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

-(void)segCChanged:(UISegmentedControl *)seg{
    NSInteger i = seg.selectedSegmentIndex;
    NSLog(@"切换了状态 %lu",i);
    [self.dataSoureArray removeAllObjects];
    self.page = 0;
    self.types = i;
    [self initData];
}

#pragma mark  -  kkCommonDelegate
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item{
    CCDaySales *model = (CCDaySales *)item;
    if (type) {
        CCNewAddPanDianViewController *vc = [CCNewAddPanDianViewController new];
        vc.paindianID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CCPanDianDetailViewController *vc = [CCPanDianDetailViewController new];
        vc.pandianID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCDaySales modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    [(CCDaySalesTableViewCell *)cell setDelegate:self];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 137;
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

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"initData" object:nil];
}
@end
