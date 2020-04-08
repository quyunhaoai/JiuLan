//
//  CCHeaderCollectionReusableView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "KKButton.h"
#import "CCHeaderCollectionReusableView.h"

@implementation CCHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];

    
    self.titleLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}
@end
