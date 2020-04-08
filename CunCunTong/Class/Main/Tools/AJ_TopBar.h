//
//  AJ_TopBar.h
//  YiRenShi新版
//
//  Created by wuweijian on 15/11/30.
//  Copyright © 2015年 wuweijian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KTopbarHeight 40

typedef void (^ButtonClickHandler)(NSInteger currentPage);

@interface AJ_TopBar : UIScrollView

@property (nonatomic, strong) NSMutableArray      *titles;
@property (nonatomic, assign) NSInteger           currentPage;
@property (nonatomic, copy)   ButtonClickHandler  blockHandler;
@property (nonatomic,assign)  CGFloat             buttonWidth;//botton的宽
@property (nonatomic, strong) UIColor             *buttonTitleColor; //button字体颜色
@property (nonatomic, strong) UIColor             *buttonTitleSelectedColor; //button字体颜色
@property (nonatomic, strong) UIColor             *markcolor; //底部滚动条颜色
@property (nonatomic,strong) NSMutableArray       *widths;//buttons的宽度数组
@property (nonatomic, strong) NSMutableArray      *dramaIdArray; //剧种ID数组
@end
