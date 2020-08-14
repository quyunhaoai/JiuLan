//
//  CCWarningReminderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWarningReminderViewController.h"
#import "CCWarningReminderModel.h"
#import "SegmentTapView.h"
#import "CCWarningSetViewController.h"
#import "CCInGoodsListViewController.h"
#import "CCWarningReminderModelTableViewCell.h"
@interface CCWarningReminderViewController ()<SegmentTapViewDelegate>
@property (nonatomic,strong) SegmentTapView *segment;

@end

@implementation CCWarningReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.types = 0;
    self.baseTableView = self.tableView;
    [self setupUI];
    [self initData];
    [self addTableViewRefresh];
}
- (void)initData {
    NSString *path = @"/app0/warnmessage/";
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
                             @"types":@(self.types),
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
- (void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_14];
        [btn setTitle:@"设置" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        btn.hidden = YES;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"预警提醒" andLeftView:@"" andRightView:@[rightBtn]];
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"库存预警" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"临期预警" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 10);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(33);
    }];
    if (self.types == 2) {
        segC.selectedSegmentIndex = 1;
    } else {
         segC.selectedSegmentIndex = 0;
    }
    [segC ensureiOS12Style];
    UIView *style = [[UIView alloc] initWithFrame:CGRectZero];
    style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 0.08;
    [self.view addSubview:style];
    [style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(segC.mas_bottom).mas_offset(10);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+54);
    }];

    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 54)
                                           withDataArray:@[@"高库存预警",@"低库存预警"]
                                                withFont:15];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kClearColor;
    self.segment.lineImageView.frame = CGRectMake(Window_W/4, 37, 9, 8);
    self.segment.lineImageView.image = IMAGE_NAME(@"排序图标绿");
    if (self.types == 1) {
        [self.segment selectIndex:1];
    } else {
        
    }
    self.tableView.tableHeaderView = self.segment;
}
- (void)rightBtAction:(UIButton *)button {
    CCWarningSetViewController *vc = [CCWarningSetViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    self.segment.lineImageView.frame = CGRectMake(index?Window_W*0.75:Window_W/4, 37, 9, 8);
    if (index == 1) {
        self.types = 1;
    } else {
        self.types = 0;
    }
    [self.dataSoureArray removeAllObjects];
    self.page = 0;
    [self initData];
}

- (void)segCChanged:(UISegmentedControl *)seg {
    NSInteger i = seg.selectedSegmentIndex;
    if (i == 1) {
        self.types = 2;
        self.tableView.tableHeaderView = [UIView new];
    } else {
        self.tableView.tableHeaderView = self.segment;
        [self.segment selectIndex:1];
        self.segment.textSelectedColor = kMainColor;
        self.segment.lineImageView.frame = CGRectMake(Window_W/4, 37, 9, 8);
        self.types = 0;
    }
    NSLog(@"切换了状态 %lu",i);
    self.page = 0;

    [self initData];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCWarningReminderModel modelWithJSON: self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
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
    CCWarningReminderModelTableViewCell *cell = (CCWarningReminderModelTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    CCWarningReminderModel *model = [CCWarningReminderModel modelWithJSON: self.dataSoureArray[indexPath.row]];
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =[NSString stringWithFormat:@"/app0/warnmessage/%ld/",model.id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.noRead.hidden = YES;
                CCInGoodsListViewController *vc = [CCInGoodsListViewController new];
                if(weakSelf.types == 2){
                    vc.navTitleStr = @"临期预警";
                    vc.types = @"102";
                } else if(weakSelf.types == 1){
                    vc.navTitleStr = @"低库存预警";
                    vc.types = @"101";
                } else if(weakSelf.types == 0){
                    vc.navTitleStr = @"高库存预警";
                    vc.types = @"100";
                }
                [weakSelf.navigationController pushViewController:vc animated:YES];
            });
     }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}


@end
