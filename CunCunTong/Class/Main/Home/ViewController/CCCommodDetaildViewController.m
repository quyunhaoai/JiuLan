//
//  CCCommodDetaildViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommodDetaildViewController.h"
#import "SDCycleScrollView.h"
#import "AJ_TopBar.h"
#import "CCGoodsDetail.h"
#import "CCGoodsDetailTableViewCell.h"
#import "CCGoodsHeadView.h"
#import "BottomAlertContentView.h"
#import "BottomAlert2Contentview.h"
#import "CCShopBottomView.h"
#import "CCShopCarView.h"
#import "CCServiceMassageView.h"
#import "CCBottomShareAlertContentView.h"
#import "CCSharePicView.h"
#import "CCSureOrderViewController.h"
@interface CCCommodDetaildViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray         *dataSoureArray;
@property (nonatomic,strong) UITableView             *tableView;
@property (nonatomic, strong) AJ_TopBar              *topBar;//  顶部筛选组件
@property (strong, nonatomic) SDCycleScrollView      *cycleScrollView;

@property (strong, nonatomic) CCShopBottomView       *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;


@end

@implementation CCCommodDetaildViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCGoodsDetail new],[CCGoodsDetail new]].mutableCopy;
}
- (void)setupUI {
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"分享按钮") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.titleLabel.hidden = YES;
    self.navTitleView.splitView.backgroundColor = self.navTitleView.backgroundColor;
    [self.navTitleView addSubview:self.topBar];
    [self.topBar setCurrentPage:0];
    [self.tableView addSubview:self.cycleScrollView];
    //258 203
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    self.tableView.backgroundColor = COLOR_f5f5f5;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(258, 0, 0, 0);
    CCGoodsHeadView *headView = [[CCGoodsHeadView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 97)];
    headView.backgroundColor = kWhiteColor;
    self.tableView.tableHeaderView = headView;
    self.tableView.contentOffset = CGPointMake(0, -500);
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib forCellReuseIdentifier:@"CCGoodsDetail"];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(66);
    }];
    self.isOpen = NO;
    XYWeakSelf;
    _bottomView.clickCallBack = ^(NSInteger tag) {
        if (tag ==2) {
            if (!weakSelf.bottomView.isOpen) {
                CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
                weakSelf.bottomView.contentView = customContentView;
                weakSelf.bottomView.hiddenWhenTapBG = YES;
                [weakSelf.bottomView show];
                weakSelf.bottomView.isOpen = YES;
            } else {
                [weakSelf.bottomView hide];
                weakSelf.bottomView.isOpen = NO;
            }
        } else if(tag == 1){
            if (!weakSelf.isOpen) {
                weakSelf.isOpen = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 1.0;
                    weakSelf.massageView.hidden = NO;
                } completion:^(BOOL finished) {
                }];
            } else {
                weakSelf.isOpen = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 0;
                    weakSelf.massageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }
        } else {
            CCSureOrderViewController *vc = [CCSureOrderViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:self.massageView];
    [self.massageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(13);
        make.bottom.mas_equalTo(self.view).mas_offset(-(56+HOME_INDICATOR_HEIGHT));
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(78);
    }];
}


#pragma mark  - Get
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view1";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectMake(0, Window_H-66, Window_W, 66) inView:self.view];
    }
    return _bottomView;
}

- (void)rightBtAction:(UIButton *)btn {//分享
    NKAlertView *alertView = [[NKAlertView alloc] init];
     CCBottomShareAlertContentView *customContentView = [[CCBottomShareAlertContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 133+49+5)];
    CCSharePicView *customImageView = [[CCSharePicView alloc] initWithFrame:CGRectMake(0, 0, Window_W-106, 370)];
    alertView.type = NKAlertViewTypeBottom;
    alertView.contentView = customContentView;
    alertView.middleView = customImageView;
    alertView.hiddenWhenTapBG = YES;
    [alertView show];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail"];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    return [CellClass height];
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
    if (indexPath.row == 0) {
        NKAlertView *alertView = [[NKAlertView alloc] init];
        BottomAlertContentView *customContentView = [[BottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 426)];
        alertView.type = NKAlertViewTypeBottom;
        alertView.contentView = customContentView;
        alertView.hiddenWhenTapBG = YES;
        [alertView show];
    }else {
        NKAlertView *alertView = [[NKAlertView alloc] init];
        BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
        alertView.type = NKAlertViewTypeBottom;
        alertView.contentView = customContentView;
        alertView.hiddenWhenTapBG = YES;
        [alertView show];
    }
}

- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}
#pragma mark  -  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
#pragma mark - getters and setters
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -258, Window_W, 258) delegate:self placeholderImage:IMAGE_NAME(@"")];
        _cycleScrollView.localizationImageNamesGroup = @[@"详情页图片",@"详情页图片",@"详情页图片",@"详情页图片"];
        _cycleScrollView.currentPageDotColor = kMainColor;
        _cycleScrollView.pageDotColor = kWhiteColor;
        UILabel *style = [[UILabel alloc] initWithFrame:CGRectMake(Window_W-90, 228, 79, 18)];
        style.layer.cornerRadius = 3;
        style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3f] CGColor];
        style.text = @"销量：3340";
        style.font = FONT_12;
        style.textColor = kWhiteColor;
        style.textAlignment = NSTextAlignmentCenter;
        [_cycleScrollView addSubview:style];
    }
    return _cycleScrollView;
}
- (AJ_TopBar *)topBar {
    if (!_topBar) {

        _topBar = [[AJ_TopBar alloc] init];
           
        _topBar.center = CGPointMake(Window_W/2,
                                         STATUS_BAR_HEIGHT+(NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)/2);
          
        _topBar.bounds = CGRectMake(0,
                                        0,
                                        kWidth(39)*2+kWidth(24),
                                        NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT);
        
        _topBar.backgroundColor =  kClearColor;
        _topBar.buttonTitleColor = kWhiteColor;
        _topBar.markcolor = kWhiteColor;
        _topBar.buttonWidth = kWidth(39);
        _topBar.scrollEnabled = NO;
        _topBar.buttonTitleSelectedColor = kWhiteColor;
        _topBar.titles = [NSMutableArray arrayWithArray:@[@"商品",@"详情"]];

        _topBar.blockHandler = ^(NSInteger currentPage) {
            
        };
    }
    return _topBar;
}


/*#import "GoodsDetail1ViewController.h"
@interface GoodsDetail1ViewController ()<UITableViewDelegate, UITableViewDataSource, APIRequestDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIView *topBannerView;
@implementation GoodsDetail1ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT +50)];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 8);
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    [self.view addSubview:self.scrollView];
    self.topView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.topView.backgroundColor = [UIColor yellowColor];
    self.topBannerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.topBannerView.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:self.topBannerView];
    [self.scrollView addSubview:self.topView];
    self.goodsDataTableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_HEIGHT * 9) style:UITableViewStylePlain];
    self.goodsDataTableview1.backgroundColor = [UIColor colorWithHexColorString:@"ededed"];
    self.goodsDataTableview1.delegate = self;
    self.goodsDataTableview1.dataSource = self;
    self.goodsDataTableview1.bounces = NO;
    self.goodsDataTableview1.scrollEnabled = NO;
    [self.scrollView addSubview:self.goodsDataTableview1];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {//对其偏移量进行设置。
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY <= 0) {
            CGRect rect = self.topView.frame;
            rect.origin.y = offsetY;
            self.topView.frame = rect;
            rect = self.goodsDataTableview1.frame;
            rect.origin.y = offsetY + SCREEN_WIDTH;
            self.goodsDataTableview1.frame = rect;
            rect = self.topBannerView.frame;
            rect.origin.y = 0;
            self.topBannerView.frame = rect;
        } else  {
            CGRect rect = self.topBannerView.frame;
            rect.origin.y = offsetY / 2;
            self.topBannerView.frame = rect;
        }
}
}**/










@end
