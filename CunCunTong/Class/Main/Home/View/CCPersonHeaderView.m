//
//  CCPersonHeaderView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "KKButton/KKButton.h"
#import "CCPersonHeaderView.h"
#import "ImageTitleButton.h"
@interface CCPersonHeaderView ()



@end
@implementation CCPersonHeaderView

- (void)setupUI {
    [self addSubview:self.bgImageView];
    [self addSubview:self.headerImage];
    [self addSubview:self.nameStrLab];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(184);
        make.top.right.left.mas_equalTo(self);
    }];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(52);
        make.top.mas_equalTo(self).mas_offset(56);
    }];
    [self.nameStrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.headerImage.mas_bottom).mas_offset(11);
    }];
    
    //Base style for 矩形 3 拷贝 2
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(10, 146, kWidth(355), 109)];
    style.layer.cornerRadius = 10;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [[CCTools sharedInstance] addShadowToView:style withColor:KKColor(0, 0, 0, 0.15)];
    [self addSubview:style];
    
    UILabel *titleLab = [[UILabel alloc] init];
    [style addSubview:titleLab];
    titleLab.text = @"我的订单";
    titleLab.font = STFont(15);
    titleLab.textColor = krgb(51, 51, 51);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(style).mas_offset(10);
        make.top.mas_equalTo(style).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    KKButton *checkBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setTitleColor:krgb(153, 153, 153) forState:UIControlStateNormal];
    [checkBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkBtn.titleLabel setFont:STFont(13)];
    [checkBtn setImage:IMAGE_NAME(@"右箭头灰") forState:UIControlStateNormal];
    [style addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(style).mas_offset(-10);
    }];
    [checkBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    self.moreButtonView = checkBtn;
    //Base line for 矩形 11
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.layer.backgroundColor = [[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f] CGColor];
    line.alpha = 1;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
    }];
    
    NSArray *arr = @[@"待付款",@"待发货",@"待收货",@"退货中",@"车销"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 0)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
//        退换货图标
        NSString *str = [NSString stringWithFormat:@"%@图标",arr[i]];
        if ([arr[i] isEqualToString:@"退货中"]) {
            str = @"退换货图标";
        }
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [style addSubview:button];
        [tolAry addObject:button];
        if (i == 0) {
            self.oneImage = button;
        } else if(i == 1) {
            self.towImage = button;
        } else if (i == 2) {
            self.threeImage = button;
        }
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(0);
        make.height.equalTo(@54);
    }];
    self.toaArray = tolAry.copy;
    UIView *bageView = [[UIView alloc] init];
    [self addSubview:bageView];
    [bageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(self.oneImage.mas_right).mas_offset(-12);
        make.top.mas_equalTo(self.oneImage.mas_top).mas_offset(3);
    }];
    self.oneImageview = bageView;
    UIView *bageView2 = [[UIView alloc] init];
    [self addSubview:bageView2];
    [bageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(self.towImage.mas_right).mas_offset(-12);
        make.top.mas_equalTo(self.towImage.mas_top).mas_offset(3);
    }];
    self.towImagevvv = bageView2;
    UIView *bageView3 = [[UIView alloc] init];
    [self addSubview:bageView3];
    [bageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.right.mas_equalTo(self.threeImage.mas_right).mas_offset(-12);
        make.top.mas_equalTo(self.threeImage.mas_top).mas_offset(3);
    }];
    self.threeImagevvv = bageView3;
}
- (void)buttonClick:(UIButton *)button {
    if (self.click) {
        self.click(button.tag);
    }
}
#pragma Get
- (UILabel *)nameStrLab {
    if (!_nameStrLab) {
        _nameStrLab = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
//            设置显示的内容
//        label.text = @"昵称";
//            设置字体颜色
        label.textColor = [UIColor whiteColor];
//            设置字体和字号
        label.font = [UIFont systemFontOfSize:15];
//            设置多行显示
        label.numberOfLines = 1;
//            设置换行的方式
        label.lineBreakMode = NSLineBreakByCharWrapping;
//            设置对齐方式
        label.textAlignment = NSTextAlignmentCenter;

        label;
        });
    }
    return _nameStrLab;
}
- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.layer.cornerRadius = 26;
            view.layer.masksToBounds = YES ;
            view ;
        });
    }
    return _headerImage;
}
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"backgrougendImage"];
            view ;
        });
    }
    return _bgImageView;
}






@end
