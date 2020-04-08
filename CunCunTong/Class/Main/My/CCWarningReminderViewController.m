//
//  CCWarningReminderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWarningReminderViewController.h"
#import "CCWarningReminderModel.h"
@interface CCWarningReminderViewController ()

@end

@implementation CCWarningReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCWarningReminderModel new]].mutableCopy;
}
- (void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    [self customNavBarWithTitle:@"预警提醒"];
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"库存预警" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"临期预警" atIndex:1 animated:NO];
//    [segC insertSegmentWithTitle:@"活动预警" atIndex:1 animated:NO];
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
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+90);
    }];
    
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
}

- (void)segCChanged:(UISegmentedControl *)seg {
    NSInteger i = seg.selectedSegmentIndex;

    NSLog(@"切换了状态 %lu",i);
}


@end
