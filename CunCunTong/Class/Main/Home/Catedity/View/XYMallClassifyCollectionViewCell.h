//
//  XYMallClassifyCollectionViewCell.h
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SH_MallCategoryModel.h"
/**
 商城分类右边的Collection的cell
 */
@interface XYMallClassifyCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) SH_WithDrawalsCategoryModel *model;
@end
