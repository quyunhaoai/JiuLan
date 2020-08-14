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
#import "CCGoodsDetailHeadTableViewCell.h"
#import "CCYouHuiQuanViewController.h"

#import "CCGoodsDetailInfoModel.h"
#import "CCShopCarViewController.h"
#import "CCShaiXuanAlertView.h"
#import "WSLPictureBrowseView.h"
@interface CCCommodDetaildViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGRect HeaderFrame;
    dispatch_group_t path;
    WSLPictureBrowseView *background;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) UITableView             *tableView;
@property (nonatomic, strong) AJ_TopBar              *topBar;//  顶部筛选组件
@property (strong, nonatomic) SDCycleScrollView      *cycleScrollView;
@property (strong, nonatomic) CCShopBottomView       *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;
@property (strong, nonatomic) CCGoodsHeadView        *headView;
@property (strong, nonatomic) NSArray                *titleArray;
@property (nonatomic,strong) UICollectionView    *collectionView;
// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;
@property (nonatomic,strong) CCGoodsDetailInfoModel *goodsDetailModel;
@property (strong, nonatomic) UILabel *salesLab;
@property (strong,nonatomic) NSMutableArray  *photoArr;


@end

@implementation CCCommodDetaildViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    HeaderFrame = [self.tableView rectForHeaderInSection:2];
    self.marginTop = self.view.size.height-NAVIGATION_BAR_HEIGHT-48-20;
    NSLog(@"--%f",HeaderFrame.origin.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
    NSLog(@"newoffsetY:%f,offsetY%f",newoffsetY,offsetY);

    if (newoffsetY >= HeaderFrame.origin.y) {
        NSLog(@"-----============----------商品详情");
        [self.topBar setCurrentPage:1];
    }else if (newoffsetY < HeaderFrame.origin.y){
        NSLog(@"信息");
        [self.topBar setCurrentPage:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    [kNotificationCenter addObserver:self
                            selector:@selector(requestShopCarData1)
                                name:@"requestShopCarData1"
                              object:nil];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = [NSString stringWithFormat:@"/app0/goodsdetail/%@/",self.goodsID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.goodsDetailModel = [CCGoodsDetailInfoModel modelWithJSON:data];
            weakSelf.salesLab.text = [NSString stringWithFormat:@"销量：%ld",(long)weakSelf.goodsDetailModel.sales];
            weakSelf.cycleScrollView.imageURLStringsGroup = weakSelf.goodsDetailModel.goodsimage_set;
            [weakSelf downImage:weakSelf.goodsDetailModel.detailimage_set];
            [weakSelf.tableView reloadData];
            [weakSelf requestShopCarData1];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)downImage:(NSArray *)array {
    self.photoArr = [NSMutableArray array];
    for (int i= 0; i<array.count; i++) {
        photoInfo *info = [photoInfo new];
        NSString *url = array[i];
        url = [[CCTools sharedInstance] IsChinese:url];
        info.url = url;
        info.width = Window_W;
        info.height = 500;
        [self.photoArr addObject:info];
    }
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
    [self.tableView setTableHeaderView:self.cycleScrollView];
    //258 203
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-60-HOME_INDICATOR_HEIGHT);
    }];
    self.tableView.backgroundColor = COLOR_f5f5f5;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 197;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail1"];
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail2"];
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail3"];
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail4"];
    [self.tableView registerNib:CCGoodsDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsDetail5"];
    [self.tableView registerClass:CCGoodsDetailHeadTableViewCell.class
           forCellReuseIdentifier:@"CCGoodsDetailHeadTableViewCell"];
    self.bottomView.frame = CGRectMake(0, Window_H-60-HOME_INDICATOR_HEIGHT, Window_W, 60);
    [self.view addSubview:self.bottomView];
    self.isOpen = NO;
    XYWeakSelf;
    _bottomView.clickCallBack = ^(NSInteger tag) {
        if (tag ==2) {
            CCShopCarViewController *vc = [CCShopCarViewController new];
            vc.isShowLeftButton = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if(tag == 1){
            if (!weakSelf.isOpen) {
                [weakSelf requestService];
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
        } else if(tag == 4) {//加入购物车
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, weakSelf.view.bounds.size.width, 554) withShowSure:YES];
            customContentView.blockMothed = ^{
            };
            customContentView.blackSelect = ^(NSString * _Nonnull str) {
            };
            customContentView.model = weakSelf.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        } else {
            CCShaiXuanAlertView *alertView = [[CCShaiXuanAlertView alloc] initWithFrame:weakSelf.view.frame inView:weakSelf.view];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, weakSelf.view.bounds.size.width, 554) withShowSure:YES];
            customContentView.isSureOrder = YES;
            customContentView.blockMothed = ^{
            };
            customContentView.blackSelect = ^(NSString * _Nonnull str) {
            };
            customContentView.model = weakSelf.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }
    };
    [self.view addSubview:self.massageView];
    [self.massageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(13);
        make.bottom.mas_equalTo(self.view).mas_offset(-(56+HOME_INDICATOR_HEIGHT));
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(78);
    }];
    UILabel *style = [[UILabel alloc] initWithFrame:CGRectMake(Window_W-90, Window_W-30, 79, 18)];
    style.layer.cornerRadius = 3;
    style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f
                                                   green:0.0f/255.0f
                                                    blue:0.0f/255.0f
                                                   alpha:0.3f] CGColor];
    style.font = FONT_12;
    style.textColor = kWhiteColor;
    style.textAlignment = NSTextAlignmentCenter;
    self.salesLab = style;
    [_cycleScrollView addSubview:style];
    path = dispatch_group_create();
    dispatch_group_notify(path, dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}
