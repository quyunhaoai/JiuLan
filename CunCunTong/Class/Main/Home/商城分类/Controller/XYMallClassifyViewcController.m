//
//  XYMallClassifyViewcController.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//
static float kCollectionViewMargin = 3.f;
#import "XYMallClassifyViewcController.h"
#import "XYMallClassifyCollectionViewFlowLayout.h"
#import "XYMallClassifyLeftTableViewCell.h"
#import "XYMallClassifyCollectionViewCell.h"
#import "XYMallClassifyCollectionReusableView.h"
#import "SH_MallCategoryModel.h"

#import "SH_MallSubclassificationViewController.h"

#import "CCShopBottomView.h"
#import "CCServiceMassageView.h"
#import "CCShopCarView.h"
#import "CCSureOrderViewController.h"
#import "CCCheXiaoCollectionViewCell.h"
@interface XYMallClassifyViewcController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource>
{
    BOOL _isScrollDown;
    float _kLeftTableViewWidth;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) XYMallClassifyCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *categoryModels;
@property (nonatomic, strong) SH_MallCategoryModel *selectedModel;

@property (strong, nonatomic) CCShopBottomView *bottomView;
@property (assign, nonatomic) BOOL                   isOpen;
@property (strong, nonatomic) CCServiceMassageView   *massageView;
@end

@implementation XYMallClassifyViewcController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_f5f5f5;
    
    _kLeftTableViewWidth = kWidth(100);
    _isScrollDown = YES;
    
    self.dataSource = [NSMutableArray array];
    self.categoryModels = [NSMutableArray array];

    self.categoryModels = @[[SH_MallCategoryModel new],[SH_MallCategoryModel new],[SH_MallCategoryModel new]].mutableCopy;
    self.dataSource = @[@"食品",@"饮品",@"酒类"].mutableCopy;
    _selectedModel = self.categoryModels[0];
    adjustsScrollViewInsets_NO(self.tableView, self);
    adjustsScrollViewInsets_NO(self.collectionView, self);

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    [self customSearchGoodsNavBar];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    [self addBottomShopCar];
    [self.searBarView.searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.searBarView.rightBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)search:(UIButton *)button {
    SH_MallSubclassificationViewController *vc = [SH_MallSubclassificationViewController new];
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
        } else {//去结算
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
#pragma mark  -  get
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectZero inView:self.view];
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
                                                                             SCREEN_WIDTH - _kLeftTableViewWidth-10-10, SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT)
                                             collectionViewLayout:flowLayout];
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
    }
    return _collectionView;
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMallClassifyLeftTableViewCell *cell = [XYMallClassifyLeftTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.selectedModel = self.categoryModels[indexPath.row];
    [self.collectionView reloadData];
    ///在这进行刷新刷新collection的操作
    //1.刷新collection数据源

    //2.collection reloaddata
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
    return self.selectedModel.child.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYMallClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYMallClassifyCollectionViewCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:KThumbnailStringURL([self.selectedModel.child[indexPath.row] objectForKey:@"categoryImgURL"]) placeholderImage:IMAGE_NAME(@"首页课程图片")];
//    cell.nameLabel.text = [self.selectedModel.child[indexPath.row] objectForKey:@"categoryName"];
    cell.nameLabel.text = @"炒货";
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Window_W - _kLeftTableViewWidth -10-10) / 3,
                      (Window_W - _kLeftTableViewWidth - 10-10) / 3 + 15);
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
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Window_W - _kLeftTableViewWidth, 48);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SH_MallSubclassificationViewController *vc = [SH_MallSubclassificationViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
