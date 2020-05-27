//
//  LWExtendButton.m
//  YuJianPro
//
//  Created by xy on 2017/4/21.
//  Copyright © 2017年 HengPin. All rights reserved.
//

#import "LWExtendButton.h"

@implementation LWExtendButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    CGRect bounds = self.bounds;
    CGFloat widthDelta = 48.0 - bounds.size.width;
    CGFloat heightDelta = 48.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5* widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}


@end
