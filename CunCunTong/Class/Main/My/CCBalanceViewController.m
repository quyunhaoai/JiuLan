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
@interface CCBalanceViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation CCBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self customNavBarwithTitle:@"余额" andLeftView:@""];
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(197+NAVIGATION_BAR_HEIGHT);
    }];

    [self.goPay setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:10];
    UIView *timeSelectview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 48)];
    timeSelectview.backgroundColor = kClearColor;
    self.tableView.tableHeaderView = timeSelectview;
    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCBalance new],[CCBalance new]].mutableCopy;
}
         
- (IBAction)goChongZhi:(UIButton *)sender {
    
    CCPayChongzhiViewController *vc = [CCPayChongzhiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}













@end
