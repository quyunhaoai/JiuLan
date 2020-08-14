//
//  KKSearchBar.m
//  KKToydayNews
//
//  Created by finger on 2017/8/9.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKSearchBar.h"
//#import "UISearchBar+Custom.h"

@interface KKSearchBar ()
//@property(nonatomic)UIImageView *searchIcon;
//@property(nonatomic)UILabel *placeholderLabel;
//@property (nonatomic,strong) UIButton *rightBtn;
//@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation KKSearchBar

- (id)init{
    self = [super init];
    if(self){
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI

- (void)setupUI{

    [self addSubview:self.searchBtn];
    [self addSubview:self.searchIcon];
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.rightBtn];
    [self addSubview:self.searchTextField];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(11);
        make.size.mas_equalTo(CGSizeMake(Window_W -11 -20 -11-11, 30));
        make.centerY.mas_equalTo(self);
    }];
    [self.searchIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(31);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self);
    }];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-11);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self);
    }];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    self.centerYOff = STATUS_BAR_HIGHT/2;
}

- (void)setCenterYOff:(CGFloat)centerYOff {
    _centerYOff = centerYOff;
    
    [self.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(11);
        make.size.mas_equalTo(CGSizeMake(Window_W -11 -20 -11-11, 30));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    [self.searchIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(31);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-11);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    [self.searchTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
        make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-11);
    }];
    
}

- (void)btnClicked:(UIButton *)sender {
    
}

#pragma mark -- @property
- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = ({
            UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            titleTextField.textColor =COLOR_999999;
            titleTextField.font = FONT_16;
            [titleTextField setUserInteractionEnabled:YES];
            titleTextField.placeholderColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] ;
            titleTextField.borderStyle = UITextBorderStyleNone;
            titleTextField.clearButtonMode = UITextFieldViewModeAlways;
            titleTextField.layer.masksToBounds = YES;
            titleTextField.hidden = YES;
            titleTextField;
        });
    }
    return _searchTextField;
}
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:krgb(227,227,227)];
            btn.alpha = 0.8;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 15;
            [btn setTag:BUTTON_TAG(9)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setClipsToBounds:YES];
            btn ;
            
        });
    }
    return _searchBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:BUTTON_TAG(8)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:IMAGE_NAME(@"消息图标") forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
        });
    }
    return _rightBtn;
}
- (UIImageView *)searchIcon{
    if(!_searchIcon){
        _searchIcon = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = [UIImage imageNamed:@"搜索"];
            view ;
        });
    }
    return _searchIcon;
}

- (UILabel *)placeholderLabel{
    if(!_placeholderLabel){
        _placeholderLabel = ({
            UILabel *view = [UILabel new];
            view.text = @"请输入商品名称";
            view.textColor = krgb(102,102,102);
            view.font = [UIFont systemFontOfSize:13];
            view.textAlignment = NSTextAlignmentLeft;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view ;
        });
    }
    return _placeholderLabel;
}

@end
