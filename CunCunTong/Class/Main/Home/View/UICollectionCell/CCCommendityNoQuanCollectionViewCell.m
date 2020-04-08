//
//  CCCommendityNoQuanCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommendityNoQuanCollectionViewCell.h"

@implementation CCCommendityNoQuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.1)];
}

@end
