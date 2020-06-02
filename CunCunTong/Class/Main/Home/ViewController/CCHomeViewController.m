//
//  CCHomeViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *CellInder = @"commodity";
static NSString *everDayCell = @"everDayCell";
#import "CCHomeViewController.h"
#import "CCCommodityCollectionViewCell.h"
#import "CCHeaderCollectionReusableView.h"
#import "CCBigCommendCollectionViewCell.h"
#import "CCEverDayTeCollectionViewCell.h"
#import "CCCommodDetaildViewController.h"

#import "CCHomeHeaderView.h"
#import "CCEverDayTeViewController.h"
#import "XYMallClassifyViewcController.h"
#import "CCActivityView.h"
#import "NKAlertView.h"
#import "CCMessageViewController.h"
#import "CCActiveDivViewController.h"
#import "CCOrderSearchViewController.h"

#import "CCGoodsDetail.h"
#import "CCLunboTuModel.h"
@interface CCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView    *collectionView;
@property (nonatomic,strong) CCHomeHeaderView    *headView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *photoArray;
@property (strong, nonatomic) NSArray *hotArray;
@property (strong, nonatomic) NSArray *activeArray;
@property (strong, nonatomic) NSArray *teJiaArray;
@end

@implementation CCHomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NKAlertView *alert = [[NKAlertView alloc] init];
//    alert.contentView = [[CCActivityView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304+60)];
//    alert.hiddenWhenTapBG = YES;
//    alert.type = NKAlertViewTypeDef;
//    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSearchNavBar];
    [self.searBarView.searchBtn addTarget:self
                                   action:@selector(searchAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.searBarView.rightBtn addTarget:self
                                  action:@selector(searchAction:)
                        forControlEvents:UIControlEventTouchUpInside];
    [self layoutCollectionView];
    XYWeakSelf;
    [self.searBarView.rightBtn addTapGestureWithBlock:^(UIView *gestureView) {
        CCMessageViewController *vc = [CCMessageViewController new];
        [weakSelf.navigationController pushViewController:vc
                                             animated:YES];
    }];
    self.baseTableView = (UITableView *)self.collectionView;
    [self initData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initData];
    }];
    [self.collectionView.mj_header setIgnoredScrollViewContentInsetTop:256];
}

- (void)initData {
     dispatch_group_t group = dispatch_group_create();
     
     // 分类
     dispatch_group_enter(group);
    [self getCetagoryDataRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
     
     // 我的关注
     dispatch_group_enter(group);
    [self getTeJieData:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
     // 我的关注
     dispatch_group_enter(group);
    [self getAdLunboDataRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    MJWeakSelf;
     dispatch_group_notify(group, dispatch_get_main_queue(), ^{
         //列表数据
         [weakSelf getCommonListData:^(BOOL isScu) {
             if (isScu) {
                 [weakSelf.collectionView.mj_header endRefreshing];
                 NSMutableArray *photoArr = [NSMutableArray array];
                 for (NSDictionary *dict in weakSelf.photoArray) {
                     CCLunboTuModel *model = [CCLunboTuModel modelWithJSON:dict];
                     [photoArr addObject:model.image];
                 }
                 weakSelf.headView.bgImage.imageURLStringsGroup = photoArr;
                 
                 [weakSelf.collectionView reloadData];
             }
         }];
     });
    
}
- (void)getTeJieData:(void(^)(BOOL isScu))requestisScu {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/homepromotegoods/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.teJiaArray = data;
            requestisScu(YES);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
        requestisScu(NO);
    }];
}

- (void)getCetagoryDataRequestisScu:(void(^)(BOOL isScu))requestisScu {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/banner/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.photoArray = data;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
        requestisScu(YES);
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
        requestisScu(NO);
    }];
}
- (void)getAdLunboDataRequestisScu:(void(^)(BOOL isScu))requestisScu {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/homerecommendgoods/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.hotArray = data;
            requestisScu(YES);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
        requestisScu(NO);
    }];
}
- (void)getCommonListData:(void(^)(BOOL isScu))requestisScu {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/homereducegoods/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSArray *data = dic[@"data"];
            weakSelf.activeArray = data;
            requestisScu(YES);
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
        requestisScu(NO);
    }];
}

- (void)searchAction:(UIButton *)button {
    CCOrderSearchViewController *vc = [CCOrderSearchViewController new];
    vc.searchStr = @"请输入商品名称";
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NKAlertView *alert = [[NKAlertView alloc] init];
//    alert.contentView = [[CCActivityView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304+60)];
//    alert.hiddenWhenTapBG = YES;
//    alert.type = NKAlertViewTypeDef;
//    [alert show];
}

