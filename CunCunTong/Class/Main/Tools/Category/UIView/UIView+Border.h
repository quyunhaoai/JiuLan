//
//  UIView+Border.h
//  KKToydayNews
//
//  Created by finger on 2017/10/19.
//  Copyright © 2017年 finger. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KKBorderType){
    KKBorderTypeNone = 0,
    KKBorderTypeLeft = 1 << 0,
    KKBorderTypeTop = 1 << 1,
    KKBorderTypeRight = 1 << 2,
    KKBorderTypeBottom = 1 << 3,
    KKBorderTypeAll = 1 << 4,
} ;


@interface UIView(Border)
@property(nonatomic)UIColor *borderColor;
@property(nonatomic,assign)KKBorderType borderType;
@property(nonatomic,assign)CGFloat borderThickness;
//@interface UIView (Add)

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;

//@end
//
//@implementation UIView (Add)
//
//
//- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity {
//    self.layer.cornerRadius = radius;
//    if (shadow) {
//        self.layer.shadowColor = KKColor(178, 178, 178, 0.3).CGColor;
//        self.layer.shadowOpacity = opacity;
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowRadius = 4;
//        self.layer.shouldRasterize = NO;
//        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:radius] CGPath];
//    }
//    self.layer.masksToBounds = !shadow;
//}

@end