- (void)addShopCar {
    NSDictionary *params = @{@"center_sku_id":STRING_FROM_INTAGER(self.goodsDetailModel.ccid),
                             @"count":checkNull(@"1"),
    };
    NSString *path = @"/app0/mcarts/";
    [[STHttpResquest sharedManager] requestWithMethod:POST
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            [kNotificationCenter postNotificationName:@"requestShopCarData1" object:nil];
            [kNotificationCenter postNotificationName:@"refreshShopCarInfo" object:nil];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)requestService {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/service/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            [weakSelf.massageView.telBtn setTitle:BACKINFO_DIC_2_STRING(data, @"mobile") forState:UIControlStateNormal];
            [weakSelf.massageView.weixinBtn setTitle:BACKINFO_DIC_2_STRING(data, @"wx_num") forState:UIControlStateNormal];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)requestShopCarData1 {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/mcarts/?limit=10";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSArray *results = data[@"results"];
            [weakSelf.bottomView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
                                                       value:results.count
                                               animationType:WBadgeAnimTypeNone];
            float toal_price = BACKINFO_DIC_2_FLOAT(data, @"total_price");
            NSString *price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(toal_price)];
            //189-00
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                     range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(0, 1)];
            //189-00 text-style1
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                     range:NSMakeRange(1, price.length-1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(1, price.length-1)];
            weakSelf.bottomView.priceLab.attributedText = attributedString;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)requestShopCarData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/mcarts/?limit=10";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
            customContentView.DataDic = data.mutableCopy;
            NSArray *results = data[@"results"];
            [weakSelf.bottomView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
                                                       value:results.count
                                               animationType:WBadgeAnimTypeNone];
            float toal_price = BACKINFO_DIC_2_FLOAT(data, @"total_price");
            NSString *price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(toal_price)];
            //189-00
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                     range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(0, 1)];
            //189-00 text-style1
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                     range:NSMakeRange(1, price.length-1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                green:255.0f/255.0f
                                                                                                 blue:255.0f/255.0f
                                                                                                alpha:1.0f]
                                     range:NSMakeRange(1, price.length-1)];
            weakSelf.bottomView.priceLab.attributedText = attributedString;
            weakSelf.bottomView.contentView = customContentView;
            weakSelf.bottomView.hiddenWhenTapBG = YES;
            [weakSelf.bottomView show];
            weakSelf.bottomView.isOpen = YES;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.accessibilityIdentifier = @"table_view1";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 66) inView:self.view];
    }
    return _bottomView;
}

