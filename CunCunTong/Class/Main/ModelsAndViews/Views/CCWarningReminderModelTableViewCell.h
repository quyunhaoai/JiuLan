//
//  CCWarningReminderModelTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWarningReminderModelTableViewCell : BaseTableViewCell
+ (CGFloat)height;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewsss;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *noRead;
@property (weak, nonatomic) IBOutlet UIView *lineView;



@end

NS_ASSUME_NONNULL_END
