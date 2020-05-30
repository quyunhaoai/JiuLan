//
//  CCCheXiaoCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGoodsDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCCheXiaoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)CCGoodsDetail *model;

@property (nonatomic, weak) IBOutlet UIImageView  *headImage;
@property (nonatomic, weak)IBOutlet UILabel  *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel  *priceLbel;


@property (nonatomic,weak)IBOutlet UIButton *addBtn;
@property (nonatomic, strong) UIView *lineview;
@end

NS_ASSUME_NONNULL_END
