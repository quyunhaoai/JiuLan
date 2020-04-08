//
//  CCCustomTextFiled.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCustomTextFiled.h"

@implementation CCCustomTextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
CGRect rect = [super leftViewRectForBounds:bounds];

    // 这个注释掉的是可以的
 rect = CGRectMake(rect.origin.x + 12, rect.origin.y, rect.size.width, rect.size.height);
return rect;

//没有注释的这个无论数值怎么调都不行
// UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
//
// return UIEdgeInsetsInsetRect(rect, insets);

}
@end
