//
//  CCYouHuiQuanViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCYouHuiQuanViewController.h"
#import "CCYouHuiQuan.h"
#import "CCNowpayOrderModel.h"
#import "CCYouHuiQuanTableViewCell.h"
@interface CCYouHuiQuanViewController ()<KKCommonDelegate>

@end

@implementation CCYouHuiQuanViewController
- (instancetype)initWithCoupon_set:(NSArray *)coupon_set {
    if (self = [super init]) {
        self.coupon_setArray = coupon_set;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"优惠券"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.baseTableView = self.tableView;
    if (_coupon_setArray == nil) {
        [self initData];
    } else {
        if (_coupon_setArray.count) {
            for (Coupon_setItem *item in _coupon_setArray) {
                CCYouHuiQuan *model = [CCYouHuiQuan modelWithJSON:item.modelToJSONObject];
                [self.dataSoureArray addObject:model];
            }
            self.showTableBlankView = NO;
        } else {
            self.showTableBlankView = YES;
        }
        [self.tableView reloadData];
    }
    [kNotificationCenter addObserver:self
                            selector:@selector(initData)
                                name:@"refreshYouHuiQuan"
                              object:nil];
}

- (void)initData {
    XYWeakSelf;
    [self.dataSoureArray removeAllObjects];
    NSDictionary *params = @{};
    NSString *path = @"/app0/coupon/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            if (data.count) {
                for (NSDictionary *dict in data) {
                    CCYouHuiQuan *model = [CCYouHuiQuan modelWithJSON:dict];
                    [weakSelf.dataSoureArray addObject:model];
                }
                weakSelf.showTableBlankView = NO;
            } else {
                weakSelf.showTableBlankView = YES;
            }
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self];
}
#pragma mark  -  kkcommdelegate
- (void)jumpBtnClicked:(id)item {
    CCYouHuiQuan *model = (CCYouHuiQuan *)item;
    if (self.blackCoupon_id) {
        self.blackCoupon_id(STRING_FROM_INTAGER(model.ccid));
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCYouHuiQuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCYouHuiQuan"];
    if (self.isOrderVc) {
        [(CCYouHuiQuanTableViewCell *)cell setIsOrderVc:YES];
        [(CCYouHuiQuanTableViewCell *)cell setDelegate:self];
    }
    cell.modelccc = self.dataSoureArray[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self tableViewDidSelect:indexPath];
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
//        [self.tableView endEditing:YES];
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
