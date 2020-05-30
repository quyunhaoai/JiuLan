//
//  CCEverDayTeCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGoodsDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *sureSales;
@property (strong, nonatomic) CCGoodsDetail *model;
@property (weak, nonatomic) IBOutlet UIImageView *icon_iamgeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *deleteLab;


@end

NS_ASSUME_NONNULL_END
