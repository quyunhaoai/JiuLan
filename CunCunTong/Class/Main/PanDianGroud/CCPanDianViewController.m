//
//  CCPanDianViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPanDianViewController.h"
#import "CCSelectTimeView.h"
#import "UISegmentedControl+CCStyle_OC.h"
@interface CCPanDianViewController ()

@end

@implementation CCPanDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = krgb(245,245,245);
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightBtn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
    [rightBtn sizeToFit];
    [self customNavBarWithtitle:@"盘点" andLeftView:@"" andRightView:@[rightBtn]];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    [self addSegmentedView];
    
    
}



- (void)addSegmentedView {
    
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"周盘" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"月盘" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(10);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 10);
        make.width.mas_equalTo(Window_W-20);
        make.height.mas_equalTo(33);
    }];
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    CCSelectTimeView *timeView = [[CCSelectTimeView alloc] init];
    [self.view addSubview:timeView];
    [timeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(segC.mas_bottom).mas_offset( 15);
        make.width.mas_equalTo(Window_W	);
        make.height.mas_equalTo(33);
    }];
    
    
}

-(void)segCChanged:(UISegmentedControl *)seg

{

    NSInteger i = seg.selectedSegmentIndex;

    NSLog(@"切换了状态 %lu",i);

 

}


@end
