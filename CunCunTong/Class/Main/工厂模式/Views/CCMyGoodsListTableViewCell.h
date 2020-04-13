//
//  CCMyGoodsListTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMyGoodsListTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *pinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *pinpaiLab;
@property (weak, nonatomic) IBOutlet UILabel *gugeLab;
@property (weak, nonatomic) IBOutlet UILabel *inPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *salesPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *inNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;

@property (weak, nonatomic) IBOutlet UILabel *botttomTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitle2Lab;






+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
