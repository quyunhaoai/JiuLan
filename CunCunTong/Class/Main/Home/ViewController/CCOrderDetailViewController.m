//
//  CCOrderDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailViewController.h"
#import "CCOrderDetailHeadView.h"
#import "CCOrderDetail.h"
#import "CCOrderDetailFooterView.h"
#import "CCWuliuInfoViewController.h"
@interface CCOrderDetailViewController ()
@property (nonatomic,strong) CCOrderDetailHeadView *head;
@property (strong, nonatomic) CCOrderDetailFooterView *footerView;


@end

@implementation CCOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"订单详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.head.frame = CGRectMake(0, 0, Window_W, 130);
    self.tableView.tableHeaderView = self.head;
    
    self.footerView.frame = CGRectMake(0, 0, Window_W, 229+36);
    self.tableView.tableFooterView = self.footerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    XYWeakSelf;
    self.head.ClickBack = ^(NSInteger type) {
        CCWuliuInfoViewController *vc = [CCWuliuInfoViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    
    [self initData];
}

- (void)initData {
    self.dataSoureArray = @[[CCOrderDetail new],[CCOrderDetail new]].mutableCopy;
    self.head.nameLab.text = @"王强";
    self.head.numberLab.text = @"13145217111";
    self.head.addressLab.text = @"河南省郑州市二七区长江路街道长江路与连云路交叉口正商城2号楼 ";
}


- (CCOrderDetailHeadView *)head {
    if (!_head) {
        _head = [[CCOrderDetailHeadView alloc] init];
    }
    return _head;
}

- (CCOrderDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CCOrderDetailFooterView alloc] init];
    }
    return _footerView;
}
@end
