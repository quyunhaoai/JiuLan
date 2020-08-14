//
//  CCMallSubClassCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/5/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGoodsDetail.h"
#import "GBTagListView2.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCMallSubClassCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView  *headImage;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *priceLbel;

@property (nonatomic, strong) CCGoodsDetail *model;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic, strong) UIView *lineview;

@property (strong, nonatomic) UILabel *isSelfSupportLab;
@property (strong, nonatomic) UIImageView *manjianImage;
@property (strong, nonatomic) UILabel *manjianLab;  
@property (weak, nonatomic) id<KKCommonDelegate>delegate;

@property (strong, nonatomic) GBTagListView2 *tagContentView; // 


@end

NS_ASSUME_NONNULL_END
