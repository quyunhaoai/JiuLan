//
//  UIView+frame.m
//  xibLearn
//
//  Created by hao on 2017/11/27.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
-(void)setx:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)sety:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setcenter_x:(CGFloat)center_x{
    CGPoint center = self.center;
    center.x = center_x;
    self.center = center;
}
-(CGFloat)center_x
{
    return self.center.x;
}
-(void)setcenter_y:(CGFloat)center_y
{
    CGPoint center = self.center;
    center.y = center_y;
    self.center = center;
    
}
-(CGFloat)center_y
{
    return self.center.y;
}
-(void)setwidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    
    
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setheight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
@end
