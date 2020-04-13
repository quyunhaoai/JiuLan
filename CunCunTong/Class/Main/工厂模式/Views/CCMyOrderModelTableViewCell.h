//
//  CCMyOrderModelTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMyOrderModelTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentbgView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *subTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *singePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLab;
@property (weak, nonatomic) IBOutlet UILabel *salesTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeft;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
