//
//  CCActivityView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCActivityView.h"
#import "NKAlertView.h"
#import "CCCommodDetaildViewController.h"
#import "CCMallSubClassViewController.h"
#import "CCTabbarViewController.h"
#import "CCBaseNavController.h"
#import "CCActiveDivViewController.h"
@implementation CCActivityView

- (void)setupUI {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-47)];
    headView.backgroundColor = kWhiteColor;
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 10;
    [self addSubview:headView];

    UIImageView *imageview = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleToFill;
        view.userInteractionEnabled = YES ;
        view;
    });
    [headView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headView);
    }];
    XYWeakSelf;
    [imageview addTapGestureWithBlock:^(UIView *gestureView) {
        [weakSelf commentBtnClick:[UIButton new]];
    }];
    self.activiteImage = imageview;
    UIButton *closeBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setBackgroundImage:IMAGE_NAME(@"叉号白色") forState:UIControlStateNormal];
        [view setUserInteractionEnabled:YES];
        [view setTag:222];
         [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(28);
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(19);
    }];
}

- (void)commentBtnClick:(UIButton *)button {
    if (button.tag == 222) {
        NKAlertView *vvv =(NKAlertView *)button.superview.superview;
        [vvv hide];
    } else {
        switch (self.Model.types) {
            case 0://0: 商品， 1： 分类， 2：无链接
            {
                CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
                vc.goodsID = self.Model.center_goods_id;
                CCTabbarViewController *tab = [CCTabbarViewController getTabBarController];
                CCBaseNavController *vvvcccc = [tab viewControllers][0];
                [vvvcccc pushViewController:vc animated:YES];
            
            }
            break;
            case 1:
            {
                CCMallSubClassViewController *vc = [CCMallSubClassViewController new];
                vc.categoryID = self.Model.category_id;
                CCTabbarViewController *tab = [CCTabbarViewController getTabBarController];
                CCBaseNavController *vvvcccc = [tab viewControllers][0];
                [vvvcccc pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                CCActiveDivViewController *vc = [CCActiveDivViewController new];
                CCTabbarViewController *tab = [CCTabbarViewController getTabBarController];
                CCBaseNavController *vvvcccc = [tab viewControllers][0];
                [vvvcccc pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (void)setModel:(CCActiveModel *)Model {
    _Model = Model;
    [_activiteImage sd_setImageWithURL:[NSURL URLWithString:_Model.image] placeholderImage:IMAGE_NAME(@"")];
    
    
    
    
}



@end
