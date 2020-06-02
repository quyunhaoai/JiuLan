//
//  CCYouHuiQuanViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCYouHuiQuanViewController.h"
#import "CCYouHuiQuan.h"
@interface CCYouHuiQuanViewController ()

@end

@implementation CCYouHuiQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"优惠券"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    [self initData];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"refreshYouHuiQuan" object:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
