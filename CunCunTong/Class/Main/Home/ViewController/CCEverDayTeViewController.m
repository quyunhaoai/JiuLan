//
//  CCEverDayTeViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *cellIdentifier = @"CCEverDayTeTableViewCell";
#import "CCEverDayTeViewController.h"
#import "CCEverDayTeTableViewCell.h"
#import "CCShopBottomView.h"
#import "CCServiceMassageView.h"
#import "CCShopCarView.h"
#import "CCSureOrderViewController.h"

#import "CCGoodsDetail.h"
@interface CCEverDayTeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) CCShopBottomView *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;

@end

@implementation CCEverDayTeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    [self setupUI];
    [self addTableViewRefresh];
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    if (self.goods_name.length >0) {
        NSDictionary *params = @{@"limit":@(10),
                                 @"goods_name":self.goods_name,
                                  @"offset":@(self.page*10),
         };
         NSString *path = @"/app0/centergoodslist/";
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
                 if ([next isKindOfClass:[NSNull class]] || next == nil) {
                     [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                 } else {
                     [weakSelf.tableView.mj_footer resetNoMoreData];
                 }
                 [weakSelf.tableView.mj_header endRefreshing];
                 [weakSelf.tableView.mj_footer endRefreshing];
                 [weakSelf.tableView reloadData];
             }else {
                 if (msg.length>0) {
                     [MBManager showBriefAlert:msg];
                 }
             }
         } WithFailurBlock:^(NSError * _Nonnull error) {
             weakSelf.showErrorView = YES;
         }];
    } else {
        NSDictionary *params = @{@"limit":@(10),
                                  @"offset":@(self.page*10),
         };
         NSString *path = @"/app0/listpromotegoods/";
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
                 if ([next isKindOfClass:[NSNull class]] || next == nil) {
                     [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                 } else {
                     [weakSelf.tableView.mj_footer resetNoMoreData];
                 }
                 [weakSelf.tableView.mj_header endRefreshing];
                 [weakSelf.tableView.mj_footer endRefreshing];
                 [weakSelf.tableView reloadData];
             }else {
                 if (msg.length>0) {
                     [MBManager showBriefAlert:msg];
                 }
             }
         } WithFailurBlock:^(NSError * _Nonnull error) {
             weakSelf.showErrorView = YES;
         }];
    }
 
}
- (void)setupUI {
    [self customNavBarWithTitle:self.titleStr];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:CCEverDayTeTableViewCell.loadNib forCellReuseIdentifier:cellIdentifier];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view).mas_offset(-(66+HOME_INDICATOR_HEIGHT));
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(66);
    }];
    self.isOpen = NO;
    XYWeakSelf;
    _bottomView.clickCallBack = ^(NSInteger tag) {
        if (tag ==2) {
            if (!weakSelf.bottomView.isOpen) {
                CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
                weakSelf.bottomView.contentView = customContentView;
                weakSelf.bottomView.hiddenWhenTapBG = YES;
                [weakSelf.bottomView show];
                weakSelf.bottomView.isOpen = YES;
            } else {
                [weakSelf.bottomView hide];
                weakSelf.bottomView.isOpen = NO;
            }
        } else if(tag == 1){
            if (!weakSelf.isOpen) {
                weakSelf.isOpen = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 1.0;
                    weakSelf.massageView.hidden = NO;
                } completion:^(BOOL finished) {
                }];
            } else {
                weakSelf.isOpen = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 0;
                    weakSelf.massageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }
        } else {//去结算
            CCSureOrderViewController *vc = [CCSureOrderViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:self.massageView];
    [self.massageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(13);
        make.bottom.mas_equalTo(self.view).mas_offset(-(56+HOME_INDICATOR_HEIGHT));
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(78);
    }];
    
}
#pragma mark  -  get
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectZero inView:self.view];
    }
    return _bottomView;
}

#pragma mark  -  UITableViewDelegate,UITableViewDataSource

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCEverDayTeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = [CCGoodsDetail modelWithJSON:self.dataSoureArray[indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.f;
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
//    STChildrenViewController *vc = [STChildrenViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
