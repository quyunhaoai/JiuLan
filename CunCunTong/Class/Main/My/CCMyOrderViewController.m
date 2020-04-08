//
//  CCMyOrderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyOrderViewController.h"
#import "CCMyOrderModel.h"
#import "CCOrderDetailViewController.h"

@interface CCMyOrderViewController ()<SegmentTapViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) KKNoDataView *noDataView;


@end

@implementation CCMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCMyOrderModel new]].mutableCopy;
    if (!self.dataSoureArray.count) {
        [self.view addSubview:self.noDataView];
        [self.noDataView masMakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).mas_offset(0);
            make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 15 +38);
            make.width.mas_equalTo(Window_W);
            make.bottom.mas_equalTo(self.view);
        }];
        self.noDataView.tipText = @"暂时没有相关订单哦~";
        self.noDataView.tipImage = IMAGE_NAME(@"无订单缺省页图标");
        [self.noDataView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.noDataView.mas_centerY).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(146, 125));
        }];
    } else {
        [self.noDataView removeFromSuperview];
    }
}
- (void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"我的订单" andLeftView:@"" andRightView:@[rightBtn]];
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"要货订单" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"车销订单" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(33);
    }];
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    [self initSegment];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5+40);
    }];
}
-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 38+15, Window_W, 40) withDataArray:self.titleArray withFont:15];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kMainColor;
    [self.view addSubview:self.segment];

}
- (void)rightBtAction:(UIButton *)btn {
    
}
- (void)segCChanged:(UISegmentedControl *)seg {
    NSInteger i = seg.selectedSegmentIndex;

    NSLog(@"切换了状态 %lu",i);
}

-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
//    [self.flipView selectIndex:index];
}
#pragma mark  -  Get
- (KKNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[KKNoDataView alloc] init];
    }
    return _noDataView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithArray:@[@"全部",
                                                       @"待付款",
                                                       @"待发货",
                                                       @"待收货",
                                                       @"退货中",
        ]];
    }
    return _titleArray;
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    CCOrderDetailViewController *VC = [CCOrderDetailViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
