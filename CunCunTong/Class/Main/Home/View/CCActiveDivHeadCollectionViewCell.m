

//
//  CCActiveDivHeadCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCActiveDivHeadCollectionViewCell.h"

@implementation CCActiveDivHeadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //199-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥199.00"];
    [attributedString addAttribute:NSFontAttributeName value:FONT_11 range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //199-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:FONT_15 range:NSMakeRange(1, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, 6)];
    self.subLab.attributedText = attributedString;
    [self.bgView setCornerRadius:10 withShadow:YES withOpacity:0.5];
}

@end
