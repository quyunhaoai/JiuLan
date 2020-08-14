

//
//  MHWelComeViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/6.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHWelComeViewController.h"
#import "LBPGuideView.h"
#import "AppDelegate.h"
#import "CCTabbarViewController.h"
#import "CCLoginRViewController.h"
#import "CCBaseNavController.h"
#import "CCUpdateTipModel.h"
@interface MHWelComeViewController ()
@property (nonatomic,strong) CCUpdateTipModel *model;
@property (nonatomic,copy) NSString *app_Version;  //
@end

@implementation MHWelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LBPGuideView *view = [LBPGuideView showGuideViewWithImages:@[@"引导页1",@"引导页2",@"引导页3"]];
    view.pageControlHidden = YES;
    view.enterButtonHidden = YES;
    [self.view addSubview:view];
    view.frame = self.view.frame;
    view.loadOver = ^{
        NSString *token = [kUserDefaults objectForKey:@"token"];
        if (token.isNotBlank) {
            [AppDelegate sharedAppDelegate].window.rootViewController = [CCTabbarViewController getTabBarController];
        } else {
            CCLoginRViewController *vc = [[CCLoginRViewController alloc] init];
            [AppDelegate sharedAppDelegate].window.rootViewController = [[CCBaseNavController alloc] initWithRootViewController:vc];
        }
    };
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app/iosset/?point=0";
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 网络请求获取最新版本
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCUpdateTipModel modelWithJSON:data];
            //把版本号转换成数值
            NSArray * array1 = [currentVersion componentsSeparatedByString:@"."];
            NSInteger currentVersionInt = 0;
            if (array1.count == 3)//默认版本号1.0.0类型
            {
                currentVersionInt = [array1[0] integerValue]*100 + [array1[1] integerValue]*10 + [array1[2] integerValue];
            }
            NSArray * array2 = [weakSelf.model.versionStr componentsSeparatedByString:@"."];
            NSInteger lineVersionInt = 0;
            if (array2.count == 3)
            {
                lineVersionInt = [array2[0] integerValue]*100 + [array2[1] integerValue]*10 + [array2[2] integerValue];
            }
            if (lineVersionInt > currentVersionInt)//线上版本大于本地版本
            {
                 [weakSelf showUpdateTip];
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)showUpdateTip {
    NSString *AppID = @"";
    SPAlertController *alert = [SPAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@",self.model.versionStr] message:self.model.updateContent preferredStyle:SPAlertControllerStyleAlert];

    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"去更新" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
         //跳转到App Store
        NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@",AppID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController: alert animated:YES completion:^{}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 NSString * url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",AppID];//替换为自己App的ID
 // 获取本地版本号
 NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
 // 网络请求获取最新版本
 [[HttpBaseManager getSharedManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSArray * results = responseObject[@"results"];
         if (results && results.count>0)
         {
             NSDictionary * dic = results.firstObject;
             NSString * lineVersion = dic[@"version"];//版本号
             NSString * releaseNotes = dic[@"releaseNotes"];//更新说明
             //NSString * trackViewUrl = dic[@"trackViewUrl"];//链接
             //把版本号转换成数值
             NSArray * array1 = [currentVersion componentsSeparatedByString:@"."];
             NSInteger currentVersionInt = 0;
             if (array1.count == 3)//默认版本号1.0.0类型
             {
                 currentVersionInt = [array1[0] integerValue]*100 + [array1[1] integerValue]*10 + [array1[2] integerValue];
             }
             NSArray * array2 = [lineVersion componentsSeparatedByString:@"."];
             NSInteger lineVersionInt = 0;
             if (array2.count == 3)
             {
                 lineVersionInt = [array2[0] integerValue]*100 + [array2[1] integerValue]*10 + [array2[2] integerValue];
             }
             if (lineVersionInt > currentVersionInt)//线上版本大于本地版本
             {
                 UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@",lineVersion] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction * ok = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                 UIAlertAction * update = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     //跳转到App Store
                     NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",AppID];
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                 }];
                 [alert addAction:ok];
                 [alert addAction:update];
                 [self presentViewController:alert animated:YES completion:nil];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"版本更新出错，%@",error.description);
     }];
*/

@end
