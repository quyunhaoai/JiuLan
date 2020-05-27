//
//  CCTabbarViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTabbarViewController.h"
#import "CCBaseNavController.h"

#import "CCHomeViewController.h"
#import "CCPanDianViewController.h"
#import "CCPersonCenterViewController.h"
#import "CCSmallShopViewController.h"

@interface CCTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation CCTabbarViewController

+ (instancetype)getTabBarController {
    static CCTabbarViewController *tabbar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tabbar == nil) {
            tabbar = [[CCTabbarViewController alloc] init];
        }
    });
    return tabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self builderTabbarView];

    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:krgb(203, 203, 203) size:CGSizeMake(Window_W, 0.7)]];
}


- (void)builderTabbarView {
    self.delegate = self;
    self.tabBar.backgroundColor = kWhiteColor;
    self.tabBar.backgroundImage = [UIImage imageWithColor:kWhiteColor];
    CCBaseNavController *navTabVC = [[CCBaseNavController alloc] initWithRootViewController:[CCHomeViewController new]];
    navTabVC.tabBarItem
    = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"首页"]
                                    image:[[UIImage imageNamed:@"首页图标灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"首页图标蓝"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CCBaseNavController *chatVC = [[CCBaseNavController alloc] initWithRootViewController:[CCPanDianViewController new]];
    chatVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"盘点"]
                                    image:[[UIImage imageNamed:@"盘点图标灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"盘点图标蓝"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    CCBaseNavController *smallShop = [[CCBaseNavController alloc] initWithRootViewController:[CCSmallShopViewController new]];
    smallShop.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"小店"]
                                    image:[[UIImage imageNamed:@"小店图标灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"小店图标绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    CCBaseNavController *personalCenterVC = [[CCBaseNavController alloc] initWithRootViewController:[CCPersonCenterViewController new]];
    personalCenterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"我的"]
                                    image:[[UIImage imageNamed:@"我的图标灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                            selectedImage:[[UIImage imageNamed:@"我的图标蓝"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = krgb(153,153,153);
 
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = krgb(36,149,143);
    
    
    NSArray *viewCtrlArray = @[navTabVC,   chatVC, smallShop, personalCenterVC];
    // 创建可变数组，存放导航控制器
    NSMutableArray *navCtrls = [NSMutableArray array];
    // 遍历视图控制器数组
    @autoreleasepool {
        for (UIViewController *viewCtrl in viewCtrlArray) {
            // 为视图控制器添加导航栏
            [viewCtrl.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            [viewCtrl.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            [navCtrls addObject:viewCtrl];
        }
    }
    self.viewControllers = navCtrls;
    self.tabBar.tintColor = krgb(36,149,143);
}


@end
