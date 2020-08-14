
//
//  CCNeedUpListViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNeedUpListViewController.h"
#import "CCNeedViewController.h"

#import "CCNeedListModel.h"
#import "CCNeedDetailViewController.h"
#import "CCNeedListModelTableViewCell.h"
@interface CCNeedUpListViewController ()

@end

@implementation CCNeedUpListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 1;
         [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"需求上报" andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self initData];
    [self addTableViewRefresh];
    self.baseTableView = self.tableView;
    [self.tableView registerNib:CCNeedListModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCNeedListModel"];
}
- (void)initData {
    NSString *path = @"/app0/need/";
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
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)rightBtAction:(id)sender {
    CCNeedViewController *vc = [CCNeedViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCNeedListModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCNeedListModel"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.needModel = [CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCNeedListModel *model = [CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    if (model.image_set.count) {
        return 242;
    } else {
        return 242-(Window_W-64) /4;
    }
    return 242;
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
    CCNeedDetailViewController *vc = [CCNeedDetailViewController new];
    CCNeedListModel *model = [CCNeedListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    vc.needID = STRING_FROM_INTAGER(model.id);
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
