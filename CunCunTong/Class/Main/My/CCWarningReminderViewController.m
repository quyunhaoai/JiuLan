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
@interface CCWarningReminderViewController ()<SegmentTapViewDelegate>
@property (nonatomic,strong) SegmentTapView *segment;
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
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+44);
    }];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 54)];
    self.tableView.tableHeaderView = headView;

    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 54) withDataArray:@[@"高库存预警",@"低库存预警"] withFont:15];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kClearColor;
    self.segment.lineImageView.frame = CGRectMake(Window_W/4, 37, 9, 8);
    self.segment.lineImageView.image = IMAGE_NAME(@"排序图标绿");
    [headView addSubview:self.segment];
}

- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    self.segment.lineImageView.frame = CGRectMake(index?Window_W*0.75:Window_W/4, 37, 9, 8);
}

- (void)segCChanged:(UISegmentedControl *)seg {
    NSInteger i = seg.selectedSegmentIndex;

    NSLog(@"切换了状态 %lu",i);
}


@end
