//
//  CCSmallShopHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSmallShopHeadView.h"
#import "CCMubltylabView.h"
@implementation CCSmallShopHeadView
{
    UIView *contentView;
    UIView *contentView2;
    CCMubltylabView *subContentView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"实时概况图标")];
         
        view;
    });
    
    [self addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.mas_equalTo(self).mas_offset(9);
    }];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"实时概况";
        view ;

    });
    [self addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(31);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 4;
    contentView.backgroundColor = kWhiteColor;
    [self addSubview:contentView];
    [contentView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(33);
        make.left.mas_equalTo(self).mas_offset(12);
        make.right.mas_equalTo(self).mas_offset(-12);
        make.height.mas_equalTo(94);
    }];
    for (int i = 0; i <3; i ++) {
        subContentView = [[CCMubltylabView alloc] init];
        subContentView.tag = i;
        subContentView.userInteractionEnabled = YES;
        XYWeakSelf;
        [subContentView addTapGestureWithBlock:^(UIView *gestureView) {
            if (weakSelf.clcikView) {
                weakSelf.clcikView(gestureView.tag);
            }
        }];
        [contentView addSubview:subContentView];
        [subContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView);
            make.height.mas_equalTo(contentView);
            make.left.mas_equalTo((Window_W-24)/3*i);
            make.width.mas_equalTo((Window_W-24)/3);
        }];
    }
    UIImageView *areaIcon1 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"预警图标")];
         
        view;
    });
    
    [self addSubview:areaIcon1];
    [areaIcon1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.mas_equalTo(contentView.mas_bottom).mas_offset(9);
    }];
    UILabel *nameLab1 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"实时概况";
        view ;

    });
    [self addSubview:nameLab1];
    [nameLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(31);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.top.mas_equalTo(contentView.mas_bottom).mas_offset(10);
    }];
 
    contentView2 = [[UIView alloc] init];
    contentView2.layer.masksToBounds = YES;
    contentView2.layer.cornerRadius = 4;
    contentView2.backgroundColor = kWhiteColor;
    [self addSubview:contentView2];
    [contentView2 masUpdateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLab1.mas_bottom).mas_offset(14);
        make.left.mas_equalTo(self).mas_offset(12);
        make.right.mas_equalTo(self).mas_offset(-12);
        make.height.mas_equalTo(@61);
    }];
     NSMutableArray *tolAry = [NSMutableArray new];
     for (int i = 0; i <3; i ++) {
         UILabel *view = [UILabel new];
         view.font = STFont(16);
         view.textColor = krgb(255,165,0);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.textAlignment = NSTextAlignmentCenter;
         view.text = @"0";
         [contentView2 addSubview:view];
         [tolAry addObject:view];
     }
     [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
     [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@0).mas_offset(10);
         make.height.equalTo(@14);
     }];
    
    NSMutableArray *tolAry111 = [NSMutableArray new];
    for (int i = 0; i <3; i ++) {
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"低库存商品";
        [contentView2 addSubview:view];
        [tolAry111 addObject:view];
    }
    [tolAry111 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(-10);
        make.height.equalTo(@23);
    }];
}



@end
