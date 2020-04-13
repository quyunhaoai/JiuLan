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
@interface CCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView    *collectionView;
@property (nonatomic,strong) CCHomeHeaderView               *headView;
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation CCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSearchNavBar];
    
    [self layoutCollectionView];
    XYWeakSelf;
    [self.searBarView.rightBtn addTapGestureWithBlock:^(UIView *gestureView) {
        CCMessageViewController *vc = [CCMessageViewController new];
        [weakSelf.navigationController pushViewController:vc
                                             animated:YES];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NKAlertView *alert = [[NKAlertView alloc] init];
    alert.contentView = [[CCActivityView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304+60)];
    alert.hiddenWhenTapBG = YES;
    alert.type = NKAlertViewTypeDef;
    [alert show];
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
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.collectionView registerNib:[UINib nibWithNibName:CCHeaderCollectionReusableView.className bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:CCBigCommendCollectionViewCell.class forCellWithReuseIdentifier:@"ccbigCell"];
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
                [self.navigationController pushViewController:vc animated:YES];
//                NKAlertView *alert = [[NKAlertView alloc] init];
//                alert.contentView = [[CCActivityView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304+60)];
//                alert.hiddenWhenTapBG = YES;
//                alert.type = NKAlertViewTypeDef;
//                [alert show];
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
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCBigCommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccbigCell" forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.section == 2){
        CCEverDayTeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:everDayCell forIndexPath:indexPath];
        XYWeakSelf;
        [cell.sureSales addTapGestureWithBlock:^(UIView *gestureView) {
            CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
   CCCommodityCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellInder forIndexPath:indexPath];
    cell.titleLab.text = [NSString stringWithFormat:@"indexPath.row%ld",indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(Window_W, 198);
    } else if (indexPath.section == 2){
        return CGSizeMake(Window_W-20, 120);
    }
    return CGSizeMake((Window_W-30)/2, 198);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        
    } else {
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
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
                CCActiveDivViewController *vc = [CCActiveDivViewController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
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
    return CGSizeMake(Window_W, 53);
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
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}


    
    
@end
