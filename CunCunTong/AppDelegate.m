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
#import "CCSureOrderViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    NSString *token = [kUserDefaults objectForKey:@"token"];
//    if (token.isNotBlank) {
//        self.window.rootViewController = [CCTabbarViewController getTabBarController];
//    } else {
//        CCLoginRViewController *vc = [[CCLoginRViewController alloc] init];
//        self.window.rootViewController = [[CCBaseNavController alloc] initWithRootViewController:vc];
//    }
    
//    CCLoginRViewController *vc = [[CCLoginRViewController alloc] init];
//    self.window.rootViewController = [CCTabbarViewController getTabBarController];
    CCBaseViewController *vc = [CCSureOrderViewController new];
    self.window.rootViewController = [[CCBaseNavController alloc] initWithRootViewController:vc];

    
//                NKAlertView *alert = [[NKAlertView alloc] init];
//                alert.contentView = [[CCActivityView alloc] initWithFrame:CGRectMake(0, 0, Window_W-73-73, 304+60)];
//                alert.hiddenWhenTapBG = YES;
//                alert.type = NKAlertViewTypeDef;
//                [alert show];
    
    [AMapServices sharedServices].apiKey = @"b82c30f9ff91789d674e36a044a42b40";
    return YES;
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
