//
//  CCLonginTextInputVIew.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCLonginTextInputVIew.h"

@implementation CCLonginTextInputVIew

- (void)setupUI {
    
    self.backgroundColor = kWhiteColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    [self addSubview:self.moblieTextField];
    [self addSubview:self.keyTextField];
    
    //Base style for 矩形 25
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 306, 44)];
    style.layer.cornerRadius = 8;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [self addSubview:style];
    
    UIView *verView = [[UIView alloc] initWithFrame:CGRectMake(20, 50+20+44+25, 306, 44)];
    verView.layer.cornerRadius = 8;
    verView.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    verView.alpha = 1;
    [self addSubview:verView];
    	
    [self addShadowToView:style withColor:KKColor(18,109,104,0.18)];
    [self addShadowToView:verView withColor:KKColor(18,109,104,0.18)];

    
    [style addSubview:self.moblieTextField];
    [verView addSubview:self.keyTextField];
    [self.moblieTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(style);
    }];
    [self.keyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(verView);
    }];

    [self addSubview:self.longinBtn];
    [self addSubview:self.passworldChuageBtn];
    [self addSubview:self.sendVarkeyBtn];
    [self.longinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-83);
    }];
    [self.passworldChuageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verView.mas_bottom).mas_offset(11);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(verView);
    }];
    [self.sendVarkeyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verView).mas_offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(verView).mas_offset(-8);
    }];
}

#pragma get
- (UIButton *)passworldChuageBtn {
    if (!_passworldChuageBtn) {
        _passworldChuageBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:krgb(36,149,143) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTag:BUTTON_TAG(6)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"账号密码登录" forState:UIControlStateNormal];
            btn ;
        });
    }
    return _passworldChuageBtn;
}

- (UIButton *)sendVarkeyBtn {
    if (!_sendVarkeyBtn) {
        _sendVarkeyBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:krgb(36,149,143) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTag:BUTTON_TAG(8)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            btn ;
        });
    }
    return _sendVarkeyBtn;
}

- (UIButton *)longinBtn {
    if (!_longinBtn) {
        _longinBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:krgb(204, 204, 204)];
            [btn setTag:BUTTON_TAG(7)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"登  录" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            [btn setUserInteractionEnabled:NO];
            btn.layer.cornerRadius = 8;
            btn ;
        });
    }
    return _longinBtn;
}

- (void)btnClicked:(UIButton *)sender {
    if (sender.tag == BUTTON_TAG(6)) {
        self.isPassWorldLogin = !self.isPassWorldLogin;
        if (self.isPassWorldLogin) {
            self.moblieTextField.placeholder = @"请输入账号";
            self.keyTextField.placeholder = @"请输入密码";
            self.moblieTextField.text = @"";
            self.keyTextField.text = @"";
            [sender setTitle:@"短信验证码登录" forState:UIControlStateNormal];
            self.sendVarkeyBtn.hidden = YES;
        } else {
            self.moblieTextField.placeholder = @"请输入手机号码";
            self.keyTextField.placeholder = @"请输入验证码";
            self.moblieTextField.text = @"";
            self.keyTextField.text = @"";
            [sender setTitle:@"账号密码登录" forState:UIControlStateNormal];
            self.sendVarkeyBtn.hidden = NO;
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
            [self.delegate jumpBtnClicked:sender];
        }
    }
}

- (CCCustomTextFiled *)moblieTextField {
    if (!_moblieTextField) {
        _moblieTextField =  ({
          CCCustomTextFiled *textfield = [[CCCustomTextFiled alloc] init];
          //设置边框
          textfield.borderStyle = UITextBorderStyleNone;
          //设置水印提示
          textfield.placeholder = @"请输入手机号码";
          textfield.placeholderColor = krgb(153,153,153);
          //设置输入框右边的一键删除（x号）
          textfield.clearButtonMode = 0;
          //设置密码安全样式
          textfield.secureTextEntry = NO;
          //设置键盘样式
          textfield.keyboardType = UIKeyboardTypeNumberPad ;
          textfield.backgroundColor = kClearColor;
          //设置输入的字体大小
          textfield.font = [UIFont systemFontOfSize:15];
          UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, 25, 23)];
          UIImageView *nameImage1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15,23)];
          nameImage1.image=[UIImage imageNamed:@"手机图标"];
          [view addSubview:nameImage1];
          textfield.leftView = view;
          textfield.leftViewMode=UITextFieldViewModeAlways;
          textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
          textfield;
        });
    }
    return _moblieTextField;
}

- (CCCustomTextFiled *)keyTextField {
    if (!_keyTextField) {
        _keyTextField =  ({
              CCCustomTextFiled *textfield = [[CCCustomTextFiled alloc] init];
              //设置边框
              textfield.borderStyle = UITextBorderStyleNone;
              //设置水印提示
              textfield.placeholder = @"请输入验证码";
              textfield.placeholderColor= krgb(153,153,153);
              //设置输入框右边的一键删除（x号）
              textfield.clearButtonMode = 0;
              //设置密码安全样式
              textfield.secureTextEntry = YES;
              //设置键盘样式
              textfield.keyboardType = UIKeyboardTypeDefault;
               
              textfield.backgroundColor = kClearColor;
              //设置输入的字体大小
              textfield.font = [UIFont systemFontOfSize:15];
              UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, 25, 23)];
              UIImageView *nameImage1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18,20)];
              nameImage1.image=[UIImage imageNamed:@"密码图标 2"];
              [view addSubview:nameImage1];
              textfield.leftView = view;
              textfield.leftViewMode=UITextFieldViewModeAlways;
              textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
              textfield;
          });
    }
    return _keyTextField;
}
/// 添加四边阴影效果
-(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}

@end
