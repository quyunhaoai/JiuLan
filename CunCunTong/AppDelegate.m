//
//  AppDelegate.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CCBaseNavController.h"

#import "CCTabbarViewController.h"
#import "CCLoginRViewController.h"
#import "MHWelComeViewController.h"
#import "CCTemListViewController.h"
#import <SDImageWebPCoder.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "KKThirdTools.h"
#import <WechatOpenSDK/WechatAuthSDK.h>
#import "AppDelegate+JpushManager.h"
#import "KKWXTool.h"
#import "LDSDKManager.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    CCBaseViewController *vc = [[MHWelComeViewController alloc] init];
    self.window.rootViewController = [[CCBaseNavController alloc] initWithRootViewController:vc];
    [AMapServices sharedServices].apiKey = @"60d2928715564b72bb3aaba68025d1e5";
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
    //第三方平台注册
    [KKThirdTools registerPlatform:@[@(KKThirdPlatformWX),@(KKThirdPlatformQQ)]];
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];
    NSArray *regPlatformConfigList = @[
            @{
                    LDSDKConfigAppSchemeKey: @"waqu",   //用于支付完成的回到schema 不要带://
                    LDSDKConfigAppIdKey: @"2016101900724662",
                    LDSDKConfigAppSecretKey: @"AivRsxOiPoiXklp5",
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformAliPay)
            },
    ];
    [[LDSDKManager share] registerWithPlatformConfigList:regPlatformConfigList];
    return YES;

}


+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[KKWXTool shareInstance] handlerOpenUrl:url] || [TencentOAuth HandleOpenURL:url] || [[LDSDKManager share] handleURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[KKWXTool shareInstance] handlerOpenUrl:url] || [TencentOAuth HandleOpenURL:url] ||[[LDSDKManager share] handleURL:url];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    //    NSLog(@"程序被杀死");
    [kUserDefaults removeObjectForKey:isOK];
}
/*
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
*/

@end
