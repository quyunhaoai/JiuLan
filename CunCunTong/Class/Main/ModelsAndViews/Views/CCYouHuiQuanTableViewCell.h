//
//  CCYouHuiQuanTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCYouHuiQuanTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;


@property (weak, nonatomic) IBOutlet UIButton *taskBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;









+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
