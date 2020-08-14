//
//  CCPersonCenterTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCPersonCenterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageVice;
@property (weak, nonatomic) IBOutlet UILabel *subTitlelab;
@end

NS_ASSUME_NONNULL_END
