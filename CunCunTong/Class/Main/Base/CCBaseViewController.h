//
//  CCBaseViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNavTitleView.h"
#import "KKSearchBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCBaseViewController : UIViewController
@property (strong, nonatomic) KKNavTitleView *navTitleView; //  视图
@property (strong, nonatomic) KKSearchBar *searBarView;
@property (strong, nonatomic) NSMutableArray *dataSoureArray;
@property (assign, nonatomic) BOOL showErrorView;
@property (assign, nonatomic) BOOL showTableBlankView;
@property (assign, nonatomic) NSInteger page;
/********    无数据 空白  视图    ********/
@property (nonatomic, strong) UIView *blankView;

/********    page == 0时 请求失败  视图    ********/
@property (nonatomic, strong) UIView *errorView;

@property (strong, nonatomic) UITableView *baseTableView;

- (void)setupUI;
- (void)initData;
- (void)customSearchNavBar;
- (void)customSearchGoodsNavBar;
- (void)customSearchOrderNavBar;
/**
 初始化导航栏

 @param title 标题
 */
- (void)customNavBarWithTitle:(NSString *)title;
- (void)customNavBarWithBlackTitle:(NSString *)title;
/**
 含左侧按钮

 @param title 标题
 @param imageName 左侧按钮名
 */
- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName;
- (void)customNavBarwithTitle2:(NSString *)title andLeftView:(NSString *)imageName;
/**
 含右侧按钮集合

 @param title 标题
 @param imageName 左侧标题
 @param array 右侧按钮集合
 */
- (void)customNavBarWithtitle:(NSString *)title andLeftView:(NSString *)imageName andRightView:(NSArray *)array;


/**
 自定义左右两侧控件

 @param title 标题
 @param leftViews 左侧views
 @param rightViews 右侧views
 */
- (void)customNavBarwithTitle:(NSString *)title andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews;


/**
 全部自定义

 @param titleView 中间View
 @param leftViews 左侧Views
 @param rightViews 右侧Views
 */
- (void)customNavBarWithTitleView:(UIView *)titleView andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews;

@end

NS_ASSUME_NONNULL_END
