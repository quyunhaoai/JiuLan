//
//  XYMallClassifyViewcController.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//
static float kCollectionViewMargin = 0.f;
#import "XYMallClassifyViewcController.h"
#import "XYMallClassifyCollectionViewFlowLayout.h"
#import "XYMallClassifyLeftTableViewCell.h"
#import "XYMallClassifyCollectionViewCell.h"
#import "XYMallClassifyCollectionReusableView.h"
#import "SH_MallCategoryModel.h"

#import "CCMallSubClassViewController.h"

#import "CCShopBottomView1.h"
#import "CCServiceMassageView.h"
#import "CCShopCarView.h"
#import "CCSureOrderViewController.h"
#import "CCCheXiaoCollectionViewCell.h"
#import "CCOrderSearchViewController.h"
#import "CCCheXiaoCollectionViewCell.h"
#import "BottomAlert2Contentview.h"
#import "CCGoodsDetailInfoModel.h"
#import "CCCommodDetaildViewController.h"
@interface XYMallClassifyViewcController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,KKCommonDelegate>
{
    BOOL _isScrollDown;
    float _kLeftTableViewWidth;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) XYMallClassifyCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *categoryModels;
@property (nonatomic, strong) SH_WithDrawalsCategoryModel *selectedModel;

@property (strong, nonatomic) CCShopBottomView1 *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;
@property (nonatomic,strong) CCGoodsDetailInfoModel *goodsInfoModel;
@property (strong, nonatomic) UIImageView *shopCarImage; //
@property (strong, nonatomic) NSMutableArray *shopCarIDArray;  //


@end

@implementation XYMallClassifyViewcController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_f5f5f5;
    self.shopCarIDArray = [NSMutableArray array];
    _kLeftTableViewWidth = kWidth(100);
    _isScrollDown = YES;
    
    self.dataSource = [NSMutableArray array];
    self.categoryModels = [NSMutableArray array];

    adjustsScrollViewInsets_NO(self.tableView, self);
    adjustsScrollViewInsets_NO(self.collectionView, self);

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    [self customSearchGoodsNavBar];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];

    [self.searBarView.searchBtn addTarget:self
                                   action:@selector(search:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.searBarView.rightBtn addTarget:self
                                  action:@selector(search:)
                        forControlEvents:UIControlEventTouchUpInside];
    [self initData];
    self.baseTableView = (UITableView *)self.collectionView;
    [self setupUI];
    [self addBottomShopCar];
}
- (void)setupUI {
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = 0;
        view.hidden = YES;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"car_sales_cart")];
        view.layer.masksToBounds = YES;
        view;
    });
    self.shopCarImage = areaIcon;
    [self.view addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.mas_equalTo(self.view).mas_offset(-80);
    }];
    XYWeakSelf;
    [areaIcon addTapGestureWithBlock:^(UIView *gestureView) {
        if (!weakSelf.bottomView.isOpen) {
            [weakSelf requestShopCarData];
        } else {
            [weakSelf.bottomView hide];
            weakSelf.bottomView.isOpen = NO;
            weakSelf.bottomView.hidden = YES;
        }
    }];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/category1/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.dataSource = data.mutableCopy;
            NSDictionary *chexiao = @  {
                      @"id": @(999999),
                      @"name": @"车销",
            };
            [weakSelf.dataSource addObject:chexiao];
            SH_WithDrawalsCategoryModel *model = [SH_WithDrawalsCategoryModel modelWithJSON:self.dataSource[0]];
            [weakSelf requestTowCata:[model.ccid integerValue]];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionNone];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)requestTowCata:(NSInteger )parent {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path =[NSString stringWithFormat:@"/app0/category2/?parent=%ld",parent];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.categoryModels = data.mutableCopy;
            [weakSelf.collectionView reloadData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)search:(UIButton *)button {
    CCOrderSearchViewController *vc = [CCOrderSearchViewController new];
    vc.searchStr = @"请输入商品名称";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addBottomShopCar {
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
                [weakSelf requestShopCarData];
            } else {
                [weakSelf.bottomView hide];
                weakSelf.bottomView.isOpen = NO;
            }
        } else if(tag == 1){

        } else {//去结算
            if (weakSelf.shopCarIDArray.count) {
                CCSureOrderViewController *vc = [[CCSureOrderViewController alloc] initWithTypes:@"0" withmcarts:weakSelf.shopCarIDArray withCenter_sku_id:@"" withCount:@""];
                vc.isCheXiao = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                [MBManager showBriefAlert:@"您还未选择购买的商品"];
            }

        }
    };

}
#pragma mark  -  get
- (CCShopBottomView1 *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView1 alloc] initWithFrame:CGRectZero inView:self.view];
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

