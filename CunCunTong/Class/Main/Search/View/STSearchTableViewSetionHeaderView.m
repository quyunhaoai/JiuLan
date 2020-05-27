//
//  STSearchTableViewSetionHeaderView.m
//  StudyOC
//
//  Created by 光引科技 on 2019/10/21.
//  Copyright © 2019 光引科技. All rights reserved.
//

#import "STSearchTableViewSetionHeaderView.h"
#define itemButtonWidth 24
@implementation STSearchTableViewSetionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, (40-itemButtonWidth)/2.0, Window_W-itemButtonWidth,24)];
        self.itemLabel.font = FONT_16;
        self.itemLabel.textColor = COLOR_333333;
        [self addSubview:self.itemLabel];
        self.itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.itemButton.frame =CGRectMake(Window_W-30-12, (40-itemButtonWidth)/2.0, itemButtonWidth, itemButtonWidth);
        [self.itemButton setImage:IMAGE_NAME(@"删除图标") forState:UIControlStateNormal];
        [self addSubview:self.itemButton];
    }
    return self;
}

@end
