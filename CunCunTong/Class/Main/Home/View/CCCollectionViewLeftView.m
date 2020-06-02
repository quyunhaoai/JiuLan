//
//  CCCollectionViewLeftView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *cellReuseIdentifier = @"STRecommonPersonCollectionViewCell";
#import "CCCommodDetaildViewController.h"
#import "CCCommendityNoQuanCollectionViewCell.h"
#import "CCCollectionViewLeftView.h"
#import "CCGoodsDetail.h"
@implementation CCCollectionViewLeftView

- (void)setupUI {
    [self addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(0);
    }];
}

//- (NSMutableArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray =[NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
//    }
//    return _dataArray;
//}
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.collectView reloadData];
}
- (void)moreBtnClicked:(UIButton *)button {
    
    
}

#pragma mark -- @property

- (UICollectionView *)collectView{
    if(!_collectView){
        _collectView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.delegate= self;
            view.dataSource= self;
            view.backgroundColor = kWhiteColor;
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
            [view registerNib:[UINib nibWithNibName:CCCommendityNoQuanCollectionViewCell.className bundle:[NSBundle mainBundle] ] forCellWithReuseIdentifier:cellReuseIdentifier];
            view;
        });
    }
    return _collectView;
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CCCommendityNoQuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.model = [CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth(155), 174);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
    CCGoodsDetail *model =[CCGoodsDetail modelWithJSON:self.dataArray[indexPath.row]];;
    vc.goodsID = STRING_FROM_INTAGER(model.ccid);
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
@end
