
//
//  CCProductZiZhiViewController.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCProductZiZhiViewController.h"
#import "CCProductZZTableViewCell.h"

#import "CCAddProductZiZhiViewController.h"
@interface CCProductZiZhiViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>

@end

@implementation CCProductZiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = ({
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
         [btn.titleLabel setFont:FONT_14];
         [btn setTitle:@"新增" forState:UIControlStateNormal];
         btn.layer.masksToBounds = YES ;
         btn.tag = 1;
         [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
         btn ;
     });
     rightBtn.frame = CGRectMake(0, 0, 40, 25);
    [self customNavBarWithtitle:@"产品资质" andLeftView:@"" andRightView:@[rightBtn]];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.baseTableView = self.tableView;
    [self.tableView registerClass:CCProductZZTableViewCell.class
           forCellReuseIdentifier:@"CCProductZZTableViewCell"];
    [self initData];
    [self addTableViewRefresh];
}

- (void)initData {
    NSString *path = @"/app0/qualify/";
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
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
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
    CCAddProductZiZhiViewController *vc = [CCAddProductZiZhiViewController new];
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
    CCProductZZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCProductZZTableViewCell"];
    cell.model = [CCProductZZModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
return 161;
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
- (void)jumpBtnClicked:(id)item {
    CCAddProductZiZhiViewController *vc = [CCAddProductZiZhiViewController new];
    vc.myModel = (CCProductZZModel *)item;
    [self.navigationController pushViewController:vc animated:YES];
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