- (void)rightBtAction:(UIButton *)btn {//分享
    NKAlertView *alertView = [[NKAlertView alloc] init];
    CCBottomShareAlertContentView *customContentView = [[CCBottomShareAlertContentView alloc] initWithFrame:CGRectMake(0,
                                                                                                                        0,
                                                                                                                        self.view.bounds.size.width,
                                                                                                                        133+49+5)];
    customContentView.model = self.goodsDetailModel;
    CCSharePicView *customImageView = [[CCSharePicView alloc] initWithFrame:CGRectMake(0, 0, Window_W-106, 370)];
    customImageView.model = self.goodsDetailModel;
    alertView.type = NKAlertViewTypeBottom;
    alertView.contentView = customContentView;
    alertView.middleView = customImageView;
    alertView.hiddenWhenTapBG = YES;
    [alertView show];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.goodsDetailModel.promote == nil) {
            return 3;
        } else {
            return 4;
        }
    } else if(section == 1){
        return 2;
    } else {
        return self.goodsDetailModel.detailimage_set.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        CCGoodsDetailHeadTableViewCell *ccc  = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetailHeadTableViewCell"];
        ccc.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        CGSize labelSize = [self.goodsDetailModel.goods_name boundingRectWithSize:CGSizeMake(Window_W-20, 5000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        if (labelSize.height>17) {
            [ccc.goodsTitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(labelSize.height+10);
            }];
        }
        ccc.goodsTitleLab.text = self.goodsDetailModel.goods_name;
        ccc.kuCunLab.text =[NSString stringWithFormat:@"库存量：%ld件",(long)self.goodsDetailModel.stock];
        if (self.goodsDetailModel.retail_price) {
            ccc.priceLab2.text =[NSString stringWithFormat:@"建议零售价：¥%@",STRING_FROM_0_FLOAT(self.goodsDetailModel.retail_price)];
        } else {
            ccc.priceLab2.text =[NSString stringWithFormat:@"建议零售价："];
        }

        NSString *pricestr = self.goodsDetailModel.promote == nil ? STRING_FROM_0_FLOAT(self.goodsDetailModel.play_price):STRING_FROM_0_FLOAT(self.goodsDetailModel.promote.now_price);
        if (self.goodsDetailModel.promote !=nil && self.goodsDetailModel.promote.types == 2) {
            pricestr = STRING_FROM_0_FLOAT(self.goodsDetailModel.play_price);
        }
        NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:krgb(255,69,4)}];
        NSMutableAttributedString *nameString2 = [[NSMutableAttributedString alloc] initWithString:pricestr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:krgb(255,69,4)}];
        [nameString appendAttributedString:nameString2];
        if (self.goodsDetailModel.promote.old_price) {
            NSString *oldPriceStr =[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.goodsDetailModel.promote.old_price)];
            NSAttributedString *countString = [[NSAttributedString alloc] initWithString:@" 原价：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999}];
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:oldPriceStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
            [nameString appendAttributedString:countString];
            [nameString appendAttributedString:attrStr];
        }
        ccc.priceLab.attributedText = nameString;
        return ccc;
    } else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell.contentView removeAllSubviews];
        UIImageView *imageBgView = ({
             UIImageView *view = [UIImageView new];
             view.contentMode = UIViewContentModeScaleToFill ;
             view.layer.masksToBounds = YES ;
             view.userInteractionEnabled = YES ;
             view;
         });
        [cell.contentView addSubview:imageBgView];
         [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.left.top.mas_equalTo(cell.contentView);
             make.width.mas_equalTo(cell.contentView);
             make.height.mas_equalTo(cell.contentView);
         }];
        XYWeakSelf;
        photoInfo *info = self.photoArr[indexPath.row];
        [imageBgView addTapGestureWithBlock:^(UIView *gestureView) {
            [weakSelf cleckImageViewAction:info.url];
        }];
        if (_photoArr.count) {
            photoInfo *info = self.photoArr[indexPath.row];
            dispatch_group_enter(path);
            XYWeakSelf;
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:info.url]
                                                                  options:SDWebImageDownloaderUseNSURLCache
                                                                 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

             } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                 //这边就能拿到图片了
                 CGFloat width = image.size.width;
                 CGFloat height = image.size.height;
                 CGFloat cellHeight = height/width *Window_W;
                 info.width = width;
                 info.height = cellHeight;
                 imageBgView.image = image;
                 [weakSelf.photoArr replaceObjectAtIndex:indexPath.row withObject:info];
                 dispatch_group_leave(self->path);
            }];
        }
        return cell;
    } else {
        if (indexPath.section == 0) {
            NSArray *arr = (NSArray *)self.titleArray[indexPath.section];
            if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row ==3) {
                if (indexPath.row == 1) {
                    CCGoodsDetailTableViewCell *cellll = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail1" forIndexPath:indexPath];
                    cellll.titleLab.text = arr[indexPath.row-1];
                    cellll.subLab.text = [NSString stringWithFormat:@"%@%@%@",self.goodsDetailModel.address.place1,self.goodsDetailModel.address.place2,self.goodsDetailModel.address.place3];
                    cellll.strokLab.hidden = NO;
                    if (self.goodsDetailModel.stock>0) {
                        cellll.strokLab.text=@"有货";
                    } else {
                        cellll.strokLab.text=@"无货";
                    }
                    cellll.titleCenterConstraint.constant = -10;
                    cellll.subTitleConstraint.constant = -10;
                    return cellll;
                } else if (indexPath.row == 2){
                    CCGoodsDetailTableViewCell *cellll2 = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail2" forIndexPath:indexPath];
                    cellll2.titleLab.text = arr[indexPath.row-1];
                    cellll2.subLab.text = @"包邮";
                    return cellll2;
                } else if (indexPath.row == 3){
                    CCGoodsDetailTableViewCell *cellll3 = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail3" forIndexPath:indexPath];
                    cellll3.titleLab.text = arr[indexPath.row-1];
                    if (self.goodsDetailModel.coupon_set.count) {
                        Coupon_setItem *item = self.goodsDetailModel.coupon_set[0];
                        if (item.types == 0) {
                            NSString *string = [NSString stringWithFormat:@"领！%ld元红包",(long)item.cut];
                            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
                            // 创建图片图片附件
                            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                            attach.image = [UIImage imageNamed:@"红包图标"];
                            attach.bounds = CGRectMake(5, -2.5, 13, 15);
                            NSAttributedString *attachString2 = [NSAttributedString attributedStringWithAttachment:attach];
                            [attributedString appendAttributedString:attachString2];
                            cellll3.subLab.attributedText =attributedString;
                        } else {
                            cellll3.subLab.text =[NSString stringWithFormat:@"点击领取优惠券"];
                        }
                        cellll3.subLab.textColor = krgb(255,63,62);
                    }else {
                        cellll3.subLab.text = @"";
                    }
                    return cellll3;
                }
            }
        } else if(indexPath.section == 1) {
            NSArray *arr = (NSArray *)self.titleArray[indexPath.section];
            if (indexPath.row == 0) {
                CCGoodsDetailTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail4" forIndexPath:indexPath];
                cell0.titleLab.text = arr[indexPath.row];
                NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"选择:"];
                for (Spec_setItem *item in self.goodsDetailModel.spec_set) {
                    [string appendFormat:@"%@,",item.spec_name];
                }
                cell0.subLab.text = string;
                return cell0;
            } else {
                CCGoodsDetailTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CCGoodsDetail5" forIndexPath:indexPath];
                cell1.titleLab.text = arr[indexPath.row];
                cell1.subLab.text = @"生产日期、品牌...";
                return cell1;
            }
        }
    }
    return nil;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        CGSize labelSize = [self.goodsDetailModel.goods_name boundingRectWithSize:CGSizeMake(Window_W-20, 5000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        if (labelSize.height>17) {
            return 90+labelSize.height;
        }
        return 97;
    } else if (indexPath.section == 2) {
        if (self.photoArr.count) {
            photoInfo *model = self.photoArr[indexPath.row];
            return model.height;
        }else {
            return 500;
        }
    } else if (indexPath.section == 0 && indexPath.row == 1){
        return 43+34;
    } else if (indexPath.section == 0 && indexPath.row == 3){
        if (self.goodsDetailModel.promote == nil) {
            return 0.001f;
        } else {
            return [CCGoodsDetailTableViewCell height];
        }
    }
    return [CCGoodsDetailTableViewCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 48.0f;
    }
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head =[UIView new];;
    [head removeAllSubviews];
    if (section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Window_W, 48)];
        label.textColor = COLOR_999999;
        label.font = FONT_16;
        label.text = @"------ 商品详情 ------";//更换手机号
        label.textAlignment = NSTextAlignmentCenter;
        [head addSubview:label];
    }
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vvv = [UIView new];
    vvv.backgroundColor = UIColorHex(0xf7f7f7);
    return vvv;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            NKAlertView *alertView = [[NKAlertView alloc] init];
            BottomAlertContentView *customContentView = [[BottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 426)];
            
            customContentView.model = self.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }else {
            CCGoodsDetailTableViewCell *cell = (CCGoodsDetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            CCShaiXuanAlertView *alertView = [[CCShaiXuanAlertView alloc] initWithFrame:self.view.frame inView:self.view];
            BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
            XYWeakSelf;
            customContentView.blockMothed = ^{
                CCSureOrderViewController *vc = [CCSureOrderViewController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            customContentView.blackSelect = ^(NSString * _Nonnull str) {
                cell.subLab.text = str;
            };
            customContentView.model = self.goodsDetailModel;
            alertView.type = NKAlertViewTypeBottom;
            alertView.contentView = customContentView;
            alertView.hiddenWhenTapBG = YES;
            [alertView show];
        }
    } else {
        if (indexPath.row == 3) {
            CCYouHuiQuanViewController *vc = [CCYouHuiQuanViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark  -  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    [self cleckImageViewAction2:self.goodsDetailModel.goodsimage_set];
    background.index = index;
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
#pragma mark - getters and setters
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray =@[@[@"送至",@"运费",@"活动"],@[@"选择",@"参数"]];
    }
    return _titleArray;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Window_W, Window_W) delegate:self placeholderImage:IMAGE_NAME(@"")];
        _cycleScrollView.currentPageDotColor = kMainColor;
        _cycleScrollView.pageDotColor = kWhiteColor;

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
        XYWeakSelf;
        _topBar.blockHandler = ^(NSInteger currentPage) {
            if (currentPage == 1) {
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            } else {
                [weakSelf.tableView scrollToTopAnimated:NO];
            }
        };
    }
    return _topBar;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"requestShopCarData1" object:nil];
}
- (void)cleckImageViewAction2:(NSArray *)url{
    WSLPictureBrowseView * browseView = [[WSLPictureBrowseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    browseView.backgroundColor = [UIColor blackColor];
    browseView.viewController = self;
    browseView.urlArray = url.mutableCopy;
    background = browseView;
    [self.view addSubview:browseView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [background addGestureRecognizer:tapGesture];
    [self shakeToShow:browseView];
}
- (void)cleckImageViewAction:(NSString *)url{
    WSLPictureBrowseView * browseView = [[WSLPictureBrowseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    browseView.backgroundColor = [UIColor blackColor];
    browseView.viewController = self;
    browseView.urlArray = @[url].mutableCopy;
    background = browseView;
    [self.view addSubview:browseView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [background addGestureRecognizer:tapGesture];
    [self shakeToShow:browseView];
}
-(void)closeView{
    [background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}
@end
