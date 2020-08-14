//
//  CCBusinessZiZhiViewController.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//


#import "CCBusinessZiZhiViewController.h"
#import "CCProductZZTableViewCell.h"
#import "CCBusinessZZModel.h"
#import "CCChangeBusinessZiZhiViewController.h"
@interface CCBusinessZiZhiViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>

@end

@implementation CCBusinessZiZhiViewController

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
     rightBtn.frame = CGRectMake(0, 0, 40, 25);
    [self customNavBarWithtitle:@"营业资质" andLeftView:@"" andRightView:@[rightBtn]];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.baseTableView = self.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:CCProductZZTableViewCell.class
           forCellReuseIdentifier:@"CCProductZZTableViewCell"];
    [self initData];
    [self addTableViewRefresh];
    self.baseTableView = self.tableView;
    self.tableView.estimatedRowHeight = 320;
    [kNotificationCenter addObserver:self selector:@selector(initData2) name:@"initData" object:nil];
}
- (void)initData2{
    [self.tableView.mj_header beginRefreshing];
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
- (void)rightBtAction:(UIButton *)button {
    CCChangeBusinessZiZhiViewController *vc = [CCChangeBusinessZiZhiViewController new];
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
    CCProductZZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCProductZZTableViewCell" forIndexPath:indexPath];
    cell.businessModel = [CCBusinessZZModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCBusinessZZModel *model =  [CCBusinessZZModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    if (model.marketqualifyphoto_set.count >3) {
        return (Window_W-40) /3 *2 +54+20;
    } if (model.marketqualifyphoto_set.count == 0) {
        return 44;
    } else {
        return (Window_W-40) /3+54+10;
    }
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

}
- (void)jumpBtnClicked:(UIButton *)button andModel:(id)item {
    if (button.tag == 101) {
        CCChangeBusinessZiZhiViewController *vc = [CCChangeBusinessZiZhiViewController new];
        vc.myModel = (CCBusinessZZModel *)item;
        vc.navTitleString = @"修改营业资质";
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        XYWeakSelf;
        CCBusinessZZModel *model = (CCBusinessZZModel *)item;
        NSDictionary *params = @{
        };
        NSString *path =[NSString stringWithFormat:@"/app1/qualify/%ld",model.ccid];
        [[STHttpResquest sharedManager] requestWithPUTMethod:DELETE
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            weakSelf.showErrorView = NO;
            if(status == 0){
                [weakSelf.tableView.mj_header beginRefreshing];
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

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"initData" object:nil];
}
@end
