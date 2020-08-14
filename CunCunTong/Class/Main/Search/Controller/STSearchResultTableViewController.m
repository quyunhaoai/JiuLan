//
//  STSearchResultTableViewController.m
//  StudyOC
//
//  Created by 光引科技 on 2019/10/22.
//  Copyright © 2019 光引科技. All rights reserved.
//

#import "STSearchResultTableViewController.h"

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
@interface STSearchResultTableViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>
@property (strong, nonatomic) CCShopBottomView *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;

@end

@implementation STSearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    [self setupUI];
    [self addTableViewRefresh];
    [self initData];
}

- (void)initData {
    XYWeakSelf;
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

- (void)setupUI {
    [self customSearchGoodsNavBar];
    self.searBarView.placeholderLabel.hidden = YES;
    self.searBarView.searchTextField.hidden = NO;
    self.searBarView.searchTextField.placeholder = self.goods_name;
    [self.searBarView.searchTextField addTarget:self
                                         action:@selector(textFieldChange:)
                               forControlEvents:UIControlEventEditingChanged];
    [self.searBarView.rightBtn addTarget:self
                                  action:@selector(initData)
                        forControlEvents:UIControlEventTouchUpInside];
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
- (void)textFieldChange:(UITextField *)field {
    self.page = 0;
    self.goods_name = field.text;
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
