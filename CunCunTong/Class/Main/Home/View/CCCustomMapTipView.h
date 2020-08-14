//
//  CCCustomMapTipView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

@import UIKit;
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCCustomMapTipView : MAAnnotationView
@property (strong, nonatomic) UIImageView *BgImage;
@property (strong, nonatomic) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *locationImage;

@end

NS_ASSUME_NONNULL_END
