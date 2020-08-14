//
//  CCCustomMapTipView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCustomMapTipView.h"

@implementation CCCustomMapTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 86+18, 25+16);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.BgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 86+18, 25)];
        self.BgImage.contentMode = UIViewContentModeScaleAspectFill;
        self.BgImage.clipsToBounds = YES;
        self.BgImage.image = IMAGE_NAME(@"白底");
        [self addSubview:self.BgImage];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(18,
                                                                   0,
                                                                   86,
                                                                   20)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentLeft;
        self.nameLabel.textColor        = COLOR_333333;
        self.nameLabel.font             = [UIFont systemFontOfSize:11.f];
//        self.nameLabel.text = @"郑州市仓储中心";
        [self addSubview:self.nameLabel];
        
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 18, 15)];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImage.clipsToBounds = YES;
//        self.iconImage.image = IMAGE_NAME(@"红低");
        [self addSubview:self.iconImage];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 18, 15)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = kWhiteColor;
        self.titleLabel.font = FONT_11;
//        self.titleLabel.text = @"发";
        [self addSubview:self.titleLabel];
        
        self.locationImage = [[UIImageView alloc] initWithFrame:CGRectMake((86+18)/2, 25, 11, 16)];
//        self.locationImage.image = IMAGE_NAME(@"地址红");
        [self addSubview:self.locationImage];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = kRedColor;
}
@end
