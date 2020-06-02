//
//  CCShopBottomView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopBottomView.h"
@interface CCShopBottomView ()
@property (nonatomic, strong) UIView *bgView;
@property (strong, nonatomic) UIView *mainView;


@end
@implementation CCShopBottomView
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
    }
    return _mainView;
}
- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        if (self.contentView) {
            [self.parentView insertSubview:_bgView belowSubview:self.contentView];
        }else
        {
            [self.parentView addSubview:_bgView];
        }
        _bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgView.alpha = 0;
    }
    return _bgView;
}

-(instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.parentView = parentView;
        self.backgroundColor = kWhiteColor;
        [self setupUI];
        self.tag = 10000;
    }
    return self;
}

- (void)show
{
    [self.parentView insertSubview:self.bgView belowSubview:self.mainView.superview];
    _contentView.frame = CGRectMake((CGRectGetMaxX(self.parentView.frame) - CGRectGetWidth(_contentView.frame)) * 0.5, CGRectGetMaxY(self.parentView.frame), CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _contentView.bounds;
    shapeLayer.path = path.CGPath;
    _contentView.layer.mask = shapeLayer;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 1.0;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
    } completion:nil];
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.isOpen = NO;
    }];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    _contentView.frame = CGRectMake((CGRectGetMaxX(self.parentView.frame) - CGRectGetWidth(_contentView.frame)) * 0.5, CGRectGetMaxY(self.parentView.frame), CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
    /*
     利用贝塞尔曲线为contentView的左上角、右上角设置圆角；
     如果不需要可以注释下边代码
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _contentView.bounds;
    shapeLayer.path = path.CGPath;
    _contentView.layer.mask = shapeLayer;
    [self.bgView addSubview:_contentView];
}

- (void)setHiddenWhenTapBG:(BOOL)hiddenWhenTapBG
{
    _hiddenWhenTapBG = hiddenWhenTapBG;
    if (_hiddenWhenTapBG) {
        [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
}

- (void)setupUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    UIImageView *bgImage = ({
        
                    UIImageView *view = [UIImageView new];
                    view.contentMode = UIViewContentModeScaleAspectFill;
                    view.image = [UIImage imageNamed:@"shopBottomBg"];
                    view ;
        
    });
    
    [self.mainView addSubview:bgImage];
    [bgImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).mas_offset(-10);
        make.left.top.mas_equalTo(self).mas_offset(10);
    }];
    [self.mainView addSubview:self.callPhoneBtn];
    [self.callPhoneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.top.mas_equalTo(self).mas_offset(15);
        make.bottom.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(kWidth(67));
    }];
    self.callPhoneBtn.style = EImageTopTitleBottom;
    self.callPhoneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;

    UIImageView *shopCar = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.image = [UIImage imageNamed:@"购物车图标白"];
        view.userInteractionEnabled = YES;
        view ;
    });
    self.shopCarImage = shopCar;
    [shopCar addTapGestureWithBlock:^(UIView *gestureView) {
        if (self.clickCallBack) {
            self.clickCallBack(2);
        }
    }];
    [self.mainView addSubview:shopCar];
    [shopCar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.callPhoneBtn.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self).mas_offset(0);
        make.width.mas_equalTo(kWidth(24));
        make.height.mas_equalTo(kWidth(24));
    }];
    [self.mainView addSubview:self.priceLab];
    [self.priceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shopCar.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(self).mas_offset(0);
        make.width.mas_equalTo(kWidth(124));
        make.height.mas_equalTo(kWidth(24));
    }];
    [self.mainView addSubview:self.goPayBtn];
    [self.goPayBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(kWidth(67));
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
    
    //189-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥0"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //189-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f] range:NSMakeRange(1, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(1, 1)];
    self.priceLab.attributedText = attributedString;
}
#pragma mark  -  get
- (UIButton *)goPayBtn {
    if (!_goPayBtn) {
        _goPayBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"去结算" forState:UIControlStateNormal  ];
            [view.titleLabel setFont:FONT_15];
            view.tag = 3;
            [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _goPayBtn;
}
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = ({
            UILabel *view = [UILabel new];
            view.textColor = kWhiteColor;
            view.font = [UIFont fontWithName:@"DIN-Medium" size:16];
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _priceLab;
}

- (ImageTitleButton *)callPhoneBtn {
    if (!_callPhoneBtn) {
        _callPhoneBtn =({
            ImageTitleButton *view = [ImageTitleButton buttonWithType:UIButtonTypeCustom];
            view.tag = 1;
            [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [view setTitle:@"联系客服" forState:UIControlStateNormal  ];
            [view.titleLabel setFont:FONT_10];
            [view setImage:[UIImage imageNamed:@"客服图标"] forState:UIControlStateNormal];
            [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _callPhoneBtn;
}

-(void)moreBtnClicked:(UIButton *)button {
    if (self.clickCallBack) {
        self.clickCallBack(button.tag);
    }
}



@end
