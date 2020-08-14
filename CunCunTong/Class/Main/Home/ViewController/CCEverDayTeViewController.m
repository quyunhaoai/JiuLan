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
#import "CCGoodsDetailInfoModel.h"
#import "BottomAlert2Contentview.h"
#import "CCCommodDetaildViewController.h"
@interface CCEverDayTeViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>
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
    [kNotificationCenter addObserver:self selector:@selector(requestShopCarData1) name:@"requestShopCarData1" object:nil];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
                 [weakSelf.tableView.mj_header endRefreshing];
                 [weakSelf.tableView.mj_footer endRefreshing];
                 if ([next isKindOfClass:[NSNull class]] || next == nil) {
                     [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                 } else {
                     [weakSelf.tableView.mj_footer resetNoMoreData];
                 }
                 [weakSelf.tableView reloadData];
                 [weakSelf requestShopCarData1];
                 weakSelf.page ++;
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
         NSString *path = [self.titleStr isEqualToString:@"热门推荐"] ? @"/app0/homerecommendgoods/" : @"/app0/listpromotegoods/";
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
                 [weakSelf requestShopCarData1];
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
}

- (void)setupUI {
    [self customNavBarWithTitle:self.titleStr];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:CCEverDayTeTableViewCell.loadNib
         forCellReuseIdentifier:cellIdentifier];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view).mas_offset(-(0+HOME_INDICATOR_HEIGHT));
    }];
    self.baseTableView = self.tableView;
}
- (void)requestService {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/service/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            [weakSelf.massageView.telBtn setTitle:BACKINFO_DIC_2_STRING(data, @"mobile") forState:UIControlStateNormal];
            [weakSelf.massageView.weixinBtn setTitle:BACKINFO_DIC_2_STRING(data, @"wx_num") forState:UIControlStateNormal];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)requestShopCarData1 {
XYWeakSelf;
NSDictionary *params = @{};
NSString *path = @"/app0/mcarts/?limit=10";
[[STHttpResquest sharedManager] requestWithMethod:GET
                                         WithPath:path
                                       WithParams:params
                                 WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
    NSInteger status = [[dic objectForKey:@"errno"] integerValue];
    NSString *msg = [[dic objectForKey:@"errmsg"] description];
    if(status == 0){
        NSDictionary *data = dic[@"data"];
        NSArray *results = data[@"results"];
        [weakSelf.bottomView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
                                                   value:results.count
                                           animationType:WBadgeAnimTypeNone];
        float toal_price = BACKINFO_DIC_2_FLOAT(data, @"total_price");
        NSString *price = [NSString stringWithFormat:@"￥%.2f",toal_price];
        //189-00
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                 range:NSMakeRange(0, 1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                            green:255.0f/255.0f
                                                                                             blue:255.0f/255.0f
                                                                                            alpha:1.0f]
                                 range:NSMakeRange(0, 1)];
        //189-00 text-style1
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                 range:NSMakeRange(1, price.length-1)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                            green:255.0f/255.0f
                                                                                             blue:255.0f/255.0f
                                                                                            alpha:1.0f]
                                 range:NSMakeRange(1, price.length-1)];
        weakSelf.bottomView.priceLab.attributedText = attributedString;
    }else {
        if (msg.length>0) {
            [MBManager showBriefAlert:msg];
        }
    }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)requestShopCarData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/mcarts/?limit=10";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
            customContentView.DataDic = data.mutableCopy;
            NSArray *results = data[@"results"];
            [weakSelf.bottomView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
                                                       value:results.count
                                               animationType:WBadgeAnimTypeNone];
            float toal_price = BACKINFO_DIC_2_FLOAT(data, @"total_price");
            NSString *price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(toal_price)];
            //189-00
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                     range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(0, 1)];
            //189-00 text-style1
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                     range:NSMakeRange(1, price.length-1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(1, price.length-1)];
            weakSelf.bottomView.priceLab.attributedText = attributedString;
            weakSelf.bottomView.contentView = customContentView;
            weakSelf.bottomView.hiddenWhenTapBG = YES;
            [weakSelf.bottomView show];
            weakSelf.bottomView.isOpen = YES;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
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
    if ([self.titleStr isEqualToString:@"热门推荐"]) {
        cell.isTejia = NO;
    } else {
        cell.isTejia = YES;
    }
    cell.model = [CCGoodsDetail modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.lineView.hidden = NO;
    cell.delegate = self;
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
    CCGoodsDetail *model = [CCGoodsDetail modelWithJSON:self.dataSoureArray[indexPath.row]];
    CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
    vc.goodsID = STRING_FROM_INTAGER(model.ccid);
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCGoodsDetail *model = (CCGoodsDetail *)item;
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = [NSString stringWithFormat:@"/app0/goodsdetail/%ld/",model.ccid];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CCGoodsDetailInfoModel *goodsDetailModel = [CCGoodsDetailInfoModel modelWithJSON:data];
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
            customContentView.model = goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"requestShopCarData1" object:nil];
}
@end
