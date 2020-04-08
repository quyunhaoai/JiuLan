//
//  CCBalanceTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBalanceTableViewCell : BaseTableViewCell
+ (CGFloat )height;
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;

@end

NS_ASSUME_NONNULL_END
