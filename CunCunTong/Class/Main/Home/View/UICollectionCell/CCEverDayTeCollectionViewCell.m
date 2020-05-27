//
//  CCEverDayTeCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCEverDayTeCollectionViewCell.h"

@implementation CCEverDayTeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //Base style for 分割线1
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(10, 1165, 355, 1)];
    style.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 0.08;
    [self.contentView addSubview:style];
    [style mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
   self.contentView.layer.cornerRadius =2.0f;
   self.contentView.layer.borderWidth =1.0f;
   self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
   self.contentView.layer.masksToBounds =YES;
//
   self.layer.shadowColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:0.18f].CGColor;
   self.layer.shadowOffset = CGSizeMake(0,2.0f);
   self.layer.shadowRadius =2.0f;
   self.layer.shadowOpacity =1.0f;
   self.layer.masksToBounds =NO;
//   self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
    
 /*
    //Base style for 矩形 1103
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(10, 1045, 355, 361)];
    style.layer.cornerRadius = 10;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;

    //Shadow 0 for 矩形 1103
    CALayer *shadowLayer0 = [[CALayer alloc] init];
    shadowLayer0.frame = style.bounds;
    shadowLayer0.shadowColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:0.18f].CGColor;
    shadowLayer0.shadowOpacity = 1;
    shadowLayer0.shadowOffset = CGSizeMake(0, 0);
    shadowLayer0.shadowRadius = 2;
    CGFloat shadowSize0 = -1;
    CGRect shadowSpreadRect0 = CGRectMake(-shadowSize0, -shadowSize0, style.bounds.size.width+shadowSize0*2, style.bounds.size.height+shadowSize0*2);
    CGFloat shadowSpreadRadius0 =  style.layer.cornerRadius == 0 ? 0 : style.layer.cornerRadius+shadowSize0;
    UIBezierPath *shadowPath0 = [UIBezierPath bezierPathWithRoundedRect:shadowSpreadRect0 cornerRadius:shadowSpreadRadius0];
    shadowLayer0.shadowPath = shadowPath0.CGPath;
    [style.layer addSublayer:shadowLayer0];
  */
}

@end
