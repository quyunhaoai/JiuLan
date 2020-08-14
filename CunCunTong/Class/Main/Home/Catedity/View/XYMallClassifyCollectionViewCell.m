//
//  XYMallClassifyCollectionViewCell.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "XYMallClassifyCollectionViewCell.h"
@interface XYMallClassifyCollectionViewCell ()


@end

@implementation XYMallClassifyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kWhiteColor;
        [self imageV];
        [self nameLabel];
        
    }
    return self;
}

- (UIImageView *)imageV {
    
    if (_imageV == nil) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, self.frame.size.width - 24, self.frame.size.width - 24)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
        self.imageV.clipsToBounds = YES;
        [self.contentView addSubview:self.imageV];
    }
    return _imageV;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 12+self.frame.size.width-24+5, self.frame.size.width - 4, 15)];
        self.nameLabel.font = FONT_13;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.textColor = COLOR_333333;
    }
    return _nameLabel;
}

- (void)setModel:(SH_WithDrawalsCategoryModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:IMAGE_NAME(@"")];
    self.nameLabel.text = _model.name;
}
@end
