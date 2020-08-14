//
//  CCGoodsDetailTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCGoodsDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *subLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightIcon;

@property (weak, nonatomic) IBOutlet UIImageView *jiantouimageView;

@property (weak, nonatomic) IBOutlet UILabel *strokLab;


+ (CGFloat )height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleCenterConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleConstraint;


@end

NS_ASSUME_NONNULL_END
