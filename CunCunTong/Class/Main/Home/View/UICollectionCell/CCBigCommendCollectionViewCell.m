//
//  CCBigCommendCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBigCommendCollectionViewCell.h"


@implementation CCBigCommendCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _collectionLeftView = [[CCCollectionViewLeftView alloc] init];
    [self addSubview:self.collectionLeftView];
    [self.collectionLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}


@end
