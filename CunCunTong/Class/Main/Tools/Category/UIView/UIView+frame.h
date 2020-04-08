//
//  UIView+frame.h
//  xibLearn
//
//  Created by hao on 2017/11/27.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)
@property CGFloat x;
@property CGFloat y;
@property CGFloat width;
@property CGFloat height;


@property CGFloat center_x;
@property CGFloat center_y;

+ (instancetype)viewFromXib;


@end
