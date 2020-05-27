//
//  CCSureOrderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSureOrderViewController.h"
#import "CCSureOrderBottomView.h"
#import "CCSureOrder.h"
#import "NKAlertView.h"
#import "BottomAlert3ContentView.h"
#import "CCCententAlertErWeiMaView.h"
#import "CCAddBlankCarViewController.h"
@interface CCSureOrderViewController ()
{
    
}
@property (strong, nonatomic) CCSureOrderBottomView *bottomView;



@end

@implementation CCSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"确认订单"];
    self.hhhView.frame = CGRectMake(0, 0, Window_W, 85);
    self.tableView.tableHeaderView = self.hhhView;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.bottomView.frame = CGRectMake(0, 0, Window_W, 474);
    self.tableView.tableFooterView = self.bottomView;
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    
    [self initData];
    [self setupUI];
}
- (void)setupUI {
    NKAlertView *alert = [[NKAlertView alloc] init];
    BottomAlert3ContentView *bottomCententView = [[BottomAlert3ContentView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 197)];;
    XYWeakSelf;
    bottomCententView.btnClick = ^{
        CCAddBlankCarViewController *vc = [CCAddBlankCarViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    alert.contentView = bottomCententView;
    alert.type = NKAlertViewTypeBottom;
    alert.hiddenWhenTapBG = YES;

    [alert show];
}
- (void)initData {
    self.dataSoureArray = @[[CCSureOrder new],[CCSureOrder new]].mutableCopy;
}
#pragma mark  -  get
-(CCSureOrderHeadView *)hhhView {
    if (!_hhhView) {
        _hhhView = [[CCSureOrderHeadView alloc] init];
    }
    return _hhhView;
}
- (CCSureOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCSureOrderBottomView alloc] init];
    }
    return _bottomView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NKAlertView *alert = [[NKAlertView alloc] init];
    alert.contentView = [[CCCententAlertErWeiMaView alloc] initWithFrame:CGRectMake(0, 0, 300, 336)];
    alert.type = NKAlertViewTypeDef;
    alert.hiddenWhenTapBG = YES;
    
    [alert show];
}














@end
