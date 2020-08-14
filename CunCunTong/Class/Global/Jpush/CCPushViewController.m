//
//  CCPushViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/8/5.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPushViewController.h"
#import "CCOrderDetailViewController.h"
#import "CCBalanceViewController.h"
#import "CCActiveDivViewController.h"
#import "CCMessageSubViewController.h"
#import "CCWarningReminderViewController.h"
#import "CCWuliuInfoViewController.h"
#import "CCInGoodsListViewController.h"
#import "CCMessageViewController.h"
@implementation CCPushViewController
- (void)receiveNotificationWithUserInfo:(NSInteger)targetTypeID AndTarget:(NSInteger)point andData:(NSInteger )massageId{
    NSDictionary *dict = [NSDictionary dictionary];
    if (point == 1) {//预警消息 0:高库存，1：低库存，2：临期
        switch (targetTypeID) {
            case 0://高库存
            {
                dict = @{@"class":@"CCInGoodsListViewController",
                         @"property":@{//@"navTitleStr":@"高库存预警",
                                       @"types":@"100",
                        }
                        };
            }
                break;
            case 1://低库存
            {
                dict = @{@"class":@"CCInGoodsListViewController",
                         @"property":@{//@"navTitleStr":@"低库存预警",
                                       @"types":@"101",
                        }
                        };
            }
                break;
            case 2://临期
            {
                dict = @{@"class":@"CCInGoodsListViewController",
                         @"property":@{//@"navTitleStr":@"临期预警",
                                       @"types":@"102",
                        }
                        };
            }
                break;
            default:
                break;
        }
    } else {
        switch (targetTypeID) {
            case 0://订单消息
            {
                dict = @{@"class":@"CCMessageViewController",
                         @"property":@{//@"orderID":STRING_FROM_INTAGER(massageId),
                        }
                        };
            }
                break;
            case 1://交易物流
            {
                dict = @{@"class":@"CCMessageViewController",
                        @"property":@{//@"OrderID":STRING_FROM_INTAGER(massageId),
                        }
                        };
            }
                break;
            case 2://充值消息
            {
                dict = @{@"class":@"CCBalanceViewController",
                        @"property":@{
                        }
                        };
            }
                break;
            case 3://热门活动
            {
                dict = @{@"class":@"CCActiveDivViewController",
                        @"property":@{
                        }
                        };
            }
                break;
            case 4://平台消息
            {
                dict = @{@"class":@"CCMessageViewController",
                        @"property":@{//@"types":@4,
                        }
                        };
            }
                break;
            default:
                break;
        }
    }

    [self push:dict];
}

/**
 *  跳转界面
 */
- (void)push:(NSDictionary *)params {
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    XYLog(@"class1111:\n\n%@",class);

    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
        XYLog(@"class:\n\n%@",class);
    } else {
        XYLog(@"newClass:\n\n%@",newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    // 跳转到对应的控制器

    [[[JpushManager shareManager] getCurrentViewController].navigationController pushViewController:instance animated:YES];
}

/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName {
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

////获取到根视图控制器
//- (UIViewController *)currentViewController {
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    // modal展现方式的底层视图不同
//    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
//    UIView *firstView = [keyWindow.subviews firstObject];
//    UIView *secondView = [firstView.subviews firstObject];
//    UIViewController *vc = [secondView parentController];
//    if ([vc isKindOfClass:[UITabBarController class]]) {
//        UITabBarController *tab = (UITabBarController *)vc;
//        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
//            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
//            return [nav.viewControllers lastObject];
//        } else {
//            return tab.selectedViewController;
//        }
//    } else if ([vc isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)vc;
//        return [nav.viewControllers lastObject];
//    } else {
//        return vc;
//    }
//    return nil;
//}
//- (UIViewController *)parentController
//{
//    UIResponder *responder = [self nextResponder];
//    while (responder) {
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)responder;
//        }
//        responder = [responder nextResponder];
//    }
//    return nil;
//
//}
@end
