//
//  SH_MallSubclassificationSelectButton.m
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "SH_MallSubclassificationSelectButton.h"
@interface SH_MallSubclassificationSelectButton ()

@end

@implementation SH_MallSubclassificationSelectButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.tLabel];
    [self addSubview:self.imgView];
}

- (UILabel *)tLabel{
    if (!_tLabel) {
        _tLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 14, 35, 21)];
        _tLabel.font = FONT_15;
    }
    return _tLabel;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MaxX(self.tLabel.frame), 12, 24, 24)];
    }
    return _imgView;
}

@end
