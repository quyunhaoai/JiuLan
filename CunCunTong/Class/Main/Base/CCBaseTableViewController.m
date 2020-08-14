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
#import "CCMessageModelTableViewCell.h"
#import "CCGoodsSelectModelTableViewCell.h"
#import "CCYouHuiQuanTableViewCell.h"
#import "CCMyGoodsListTableViewCell.h"
#import "CCKuCunWarnGoodsListTableViewCell.h"
#import "CCHeadInfoTableViewCell.h"
#import "CCFooterInfoTableViewCell.h"
#import "CCNeedListModelTableViewCell.h"
@interface CCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
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
    [self.tableView registerNib:CCMessageModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMessageModel"];
    [self.tableView registerNib:CCGoodsSelectModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsSelectModel"];
    [self.tableView registerNib:CCYouHuiQuanTableViewCell.loadNib
         forCellReuseIdentifier:@"CCYouHuiQuan"];
    [self.tableView registerNib:CCMyGoodsListTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMyGoodsList"];
    [self.tableView registerNib:CCKuCunWarnGoodsListTableViewCell.loadNib
         forCellReuseIdentifier:@"CCKuCunWarnGoodsListTableViewCell"];
    [self.tableView registerClass:CCHeadInfoTableViewCell.class
           forCellReuseIdentifier:@"CCHeadInfoTableViewCell"];
    [self.tableView registerClass:CCFooterInfoTableViewCell.class
           forCellReuseIdentifier:@"CCFooterInfoTableViewCell"];
    [self.tableView registerNib:CCNeedListModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCNeedListModel"];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
//    tap.delegate = self;
//    [self.tableView addGestureRecognizer:tap];
}

//- (void)closeKeyBoard:(UITapGestureRecognizer *)gest{
//    [self.tableView endEditing:YES];
//}


//table添加手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"---%@",touch.view.class);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    } else {
        return YES;
    }
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
//        [self.tableView endEditing:YES];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
/// 添加下拉刷新
- (void)addTableViewHeadRefresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf initData];
    }];
}
/// 添加下拉刷新
- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf initData];
    }];
}






@end