- (void)layoutCollectionView {
    _headView = [[CCHomeHeaderView alloc] initWithFrame:CGRectMake(0, -256, Window_W, 265)];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 12;
    flowLayout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H - 49 - NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [self.collectionView addSubview:_headView];
    self.collectionView.contentInset = UIEdgeInsetsMake(256, 0, 0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:CCCommodityCollectionViewCell.className bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellInder];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"footer"];
    [self.collectionView registerNib:[UINib nibWithNibName:CCHeaderCollectionReusableView.className bundle:[NSBundle mainBundle]]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"header"];
    [self.collectionView registerClass:CCBigCommendCollectionViewCell.class
            forCellWithReuseIdentifier:@"ccbigCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:CCEverDayTeCollectionViewCell.className bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:everDayCell];
    self.collectionView.contentOffset = CGPointMake(0, - 256);
    XYWeakSelf;
    self.headView.buttonAction = ^(NSInteger i) {
        switch (i) {
            case 0:
            {
                CCEverDayTeViewController *VC = [CCEverDayTeViewController new];
                VC.titleStr = @"每日特价";
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }
                break;
            case 1:
            {//活动专区
                CCActiveDivViewController *vc = [CCActiveDivViewController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            break;
            case 2:
            {
                CCEverDayTeViewController *VC = [CCEverDayTeViewController new];
                VC.titleStr = @"热门推荐";
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }
                break;
            case 3:
            {//商品分类
                XYMallClassifyViewcController *vc = [XYMallClassifyViewcController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    };
}
#pragma mark - Get
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"热门推荐",@"活动专区",@"每日特价"];
    }
    return _titleArray;
}

#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titleArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return self.activeArray.count;
    } else {
        return self.teJiaArray.count;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCBigCommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccbigCell"
                                                                                         forIndexPath:indexPath];
        cell.collectionLeftView.dataArray = self.hotArray.mutableCopy;
        return cell;
    } else if (indexPath.section == 2){
        CCEverDayTeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:everDayCell
                                                                                        forIndexPath:indexPath];
        cell.model = [CCGoodsDetail modelWithJSON:self.teJiaArray[indexPath.row]];
//        XYWeakSelf;
//        [cell.sureSales addTapGestureWithBlock:^(UIView *gestureView) {
//            CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }];
        return cell;
    } else if (indexPath.section == 1){
        CCCommodityCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellInder
                                                                                         forIndexPath:indexPath];
        cell.model = [CCGoodsDetail modelWithJSON:self.activeArray[indexPath.row]];
        return cell;
    }
    CCCommodityCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellInder forIndexPath:indexPath];
    cell.model = [CCGoodsDetail modelWithJSON:self.activeArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(Window_W, 184);
    } else if (indexPath.section == 2){
        return CGSizeMake(Window_W-20, 120);
    }
    return CGSizeMake((Window_W-20)/2, 198);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2 ) {
        CCGoodsDetail *model = [CCGoodsDetail modelWithJSON:self.teJiaArray[indexPath.row]];
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
        vc.goodsID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    } else if( indexPath.section ==1) {
        CCGoodsDetail *model = [CCGoodsDetail modelWithJSON:self.activeArray[indexPath.row]];
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
        vc.goodsID = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CCHeaderCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.titleLab.text =[NSString stringWithFormat:@"%@",self.titleArray[indexPath.section]];
        if (indexPath.section == 0) {
            view.moreBtn.hidden = YES;
        } else {
            view.moreBtn.hidden = NO;
            XYWeakSelf;
            if (indexPath.section == 1) {
                [view.moreBtn addTapGestureWithBlock:^(UIView *gestureView) {
                    CCActiveDivViewController *vc = [[CCActiveDivViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }];
            } else if (indexPath.section == 2){
                [view.moreBtn addTapGestureWithBlock:^(UIView *gestureView) {
                    CCEverDayTeViewController *vc = [[CCEverDayTeViewController alloc] init];
                    vc.titleStr = @"每日特价";
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return view;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1 ) {
        if (self.activeArray.count) {
            return CGSizeMake(Window_W, 53);
        } else {
            CGSizeMake(Window_W, 0.00001f);
        }
    } else if (section == 2) {
        if (self.teJiaArray.count) {
            return CGSizeMake(Window_W, 53);
        } else {
            CGSizeMake(Window_W, 0.00001f);
        }
    } else if (section == 0){
        if (self.hotArray.count) {
            return CGSizeMake(Window_W, 53);
        } else {
            CGSizeMake(Window_W, 0.00001f);
        }
    }
    return CGSizeMake(Window_W, 0.0001f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    ///!!!: footer高度
    return CGSizeMake(Window_W, .001f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return 0.1f;
    }
    return 12.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
    
@end
