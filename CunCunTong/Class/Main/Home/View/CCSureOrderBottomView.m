//
//  CCSureOrderBottomView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSureOrderBottomView.h"
#import "KKButton.h"
@implementation CCSureOrderBottomView


- (void)setupUI {
    self.backgroundColor = kWhiteColor;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"支付方式";
        view ;
    });
    [self addSubview:titlelab];
    [titlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.top.mas_equalTo(self).mas_offset(22);
    }];
    
    UIView *zhanHuView = [[UIView alloc] init];
    [self addSubview:zhanHuView];
    [zhanHuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titlelab.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [[CCTools sharedInstance] addborderToView:zhanHuView width:1.0 color:COLOR_e5e5e5];
    UIImageView *iconIamgeView = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"未选中圆点图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [zhanHuView addSubview:iconIamgeView];
    [iconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(15);
        make.height.width.mas_equalTo(13);
    }];
    UILabel *zhuanghutitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"账户余额";
        view ;
    });
    [zhanHuView addSubview:zhuanghutitlelab];
    [zhuanghutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
    }];

    UILabel *yuEtitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"可用余额：";
        view ;
    });
    [self addSubview:yuEtitlelab];
    [yuEtitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 14));
        make.top.mas_equalTo(zhanHuView.mas_bottom).mas_offset(10);
    }];
    UIButton *chongzhiBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitleColor:kMainColor forState:UIControlStateNormal];
        [view setTitle:@"充值" forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_15];
        view.tag = 3;
        [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self addSubview:chongzhiBtn];
    [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yuEtitlelab.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.centerY.mas_equalTo(yuEtitlelab).mas_offset(0);
    }];
    
    KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 11;
    [rightBtn setTitle:@"其他" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"上箭头") forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yuEtitlelab.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.centerX.mas_equalTo(self).mas_offset(0);
    }];
    [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    UIView *weixinView = [[UIView alloc] init];
    [self addSubview:weixinView];
    [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightBtn.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [[CCTools sharedInstance] addborderToView:weixinView width:1.0 color:COLOR_e5e5e5];
    UIImageView *iconIamgeView1 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"未选中圆点图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [weixinView addSubview:iconIamgeView1];
    [iconIamgeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weixinView).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(15);
        make.height.width.mas_equalTo(13);
    }];
    UILabel *weixintitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"微信支付";
        view ;
    });
    [weixinView addSubview:weixintitlelab];
    [weixintitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView1.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(weixinView).mas_offset(0);
    }];
    
    UIView *zhifubaoView = [[UIView alloc] init];
    [self addSubview:zhifubaoView];
    [zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weixinView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [[CCTools sharedInstance] addborderToView:zhifubaoView width:1.0 color:COLOR_e5e5e5];
    UIImageView *iconIamgeView2 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"未选中圆点图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [zhifubaoView addSubview:iconIamgeView2];
    [iconIamgeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(15);
        make.height.width.mas_equalTo(13);
    }];
    UILabel *zhifubaotitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"支付宝支付";
        view ;
    });
    [zhifubaoView addSubview:zhifubaotitlelab];
    [zhifubaotitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView2.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
    }];
    
    UIView *yinlianzhifuView = [[UIView alloc] init];
    [self addSubview:yinlianzhifuView];
    [yinlianzhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(zhifubaoView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [[CCTools sharedInstance] addborderToView:yinlianzhifuView width:1.0 color:COLOR_e5e5e5];
    UIImageView *iconIamgeView3 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"未选中圆点图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [yinlianzhifuView addSubview:iconIamgeView3];
    [iconIamgeView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yinlianzhifuView).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(15);
        make.height.width.mas_equalTo(13);
    }];
    UILabel *yinliantitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"银联支付";
        view ;
    });
    [yinlianzhifuView addSubview:yinliantitlelab];
    [yinliantitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView3.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(yinlianzhifuView).mas_offset(0);
    }];
    UIView *tarendaifuView = [[UIView alloc] init];
    [self addSubview:tarendaifuView];
    [tarendaifuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yinlianzhifuView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [[CCTools sharedInstance] addborderToView:tarendaifuView width:1.0 color:COLOR_e5e5e5];
    UIImageView *iconIamgeView4 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"未选中圆点图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [tarendaifuView addSubview:iconIamgeView4];
    [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(15);
        make.height.width.mas_equalTo(13);
    }];
    UILabel *taRendaiFutitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"他人代付";
        view ;
    });
    [tarendaifuView addSubview:taRendaiFutitlelab];
    [taRendaiFutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(tarendaifuView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(10);
    }];
    UILabel *titlelab1 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"商品数量";
        view ;
    });
    [self addSubview:titlelab1];
    [titlelab1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.top.mas_equalTo(line1.mas_bottom).mas_offset(10);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(titlelab1.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    UILabel *titlelab2 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"商品金额";
        view ;
    });
    [self addSubview:titlelab2];
    [titlelab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.top.mas_equalTo(titlelab1.mas_bottom).mas_offset(20);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = UIColorHex(0xf7f7f7);
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(titlelab2.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *sumLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    self.sumLab = sumLab;
    [self addSubview:sumLab];
    [sumLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.bottom.mas_equalTo(self).mas_offset(-18);
    }];
    
    [self addSubview:self.goPayBtn];
    [self.goPayBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.width.mas_equalTo(kWidth(118));
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.height.mas_equalTo(42);
    }];
    
    
    
}
- (void)botBtnClick:(UIButton *)button {
    
}
- (UIButton *)goPayBtn {
    if (!_goPayBtn) {
        _goPayBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 21;
            view.backgroundColor = kMainColor;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"立即支付" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_15];
            view.tag = 3;
            [view addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _goPayBtn;
}

- (void)BtnClicked:(UIButton *)button {
    
}


@end
