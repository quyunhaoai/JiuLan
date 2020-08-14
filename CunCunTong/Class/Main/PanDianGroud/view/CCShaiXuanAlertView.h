//
//  CCShaiXuanAlertView.h
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//


#import <UIKit/UIKit.h>

//typedef enum : NSUInteger {
//    // 从中间弹出
//    NKAlertViewTypeDef,
//    // 从底部弹出
//    NKAlertViewTypeBottom,
//    // 从底部弹出
//    NKAlertViewTypeTop
//} NKAlertViewType;
#import "NKAlertView.h"
@interface CCShaiXuanAlertView : UIView

@property (nonatomic, assign) NKAlertViewType type;
@property (nonatomic, strong) UIView *contentView;
@property (strong, nonatomic) UIView *middleView;
@property (nonatomic, strong) UIView *bgView;
@property (assign, nonatomic) CGFloat   customY;    

// 点击背景时候隐藏alert
@property (nonatomic, assign) BOOL hiddenWhenTapBG;
- (instancetype)initWithFrame:(CGRect)frame inView:(UIView *)preview;
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^hideBlock)(void);

// Show the alert view in current window
- (void)show;

// Hide the alert view
- (void)hide;
@end
 
