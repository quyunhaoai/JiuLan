
//
//  CCMessageViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMessageViewController.h"
#import "ImageTitleButton.h"
#import "CCMessageModel.h"
#import "XYWebWorkViewController.h"
@interface CCMessageViewController ()

@end

@implementation CCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT_14];
        [btn setTitle:@"全标已读" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 60, 40);
    [self customNavBarWithtitle:@"消息中心" andLeftView:@"" andRightView:@[rightBtn]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(97+NAVIGATION_BAR_HEIGHT);
    }];
    [self initData];
    [self setupUI];
}
- (void)initData {
    self.dataSoureArray = @[[CCMessageModel new]].mutableCopy;
}
- (void)rightBtAction:(UIButton *)button {
    
}
- (void)setupUI {
    NSArray *icon = @[@"订单消息图标",@"物流图标",@"充值图标",@"活动图标 1",@"平台消息图标"];
    NSArray *arr = @[@"订单消息",@"交易物流",@"充值消息",@"热门活动",@"平台消息"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 10)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
//        退换货图标
        NSString *str = [NSString stringWithFormat:@"%@",icon[i]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [tolAry addObject:button];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT+15));
        make.height.equalTo(@54);
    }];
    
    
}
- (void)buttonClick:(UIButton *)button {
    
}
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    XYWebWorkViewController *web = [XYWebWorkViewController new];
    web.title = @"快来抽奖";
    web.urlString = @"https://weibo.com/";
    [self.navigationController pushViewController:web animated:YES];
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
