//
//  CCSureOrderTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCSureOrderTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
