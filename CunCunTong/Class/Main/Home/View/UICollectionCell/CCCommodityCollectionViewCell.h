//
//  CCCommodityCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGoodsDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCCommodityCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *manJianLab;
@property (nonatomic, strong) CCGoodsDetail *model;
@property (weak, nonatomic) IBOutlet UIImageView *manjianBgImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manjianBGWidthConstraint;
@end

NS_ASSUME_NONNULL_END
