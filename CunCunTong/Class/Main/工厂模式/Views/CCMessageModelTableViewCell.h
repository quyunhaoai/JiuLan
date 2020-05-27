//
//  CCMessageModelTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCMessageModelTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet KKButton *lookDetailBtn;


+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
