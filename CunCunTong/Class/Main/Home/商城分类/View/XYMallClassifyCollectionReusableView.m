//
//  XYMallClassifyCollectionReusableView.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "XYMallClassifyCollectionReusableView.h"

@implementation XYMallClassifyCollectionReusableView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = COLOR_f5f5f5;
        [self titleLab];
    }
    return self;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_333333;
            view.font = FONT_15;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view.text = @"零食";
            view ;
        });
    }
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(kWidth(14));
        make.bottom.mas_equalTo(self).mas_offset(-kWidth(14));
    }];
    return _titleLab;
}


@end
