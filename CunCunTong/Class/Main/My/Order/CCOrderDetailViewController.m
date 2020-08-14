//
//  CCOrderDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailViewController.h"
#import "CCOrderDetailHeadView.h"
#import "CCOrderDetailHeadView2.h"
#import "CCOrderDetailFooterView.h"
#import "CCWuliuInfoViewController.h"
#import "CCOrderDatileModel.h"
#import "CCOrderDetailTableViewCell.h"
@interface CCOrderDetailViewController ()
@property (nonatomic,strong) CCOrderDetailHeadView *head;
@property (nonatomic,strong) CCOrderDetailHeadView2 *head2;
@property (strong, nonatomic) CCOrderDetailFooterView *footerView;
@property (strong, nonatomic) CCOrderDatileModel *model;

@end

@implementation CCOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"订单详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];

    
    self.footerView.frame = CGRectMake(0, 0, Window_W, 229+36);
    self.tableView.tableFooterView = self.footerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    XYWeakSelf;
    self.head.ClickBack = ^(NSInteger type) {
        CCWuliuInfoViewController *vc = [CCWuliuInfoViewController new];
        vc.OrderID = STRING_FROM_INTAGER(weakSelf.model.ccid);
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =self.ischeXiao ? [NSString stringWithFormat:@"/app0/mycarorder/%@/",self.orderID] : [NSString stringWithFormat:@"/app0/myorder/%@/",self.orderID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCOrderDatileModel modelWithJSON:data];

            if (weakSelf.model.status < 2) {
                weakSelf.head2.frame = CGRectMake(0, 0, Window_W, 78);
                weakSelf.tableView.tableHeaderView = weakSelf.head2;
                weakSelf.head2.nameLab.text = weakSelf.model.person_info.name;
                weakSelf.head2.numberLab.text =weakSelf.model.person_info.mobile;
                weakSelf.head2.addressLab.text = weakSelf.model.person_info.address;
            } else {
                weakSelf.head.frame = CGRectMake(0, 0, Window_W, 120);
                weakSelf.tableView.tableHeaderView = weakSelf.head;
                weakSelf.head.wuliuLab.text = weakSelf.model.postinfo;
                weakSelf.head.nameLab.text = weakSelf.model.person_info.name;
                weakSelf.head.numberLab.text =weakSelf.model.person_info.mobile;
                weakSelf.head.addressLab.text = weakSelf.model.person_info.address;
            }
            weakSelf.footerView.model = weakSelf.model;
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.goods_order_set.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Goods_order_setItem *model = self.model.goods_order_set[section];
    return model.sku_order_set.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Goods_order_setItem *model = self.model.goods_order_set[indexPath.section];
    CCOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCOrderDetail"];
    cell.goodsModel = model;
    cell.skuModel = model.sku_order_set[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 113;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0001f;
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
- (CCOrderDetailHeadView *)head {
    if (!_head) {
        _head = [[CCOrderDetailHeadView alloc] init];
    }
    return _head;
}
- (CCOrderDetailHeadView2 *)head2 {
    if (!_head2) {
        _head2 = [[CCOrderDetailHeadView2 alloc] init];
    }
    return _head2;
}
- (CCOrderDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CCOrderDetailFooterView alloc] init];
    }
    return _footerView;
}
@end
