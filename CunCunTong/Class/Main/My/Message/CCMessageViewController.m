
//
//  CCMessageViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMessageViewController.h"
#import "ImageTitleButton.h"
#import "CCMessageModel.h"
#import "XYWebWorkViewController.h"
#import "CCOrderDetailViewController.h"
#import "CCWuliuInfoViewController.h"
#import "CCBalanceViewController.h"
#import "CCActiveDivViewController.h"
#import "CCMessageSubViewController.h"
@interface CCMessageViewController ()
@property (nonatomic,assign) NSInteger types;
@property (strong, nonatomic) UIView *oneImageview;
@property (strong, nonatomic) UIView *towImagevvv;
@property (strong, nonatomic) UIView *threeImagevvv;
@property (strong, nonatomic) UIView *fourImagevvv;
@property (strong, nonatomic) UIView *fiveImagevvv;

@end

@implementation CCMessageViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 0;
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_12];
        [btn setTitle:@"全标已读" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 70, 40);
    [self customNavBarWithtitle:@"消息中心" andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(97+NAVIGATION_BAR_HEIGHT);
    }];
    [self setupUI];

    [self addTableViewRefresh];
}
- (void)setupUI {
    NSArray *icon = @[@"订单消息图标",@"物流图标",@"充值图标",@"活动图标 1",@"平台消息图标"];
    NSArray *arr = @[@"订单消息",@"交易物流",@"充值消息",@"热门活动",@"平台消息"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 10)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
//        退换货图标
        NSString *str = [NSString stringWithFormat:@"%@",icon[i]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [button setTag:100+i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [tolAry addObject:button];

    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT+15));
        make.height.equalTo(@64);
    }];
    ImageTitleButton *but = (ImageTitleButton *)[self.view viewWithTag:100];
    UIView *bageView = [[UIView alloc] init];
    [self.view addSubview:bageView];
    [bageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(but.mas_right).mas_offset(-12);
        make.top.mas_equalTo(but.mas_top).mas_offset(3);
    }];
    self.oneImageview = bageView;
    UIView *bageView2 = [[UIView alloc] init];
    [self.view addSubview:bageView2];
    ImageTitleButton *but2 = (ImageTitleButton *)[self.view viewWithTag:101];
    [bageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(but2.mas_right).mas_offset(-12);
        make.top.mas_equalTo(but2.mas_top).mas_offset(3);
    }];
    self.towImagevvv = bageView2;
    UIView *bageView3 = [[UIView alloc] init];
    [self.view addSubview:bageView3];
    ImageTitleButton *but3 = (ImageTitleButton *)[self.view viewWithTag:102];
    [bageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(but3.mas_right).mas_offset(-12);
        make.top.mas_equalTo(but3.mas_top).mas_offset(3);
    }];
    self.threeImagevvv = bageView3;
    UIView *bageView4 = [[UIView alloc] init];
    [self.view addSubview:bageView4];
    ImageTitleButton *but4 = (ImageTitleButton *)[self.view viewWithTag:103];
    [bageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(but4.mas_right).mas_offset(-12);
        make.top.mas_equalTo(but4.mas_top).mas_offset(3);
    }];
    self.fourImagevvv = bageView4;
    UIView *bageView5 = [[UIView alloc] init];
    [self.view addSubview:bageView5];
    ImageTitleButton *but5 = (ImageTitleButton *)[self.view viewWithTag:104];
    [bageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(but5.mas_right).mas_offset(-12);
        make.top.mas_equalTo(but5.mas_top).mas_offset(3);
    }];
    self.fiveImagevvv = bageView5;
    self.baseTableView = self.tableView;
}
- (void)buttonClick:(UIButton *)button {
    NSInteger i = button.tag -100;
    CCMessageSubViewController *vc = [[CCMessageSubViewController alloc] initWithType:i];
    vc.navTitle = button.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initData {
    NSString *path = @"/app0/mordermessage/";
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
    };
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
            weakSelf.page++;
            [weakSelf getMessageCount];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)getMessageCount {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/mordermessagecount/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            [weakSelf.oneImageview showBadgeWithStyle:WBadgeStyleNumber value:[data[@"count0"] intValue]animationType:0];
            [weakSelf.towImagevvv showBadgeWithStyle:WBadgeStyleNumber value:[data[@"count1"] intValue]animationType:0];
            [weakSelf.threeImagevvv showBadgeWithStyle:WBadgeStyleNumber value:[data[@"count2"] intValue]animationType:0];
            [weakSelf.fourImagevvv showBadgeWithStyle:WBadgeStyleNumber value:[data[@"count3"] intValue]animationType:0];
            [weakSelf.fiveImagevvv showBadgeWithStyle:WBadgeStyleNumber value:[data[@"count4"] intValue]animationType:0];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)rightBtAction:(UIButton *)button {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/mordermessagecount/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            weakSelf.page = 0;
            [weakSelf initData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    XYWeakSelf;
    CCMessageModel *model = [CCMessageModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"/app0/mordermessage/%ld/",model.id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (model.types == 0) {//订单详情m_total_order
                    CCOrderDetailViewController *vc = [CCOrderDetailViewController new];
                    vc.orderID = STRING_FROM_INTAGER(model.m_total_order);
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                } else if (model.types == 1){//物流信息m_total_order
                    CCWuliuInfoViewController *vc = [CCWuliuInfoViewController new];
                    vc.OrderID = STRING_FROM_INTAGER(model.m_total_order);
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                } else if (model.types == 2){//充值消息m_total_order
                    CCBalanceViewController *VC = [CCBalanceViewController new];
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                } else if (model.types == 3){//热门活动m_total_order
                    CCActiveDivViewController *vc = [CCActiveDivViewController new];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                } else if (model.types == 4){//平台信息m_total_order
                     
                }
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCMessageModel modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 123;
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
    [self tableViewDidSelect:indexPath];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
