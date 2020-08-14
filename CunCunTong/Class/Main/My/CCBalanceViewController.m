//
//  CCBalanceViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBalanceViewController.h"
#import "CCBalance.h"
#import "CCPayChongzhiViewController.h"
#import "BRDatePickerView.h"
@interface CCBalanceViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *monryLab;
@property (weak, nonatomic) IBOutlet KKButton *goPayBtn;
@property (strong, nonatomic) dispatch_group_t group;
@property (strong, nonatomic) UILabel *inLab;
@property (strong, nonatomic) UILabel *outLab;
@property (nonatomic,copy) NSString *begin_time;
@property (nonatomic,copy) NSString *end_time;


@end

@implementation CCBalanceViewController

- (IBAction)payButton:(id)sender {//充值
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self customNavBarwithTitle:@"余额" andLeftView:@""];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(197+NAVIGATION_BAR_HEIGHT+48);
    }];
    self.begin_time = @"";
    self.end_time = @"";
    [self.goPay setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:10];
    [self setupUI];
    [self initData];
    self.baseTableView = self.tableView;
}

- (void)setupUI {
    KKButton *forntBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [forntBtn setBackgroundColor:kWhiteColor];
    [forntBtn.titleLabel setFont:FONT_10];
    [forntBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [forntBtn setTitle:@"开始日期" forState:UIControlStateNormal];
    [forntBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    forntBtn.layer.cornerRadius = 10;
    forntBtn.tag = 10;
    [forntBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    forntBtn.layer.masksToBounds = YES;
    [self.view addSubview:forntBtn];
    UILabel *titleLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(51,51,51);
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view ;
    });
    titleLab2.text = @"至";
    [self.view addSubview:titleLab2];
    KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:kWhiteColor];
    [backBtn.titleLabel setFont:FONT_10];
    [backBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [backBtn setTitle:@"结束日期" forState:UIControlStateNormal];
    [backBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 10;
    backBtn.layer.masksToBounds = YES;
    backBtn.tag = 11;
    [backBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [forntBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
    [titleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(forntBtn.mas_right).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab2.mas_right).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
    [forntBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitleSpace:5];
    [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitleSpace:5];
    UILabel *titleLab3 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [self.view addSubview:titleLab3];
    [titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+8);
        make.width.mas_equalTo(198);
        make.height.mas_equalTo(15);
    }];
    UILabel *titleLab4 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [self.view addSubview:titleLab4];
    [titleLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+8+20);
        make.width.mas_equalTo(198);
        make.height.mas_equalTo(15);
    }];
    self.inLab = titleLab3;
    self.outLab = titleLab4;
    [self addTableViewRefresh];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}
- (void)initData {
    self.group = dispatch_group_create();
     // 分类
    dispatch_group_enter(self.group);
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/mybalance/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            float balance = [dic[@"data"] floatValue];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"¥%@",STRING_FROM_0_FLOAT(balance)]];
            [attributedString addAttribute:NSFontAttributeName value:STFont(26) range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

            //0-00 text-style1
            [attributedString addAttribute:NSFontAttributeName value:STFont(38) range:NSMakeRange(1, [NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT(balance)].length)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(1, [NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT(balance)].length)];
            weakSelf.monryLab.attributedText = attributedString;
            dispatch_group_leave(weakSelf.group);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];

    dispatch_group_enter(self.group);

    NSDictionary *params2 = @{@"begin_time":self.begin_time,
                              @"end_time":self.end_time,
    };
    NSString *path2 = @"/app0/mybalancecount/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path2
                                           WithParams:params2
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CGFloat invalue = [data[@"in"] floatValue];
            CGFloat outvalue = [data[@"out"] floatValue];
            weakSelf.inLab.text = [NSString stringWithFormat:@"充值 ￥%@",STRING_FROM_0_FLOAT(invalue)];
            weakSelf.outLab.text = [NSString stringWithFormat:@"支出 ￥%@",STRING_FROM_0_FLOAT(outvalue)];
            dispatch_group_leave(weakSelf.group);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];

    dispatch_group_enter(self.group);

    NSDictionary *params3 = @{@"limit":@(10),
                             @"offset":@(self.page*10),
                              @"begin_time":self.begin_time,
                              @"end_time":self.end_time,
    };
    NSString *path3 = @"/app0/mybalancelist/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path3
                                           WithParams:params3
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
            dispatch_group_leave(weakSelf.group);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];

     dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{

     });
}

- (void)timeSelect:(KKButton *)button {
    XYWeakSelf;
    NSString *str = [NSString getCurrentTime:@"yyyy-MM-dd"];
    [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeYMD defaultSelValue:str resultBlock:^(NSString *selectValue) {
        [button setTitle:selectValue forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitleSpace:5];
        if (button.tag == 10) {
            weakSelf.begin_time = selectValue;
        } else {
            weakSelf.end_time = selectValue;
        }
        weakSelf.page = 0;
        [weakSelf.dataSoureArray removeAllObjects];
        [weakSelf initData];
    }];
    
}
- (IBAction)goChongZhi:(UIButton *)sender {
    CCPayChongzhiViewController *vc = [CCPayChongzhiViewController new];
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
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCBalance modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
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











@end
