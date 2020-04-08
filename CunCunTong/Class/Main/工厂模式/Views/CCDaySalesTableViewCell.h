//
//  CCDaySalesTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCDaySalesTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentBgview;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;

@property (weak, nonatomic) IBOutlet UILabel *buyTepyLab;

@property (weak, nonatomic) IBOutlet UILabel *buyNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *fillDateLab;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (weak, nonatomic) IBOutlet UIButton *zhanCunBtn;





+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
