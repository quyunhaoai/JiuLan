//
//  CCCustomMapTip2View.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCustomMapTip2View.h"

@implementation CCCustomMapTip2View

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 16, 14);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.BgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 16, 14)];
        self.BgImage.contentMode = UIViewContentModeScaleAspectFill;
        self.BgImage.clipsToBounds = YES;
        self.BgImage.image = IMAGE_NAME(@"物流汽车图标");
        [self addSubview:self.BgImage];
    }
    
    return self;
}
@end
