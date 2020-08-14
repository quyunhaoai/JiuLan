//
//  CCShopBottomView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "ImageTitleButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCShopBottomView : CCBaseView
@property (nonatomic,strong) ImageTitleButton *callPhoneBtn;
@property (strong, nonatomic) UILabel *priceLab;  
@property (nonatomic,strong) UIButton *goPayBtn;
@property (nonatomic,strong) UIButton *addShopCarBtn;
@property (strong, nonatomic) UIImageView *shopCarImage; // <#name#> 

/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clickCallBack)(NSInteger tag);

@property (nonatomic,strong)   UIView *parentView;//背景图层

@property (nonatomic, strong) UIView *contentView;

// 点击背景时候隐藏alert
@property (nonatomic, assign) BOOL hiddenWhenTapBG;
@property (assign, nonatomic) BOOL  isOpen; 

// Show the alert view in current window
- (void)show;

// Hide the alert view
- (void)hide;

-(instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView;

@end

NS_ASSUME_NONNULL_END
