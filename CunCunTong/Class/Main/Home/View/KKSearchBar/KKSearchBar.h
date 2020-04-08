//
//  KKSearchBar.h
//  KKToydayNews
//
//  Created by finger on 2017/8/9.
//  Copyright © 2017年 finger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSearchBar : UIView
@property (assign, nonatomic) CGFloat   centerYOff;    
@property(nonatomic)UIImageView *searchIcon;
@property(nonatomic)UILabel *placeholderLabel;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *searchBtn;
@end
