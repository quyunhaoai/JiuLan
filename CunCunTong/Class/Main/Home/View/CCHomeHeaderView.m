//
//  CCHomeHeaderView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCHomeHeaderView.h"
#import "ImageTitleButton.h"
#import "SDCycleScrollView.h"
@interface CCHomeHeaderView()
//@property (strong, nonatomic) SDCycleScrollView *bgImage;

@end

@implementation CCHomeHeaderView


- (void)setupUI {
//    self.backgroundColor = kRedColor;
    [self addSubview:self.bgImage];
    
    self.buttosArray = [NSArray array];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Window_W, kWidth(160)));
    }];
    
    //Base style for 矩形 1092
    UIView *style = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(10, 207, 355, 102)
    style.layer.cornerRadius = 10;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [self addSubview:style];
    [style mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.top.mas_equalTo(self.bgImage.mas_bottom).mas_offset(-17);
        make.height.mas_equalTo(102);
    }];
    [[CCTools sharedInstance] addShadowToView:style withColor:KKColor(85,85,85,0.18)];
    
    
    NSArray *arr = @[@"每日特价",@"活动专区",@"热门推荐",@"商品分类"];
    NSArray *icon = @[@"特价图标",@"推荐图标",@"特价图标",@"catetiy_icon"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 0)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTag:i];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
//        退换货图标
        NSString *str = [NSString stringWithFormat:@"%@",icon[i]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [style addSubview:button];
        [tolAry addObject:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0).mas_offset(-15);
        make.height.equalTo(@54);
    }];
    self.buttosArray = [tolAry copy];
    
}
- (void)buttonClick:(UIButton *)button {
    if (self.buttonAction) {
        self.buttonAction(button.tag);
    }
}

#pragma mark  -  GET

- (SDCycleScrollView *)bgImage {
    if (!_bgImage) {
        _bgImage = ({
            SDCycleScrollView *view = [[SDCycleScrollView alloc] init];
            view.showPageControl = NO;
//            view.clickItemOperationBlock = ^(NSInteger currentIndex) {
//
//            };
//            view.placeholderImage = IMAGE_NAME(@"banner图");
            view ;
        });
    }
    return _bgImage;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    for (NSDictionary *dict in _dataArray) {
        
    }
}

@end
