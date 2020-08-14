//
//  CCMallSubClassViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/5/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMallSubClassViewController.h"
#import "SH_MallSubclassificationSelectView.h"
#import "SH_MallSubclassificationViewControllerCell.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "CCEverDayTe.h"
#import "CCEverDayTeCollectionViewCell.h"
#import "CCShopBottomView1.h"
#import "CCServiceMassageView.h"
#import "CCShopCarView.h"
#import "CCSureOrderViewController.h"

#import "CCGoodsDetail.h"
#import "CCMallSubClassCollectionViewCell.h"
#import "CCCheXiaoCollectionViewCell.h"
#import "CCEverDayTeViewController.h"
#import "BottomAlert2Contentview.h"

#import "CCCommodDetaildViewController.h"
@interface CCMallSubClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GHDropMenuDelegate,GHDropMenuDataSource,KKCommonDelegate>

@property(nonatomic,strong)   UICollectionView *collectionView;
@property (nonatomic, strong) SH_MallSubclassificationSelectView *mallSelectView;
@property (nonatomic, assign) int                       sortColumn;//0:全部，1:按销量 2:按价格
@property (nonatomic, assign) int                       sortType;//0:正序 1:倒序
@property (nonatomic, assign) BOOL                       listType;//0:正序 1:倒序
@property (strong, nonatomic) CCShopBottomView1          *bottomView;
@property (assign, nonatomic) BOOL                       isOpen;
@property (strong, nonatomic) CCServiceMassageView      *massageView;
@property (strong, nonatomic) NSMutableArray            *dataArray;
@property (nonatomic,copy)  NSString                    *nextUrl;
@property (nonatomic,copy) NSString                     *ordering;
@property (copy, nonatomic) NSString                    *brand_id;
@property (nonatomic,copy) NSString                     *package;
@property (copy, nonatomic) NSString                    *min_price;
@property (copy, nonatomic) NSString                    *max_price;
@property (nonatomic,copy) NSString                     *specoption_id;
@property (nonatomic,strong)CCGoodsDetailInfoModel      *goodsInfoModel;


@end

@implementation CCMallSubClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortColumn = 0;
    self.sortType = 0;
    self.page = 0;
    self.ordering = @"";
    self.package = @"";
    self.specoption_id = @"";
    self.brand_id = @"";
    self.min_price = @"";
    self.max_price = @"";
    [self setUpUI];
    self.baseTableView = (UITableView *)self.collectionView;
    [self initData];
    adjustsScrollViewInsets_NO(self.collectionView, self);
    [kNotificationCenter addObserver:self selector:@selector(requestShopCarData1) name:@"refreshShopCarInfo" object:nil];
}

#pragma mark - requestData APIs
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"category3_id":self.categoryID,
                             @"limit":@(10),
                             @"ordering":self.ordering,//    排序（-sales:销量从高到低。 sales:销量从低到高。 -price:价格从高到低。 price:价格从低到高）
                             @"brand_id":self.brand_id,//品牌ID
                             @"package":self.package,//包装方式
                             @"min_price":self.min_price,//    最低价
                             @"max_price":self.max_price,//   最高价
                             @"specoption_id":self.specoption_id,//  规格选项ID,不同规格可用逗号分开，如（1,3,12）
                             @"offset":@(self.page*10),
    };
    NSString *path = @"/app0/centergoodslist/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *dict = dic[@"data"];
            NSString *next = dict[@"next"];
            weakSelf.nextUrl = next;
            NSArray *data = dict[@"results"];
            if (weakSelf.page == 0) {
                weakSelf.dataArray = data.mutableCopy;
                if (weakSelf.dataArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                }
            } else {
                [weakSelf.dataArray addObjectsFromArray:data];
            }
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView.mj_header endRefreshing];
            if (next == nil || [next isKindOfClass:[NSNull class]]) {
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.collectionView.mj_footer resetNoMoreData];
            }
            [weakSelf.collectionView reloadData];
            [weakSelf requestShopCarData1];
            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

