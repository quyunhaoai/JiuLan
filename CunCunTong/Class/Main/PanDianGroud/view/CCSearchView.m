//
//  CCSearchView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSearchView.h"
#import "CCCustomTextFiled.h"
@implementation CCSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {

    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = kWhiteColor;
    [self addSubview:_contentView];
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.bottom.mas_equalTo(self);
    }];
    
    [_contentView setCornerRadius:5 withShadow:YES withOpacity:0.5];
    
    UIImageView *icon = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"搜索"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [_contentView addSubview:icon];
    [icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentView).mas_offset(10);
        make.centerY.mas_equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(15, 16));
    }];
    
    UITextField *sumTextLab = ({
        UITextField *textfield = [[UITextField alloc] init];
        //设置边框
        textfield.borderStyle = UITextBorderStyleNone;
        //设置水印提示
        textfield.placeholder = @"请输入商品名称/规格/条形码";
        textfield.placeholderColor= krgb(153,153,153);
        //设置输入框右边的一键删除（x号）
        textfield.clearButtonMode = 0;
        //设置密码安全样式
//        textfield.secureTextEntry = YES;
        //设置键盘样式
        textfield.keyboardType = UIKeyboardTypeDefault;
        textfield.returnKeyType = UIReturnKeySearch;
         
        textfield.backgroundColor = kClearColor;
        //设置输入的字体大小
        textfield.font = [UIFont systemFontOfSize:15];
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, 25, 23)];
//        UIImageView *nameImage1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18,20)];
//        nameImage1.image=[UIImage imageNamed:@"密码图标 2"];
//        [view addSubview:nameImage1];
//        textfield.leftView = view;
//        textfield.leftViewMode=UITextFieldViewModeAlways;
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textfield;
//        UILabel *view = [UILabel new];
//        view.textColor = COLOR_999999;
//        view.font = FONT_14;
//        view.lineBreakMode = NSLineBreakByTruncatingTail;
//        view.backgroundColor = [UIColor clearColor];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.layer.masksToBounds = YES;
//        view.layer.cornerRadius = 1;
//        view.text = @"请输入商品名称/规格/条形码";
//        view ;
    });
    [_contentView addSubview:sumTextLab];
    [sumTextLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_contentView).mas_offset(0);
        make.left.mas_equalTo(icon.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/4*3);
        make.height.mas_equalTo(17);
    }];
    self.searchTextField = sumTextLab;
}



@end