#pragma mark---lazy loading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   NAVIGATION_BAR_HEIGHT,
                                                                   _kLeftTableViewWidth,
                                                                   SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = kWidth(48);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

- (XYMallClassifyCollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[XYMallClassifyCollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = kCollectionViewMargin;
        _flowLayout.minimumLineSpacing = kCollectionViewMargin;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake( _kLeftTableViewWidth+10,
                                                                             NAVIGATION_BAR_HEIGHT,
                                                                             SCREEN_WIDTH - _kLeftTableViewWidth-10-10,
                                                                             SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT)
                                             collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:COLOR_f5f5f5];
        //注册cell
        [_collectionView registerClass:[XYMallClassifyCollectionViewCell class]
            forCellWithReuseIdentifier:@"XYMallClassifyCollectionViewCell"];
        [_collectionView registerNib:CCCheXiaoCollectionViewCell.loadNib
          forCellWithReuseIdentifier:@"CCCheXiaoCollectionViewCell"];
        //注册分区头标题
        [_collectionView registerClass:[XYMallClassifyCollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"XYMallClassifyCollectionReusableView"];
        [_collectionView registerNib:CCCheXiaoCollectionViewCell.loadNib
          forCellWithReuseIdentifier:@"CCCheXiaoCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMallClassifyLeftTableViewCell *cell = [XYMallClassifyLeftTableViewCell cellWithTableView:tableView];
    SH_WithDrawalsCategoryModel *model = [SH_WithDrawalsCategoryModel modelWithJSON:self.dataSource[indexPath.row]];
    cell.nameLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.selectedModel = [SH_WithDrawalsCategoryModel modelWithJSON:self.dataSource[indexPath.row]];
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        self.page = 0;
        [self requestChexiaoData];
        self.shopCarImage.hidden = NO;
        [self.searBarView removeFromSuperview];
        [self customNavBarWithTitle:@"商品"];
    } else {
        [self requestTowCata:[self.selectedModel.ccid integerValue]];
        self.shopCarImage.hidden = YES;
        [self.navTitleView removeFromSuperview];
        [self customSearchGoodsNavBar];
    }
}
- (void)requestChexiaoData {
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
    };
    NSString *path = @"/app0/cargoods/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
            if (weakSelf.page) {
                [weakSelf.dataSoureArray addObjectsFromArray:array];
            } else {
                weakSelf.dataSoureArray = array.mutableCopy;
                if (self.dataSoureArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                    weakSelf.blankView.height = 300;
                }
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.collectionView.mj_footer resetNoMoreData];
            }
            [weakSelf.collectionView reloadData];
            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)requestShopCarData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/caraddcarts/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:GET
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *data = dic[@"data"];
                weakSelf.bottomView.hidden = NO;
                CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
                customContentView.isChexiao = YES;
                customContentView.DataDic = data.mutableCopy;
                NSArray *arr = data[@"carts"];
                for (NSDictionary *dict in arr) {
                    [weakSelf.shopCarIDArray addObject:[NSNumber numberWithInt:[dict[@"id"] intValue]]];
                }
                [weakSelf.bottomView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
                                                               value:arr.count
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
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {

    }];
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        return 1;
    } else {
        return self.categoryModels.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        return self.dataSoureArray.count;
    } else {
        SH_MallCategoryModel *model = [SH_MallCategoryModel modelWithJSON:self.categoryModels[section]];
        return [self resloveData:model andSection:section];
    }
}
NSInteger cols = 3;
-(NSInteger )resloveData:(SH_MallCategoryModel *)model andSection:(NSUInteger)section{
    NSInteger count = model.children.count;
    NSInteger exter = count % cols;
    NSMutableArray *arr = model.children.mutableCopy;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            NSDictionary *dict = @{};
            [arr addObject:dict];
        }
    }
    model.children = arr.copy;
    [self.categoryModels replaceObjectAtIndex:section withObject:model.modelToJSONObject];
    return model.children.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        CCCheXiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CCCheXiaoCollectionViewCell" forIndexPath:indexPath];
        cell.chexiaomodel = [CCChexiaoListModel modelWithJSON:self.dataSoureArray[indexPath.row]];
        cell.deleaget = self;
        return cell;
    } else {
        XYMallClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYMallClassifyCollectionViewCell"
                                                                                           forIndexPath:indexPath];
        SH_MallCategoryModel *model = [SH_MallCategoryModel modelWithJSON:self.categoryModels[indexPath.section]];
        cell.model = (SH_WithDrawalsCategoryModel *)model.children[indexPath.row];
        cell.contentView.layer.cornerRadius =2;
        cell.layer.cornerRadius =2;
        cell.contentView.layer.masksToBounds =YES;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        return CGSizeMake((Window_W - _kLeftTableViewWidth -10-10-kCollectionViewMargin-10) / 2,
                          (Window_W - _kLeftTableViewWidth -10-10-kCollectionViewMargin-10) / 2+70);
    } else {
        return CGSizeMake((Window_W - _kLeftTableViewWidth -10-10-kCollectionViewMargin*2) / 3,
                      (Window_W - _kLeftTableViewWidth - 10-10-kCollectionViewMargin*2) / 3 + 15);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"";
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
        reuseIdentifier = @"XYMallClassifyCollectionReusableView";
    }
    XYMallClassifyCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    SH_MallCategoryModel *model = [SH_MallCategoryModel modelWithJSON:self.categoryModels[indexPath.section]];
    view.titleLab.text = model.name;
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        return CGSizeMake(Window_W - _kLeftTableViewWidth, 0.0001f);
    } else {
        SH_MallCategoryModel *model = [SH_MallCategoryModel modelWithJSON:self.categoryModels[section]];
        if (model.children.count) {
            return CGSizeMake(Window_W - _kLeftTableViewWidth, 48);
        } else {
            return CGSizeMake(Window_W - _kLeftTableViewWidth, 0.0001f);
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
        return 10.0f;
    } else {
        return 0;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
       return  UIEdgeInsetsMake(10, 0, 0, 0);
    } else {
      return  UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectedModel.ccid isEqualToString:@"999999"]) {
    } else {
        SH_MallCategoryModel *model = [SH_MallCategoryModel modelWithJSON:self.categoryModels[indexPath.section]];
        SH_WithDrawalsCategoryModel *ccmodel = (SH_WithDrawalsCategoryModel *)model.children[indexPath.row];
        if ([ccmodel.ccid isEqualToString:@""] || ccmodel.ccid == nil) {
            return;
        }
        CCMallSubClassViewController*vc = [CCMallSubClassViewController new];
        vc.categoryID = ccmodel.ccid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)jumpBtnClicked:(id)item {

}
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCChexiaoListModel *model = (CCChexiaoListModel *)item;
    NKAlertView *alertView = [[NKAlertView alloc] init];
    BottomAlert2Contentview *customContentView = [[BottomAlert2Contentview alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 554) withShowSure:YES];
    customContentView.cccModel = model;
    customContentView.isChexiao = YES;
    alertView.type = NKAlertViewTypeBottom;
    alertView.contentView = customContentView;
    alertView.hiddenWhenTapBG = YES;
    [alertView show];
}

@end
