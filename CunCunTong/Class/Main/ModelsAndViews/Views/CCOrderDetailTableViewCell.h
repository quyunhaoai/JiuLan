//
//  CCOrderDetailTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDetailTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *outBtn;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
