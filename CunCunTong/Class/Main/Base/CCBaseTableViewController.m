//
//  CCBaseTableViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "CCBalanceTableViewCell.h"
#import "CCMyOrderModelTableViewCell.h"
#import "CCDaySalesTableViewCell.h"
#import "CCWarningReminderModelTableViewCell.h"
#import "CCSureOrderTableViewCell.h"
#import "CCOrderDetailTableViewCell.h"
#import "CCModifyArddressTableViewCell.h"
@interface CCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,readonly) UITableViewStyle style;
@end

@implementation CCBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super self];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    self.tableView.backgroundColor = COLOR_f5f5f5;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:CCBalanceTableViewCell.loadNib
         forCellReuseIdentifier:@"CCBalance"];
    [self.tableView registerNib:CCMyOrderModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMyOrderModel"];
    [self.tableView registerNib:CCDaySalesTableViewCell.loadNib
         forCellReuseIdentifier:@"CCDaySales"];
    [self.tableView registerNib:CCWarningReminderModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCWarningReminderModel"];
    [self.tableView registerNib:CCSureOrderTableViewCell.loadNib
         forCellReuseIdentifier:@"CCSureOrder"];
    [self.tableView registerNib:CCOrderDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCOrderDetail"];
    [self.tableView registerNib:CCModifyArddressTableViewCell.loadNib
         forCellReuseIdentifier:@"CCModifyArddress"];
//    [self addTableViewRefresh];
}
#pragma mark  - Get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
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
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:self.dataSoureArray[indexPath.row] indexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    if ([modelName isEqualToString:@"TextModel"]) {
        CellClass = NSClassFromString(@"TextModelCell");
    }
    return [CellClass height];
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
    
}

- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}












@end
