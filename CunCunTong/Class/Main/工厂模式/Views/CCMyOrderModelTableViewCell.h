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

+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
