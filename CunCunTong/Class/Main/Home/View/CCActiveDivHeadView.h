//
//  CCActiveDivHeadView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCActiveDivHeadView : CCBaseView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectView; //  视图
@property (strong, nonatomic) NSMutableArray *dataArray;  //  数组
@end

NS_ASSUME_NONNULL_END
