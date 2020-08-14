//
//  CCMessageSubViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

//#import "CCMessageSubViewController.h"
//
//@interface CCMessageSubViewController ()
//
//@end
//
//@implementation CCMessageSubViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end

//
//  CCMessageViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMessageSubViewController.h"
#import "ImageTitleButton.h"
#import "CCMessageModel.h"
#import "XYWebWorkViewController.h"
#import "CCOrderDetailViewController.h"
#import "CCWuliuInfoViewController.h"
#import "CCBalanceViewController.h"
#import "CCActiveDivViewController.h"
@interface CCMessageSubViewController ()

@property (strong, nonatomic) UIView *oneImageview;
@property (strong, nonatomic) UIView *towImagevvv;
@property (strong, nonatomic) UIView *threeImagevvv;
@property (strong, nonatomic) UIView *fourImagevvv;
@property (strong, nonatomic) UIView *fiveImagevvv;
@end

@implementation CCMessageSubViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 0;
    [self initData];
}
- (instancetype)initWithType:(NSInteger)types {
    if (self == [super init]) {
        self.types = types;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_14];
        [btn setTitle:@"清空" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 70, 40);
    [self customNavBarWithtitle:self.navTitle andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(10+NAVIGATION_BAR_HEIGHT);
    }];
    self.baseTableView = self.tableView;
    [self addTableViewRefresh];
}

- (void)initData {
    NSString *path = @"/app0/mordermessage/";
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
                             @"types":@(self.types),
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
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)rightBtAction:(UIButton *)button {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = [NSString stringWithFormat:@"/app0/mordermessage/%ld/",self.types];
    [[STHttpResquest sharedManager] requestWithPUTMethod:DELETE
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            [weakSelf.tableView.mj_header beginRefreshing];
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
//    XYWebWorkViewController *web = [XYWebWorkViewController new];
//    web.title = @"快来抽奖";
//    web.urlString = @"https://weibo.com/";
//    [self.navigationController pushViewController:web animated:YES];
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