#pragma mark - setUpUI
- (void)setUpUI {
    [self customSearchGoodsNavBar];
    self.searBarView.placeholderLabel.hidden = YES;
    self.searBarView.searchTextField.hidden = NO;
    self.searBarView.searchTextField.placeholder = @"请输入商品名称";
    [self.searBarView.searchTextField addTarget:self
                                         action:@selector(textFieldChange:)
                               forControlEvents:UIControlEventEditingChanged];
    [self initUI];
}
- (void)textFieldChange:(UITextField *)field {
    
}
- (void)initUI {
    [self.view addSubview:self.mallSelectView];
    [self layoutCollectionView];
}

#pragma mark  -  get
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (CCShopBottomView1 *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView1 alloc] initWithFrame:CGRectZero inView:self.view];
    }
    return _bottomView;
}

- (SH_MallSubclassificationSelectView *)mallSelectView{
    XYWeakSelf;
    if (_mallSelectView==nil) {
        _mallSelectView = [[SH_MallSubclassificationSelectView alloc] initWithFrame:CGRectMake(0,
                                                                                               NAVIGATION_BAR_HEIGHT,
                                                                                               Window_W,
                                                                                               RationHeight(48))];
        
        _mallSelectView.selctButtonClickBlock = ^(MallSelectedType selectedType) {
            [weakSelf.dataArray removeAllObjects];
            switch (selectedType) {
                case SelectedTypeComprehensive://综合
                {
                    weakSelf.ordering = @"";
                }
                    break;
                case SelectedTypeSalesVolumeUp://销量升
                {
                    weakSelf.ordering = @"-sales:";

                }
                    break;
                case SelectedTypeSalesVolumeDown://销量降
                {
                    weakSelf.ordering = @"-sales:";

                }
                    break;
                case SelectedTypePriceUp://价格升
                {
                    weakSelf.ordering = @"price";

                }
                    break;
                case SelectedTypePriceDown://价格降
                {
                    weakSelf.ordering = @"-price";

                }
                    break;
                case MallSelectedTypeShaiXuan:
                {
                    [weakSelf clickItem];
                }
                    break;
                case SelectedTypeChange:
                {
                    weakSelf.listType = !self.listType;
                }
                    break;
                default:
                    break;
            }
            if (selectedType != MallSelectedTypeShaiXuan) {
                weakSelf.page = 0;
                [weakSelf initData];
            }
        };
    }
    return _mallSelectView;
    
}
- (void)clickItem {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = [NSString stringWithFormat:@"/app0/goodsfilter/%@/",self.categoryID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            [weakSelf showShaixuan:data];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)showShaixuan:(NSDictionary *)dict{
    weakself(self);
    NSArray *brand_set = dict[@"brand_set"];
    NSArray *package_set = dict[@"package_set"];
    NSArray *spec_set = dict[@"spec_set"];
    
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc] init];
    configuration.recordSeleted = NO;
    configuration.dropMenuType = GHDropMenuTypeFilter;
    configuration.optionNormalColor = COLOR_333333;
    configuration.optionSeletedColor = kWhiteColor;
    configuration.titleViewBackGroundColor = kRedColor;
    configuration.titleNormalColor = COLOR_333333;
    
    configuration.brand_set = brand_set;
    configuration.package_set = package_set;
    configuration.spec_set = spec_set;
    configuration.titles = [configuration creaFilterDropMenuData];
    configuration.sectionSeleted = YES;
    
    GHDropMenu *dropMenu = [GHDropMenu creatDropFilterMenuWidthConfiguration:configuration dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
    }];
    dropMenu.delegate = self;
    dropMenu.durationTime = 0.5;
    [dropMenu show];
}
#pragma mark - 代理方法
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
    NSLog(@"%@",[NSString stringWithFormat:@"筛选结果1: %@",dropMenuTitleModel.title]);
}

- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (int i = 0; i<tagArray.count; i++) {
            GHDropMenuModel *dropMenuTagModel = tagArray[i];
            if (i == 0) {
                self.brand_id = STRING_FROM_INTAGER(dropMenuTagModel.tagIdentifier);
            } else if (i == 1){
                self.package = dropMenuTagModel.tagName;
            } else if (i == 2) {
                if (dropMenuTagModel.maxPrice.length) {
                    self.max_price = dropMenuTagModel.maxPrice;
                }
                if (dropMenuTagModel.minPrice.length) {
                    self.min_price = dropMenuTagModel.minPrice;
                }
            } else {
               if (dropMenuTagModel.tagIdentifier) {
                    [string appendFormat:@"%ld,",dropMenuTagModel.tagIdentifier];
                }
            }
        }
        NSLog(@"%@",[NSString stringWithFormat:@"筛选结果112: %@",string]);
        [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
        self.specoption_id = string;
    }
    self.page = 0;
    [self initData];
     NSLog(@"%@",[NSString stringWithFormat:@"筛选结果2: %@",string]);
}
- (void)layoutCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                         NAVIGATION_BAR_HEIGHT+RationHeight(48),
                                                                         Window_W,
                                                                         Window_H - RationHeight(48) - NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    XYWeakSelf;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf initData];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf initData];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerClass:CCMallSubClassCollectionViewCell.class
            forCellWithReuseIdentifier:@"CCMallSubClassCollectionViewCell"];
    [self.collectionView registerNib:CCCheXiaoCollectionViewCell.loadNib
          forCellWithReuseIdentifier:@"CCCheXiaoCollectionViewCell"];
}

#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listType) {
        CCCheXiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CCCheXiaoCollectionViewCell" forIndexPath:indexPath];
        cell.model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
        cell.isGoodsType = YES;
        cell.deleaget = self;
        return cell;
    }
    CCMallSubClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CCMallSubClassCollectionViewCell" forIndexPath:indexPath];
    cell.model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listType) {
        return CGSizeMake((Window_W-20-10)/2, (Window_W-20)/2+70+20);
    }
    return CGSizeMake(Window_W, 130);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CCGoodsDetail *model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
    CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
    vc.goodsID = STRING_FROM_INTAGER(model.ccid);
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Window_W, 0.0001f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    ///!!!: footer高度
    return CGSizeMake(Window_W, .001f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.1f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10,10, 10,10);
    
}
#pragma mark - private methods
- (void)rightBtnClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchAction {
    if (self.searBarView.searchTextField.text.length>0) {
        CCEverDayTeViewController *vc = [CCEverDayTeViewController new];
        vc.goods_name = self.searBarView.searchTextField.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  -  kkcommDelegate
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCGoodsDetail *mmm = (CCGoodsDetail *)item;
    XYWeakSelf;
     NSDictionary *params = @{};
     NSString *path = [NSString stringWithFormat:@"/app0/goodsdetail/%ld/",mmm.ccid];
     [[STHttpResquest sharedManager] requestWithMethod:GET
                                              WithPath:path
                                            WithParams:params
                                      WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
         NSInteger status = [[dic objectForKey:@"errno"] integerValue];
         NSString *msg = [[dic objectForKey:@"errmsg"] description];
         weakSelf.showErrorView = NO;
         if(status == 0){
             NSDictionary *data = dic[@"data"];
             weakSelf.goodsInfoModel = [CCGoodsDetailInfoModel modelWithJSON:data];
             NKAlertView *alertView = [[NKAlertView alloc] init];
             BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554)];
             customContentView.model = weakSelf.goodsInfoModel;
             alertView.type = NKAlertViewTypeBottom;
             alertView.contentView = customContentView;
             alertView.hiddenWhenTapBG = YES;
             [alertView show];
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
    }];
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"refreshShopCarInfo" object:nil];
}
@end
