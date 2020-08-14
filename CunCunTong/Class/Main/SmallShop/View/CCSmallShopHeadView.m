//
//  CCSmallShopHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSmallShopHeadView.h"
#import "CCMubltylabView.h"
#import "ImageTitleButton.h"
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
        subContentView.tag = i+1000;
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
        [view setImage:IMAGE_NAME(@"预警图标-1")];
         
        view;
    });
    UIView *line = [UIView new];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [contentView addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView).mas_offset((Window_W-24)/3);
        make.bottom.mas_equalTo(contentView).mas_offset(-10);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(contentView).mas_offset(10);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorHex(0xf7f7f7);
    [contentView addSubview:line2];
    [line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView).mas_offset((Window_W-24)/3*2);
        make.bottom.mas_equalTo(contentView).mas_offset(-10);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(contentView).mas_offset(10);
    }];
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
        view.text = @"库存预警";
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
         view.tag = 200+i;
         view.text = @"0";
         [contentView2 addSubview:view];
         [tolAry addObject:view];
     }
     [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
     [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@0).mas_offset(10);
         make.height.equalTo(@14);
     }];
    NSArray *title2Arr = @[@"高库存商品",@"低库存商品",@"临期商品"];
    NSMutableArray *tolAry111 = [NSMutableArray new];
    for (int i = 0; i <3; i ++) {
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.textAlignment = NSTextAlignmentCenter;
        view.text = title2Arr[i];
        view.tag = i+100;
        [contentView2 addSubview:view];
        [tolAry111 addObject:view];
    }
    [tolAry111 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(-10);
        make.height.equalTo(@23);
    }];
    
  
    NSMutableArray *tolAry3 = [NSMutableArray new];
    for (int i = 0; i <title2Arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 0)];
        [button setTag:i+1100];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView2 addSubview:button];
        [tolAry3 addObject:button];
    }
    [tolAry3 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(0);
        make.height.equalTo(@54);
    }];
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorHex(0xf7f7f7);
    [contentView2 addSubview:line3];
    [line3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView2).mas_offset((Window_W-24)/3);
        make.bottom.mas_equalTo(contentView2).mas_offset(-10);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(contentView2).mas_offset(10);
    }];
    UIView *line4 = [UIView new];
    line4.backgroundColor = UIColorHex(0xf7f7f7);
    [contentView2 addSubview:line4];
    [line4 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView2).mas_offset((Window_W-24)/3*2);
        make.bottom.mas_equalTo(contentView2).mas_offset(-10);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(contentView2).mas_offset(10);
    }];
}
   
- (void)buttonClick:(UIButton *)button {
    if (self.clcikView) {
        self.clcikView(button.tag);
    }
}
- (void)setModel:(CClittleInfoModel *)model {
    _model = model;
    CCMubltylabView *sub0view = (CCMubltylabView *)[contentView viewWithTag:1000];
    CCMubltylabView *sub1view = (CCMubltylabView *)[contentView viewWithTag:1001];
    CCMubltylabView *sub2view = (CCMubltylabView *)[contentView viewWithTag:1002];
    
    sub0view.title1Lab.text = STRING_FROM_INTAGER(model.in_count);
    sub0view.title3Lab.text = STRING_FROM_INTAGER(model.in_price);
    sub0view.title2Lab.text = @"进货数量";
    sub0view.title4Lab.text = @"进货金额";
    sub1view.title1Lab.text = STRING_FROM_INTAGER(model.out_count);
    sub1view.title3Lab.text = STRING_FROM_INTAGER(model.out_price);
    sub1view.title2Lab.text = @"销售数量";
    sub1view.title4Lab.text = @"销售金额";
    sub2view.title1Lab.text = STRING_FROM_INTAGER(model.now_count);
    sub2view.title3Lab.text = STRING_FROM_INTAGER(model.now_price);
    sub2view.title2Lab.text = @"库存数量";
    sub2view.title4Lab.text = @"库存金额";
    UILabel *lab = (UILabel *)[contentView2 viewWithTag:202];
    lab.text = STRING_FROM_INTAGER(model.near_count);
    UILabel *lab1 = (UILabel *)[contentView2 viewWithTag:201];
    lab1.text = STRING_FROM_INTAGER(model.down_count);
    UILabel *lab2 = (UILabel *)[contentView2 viewWithTag:200];
    lab2.text = STRING_FROM_INTAGER(model.up_count);
}

@end
