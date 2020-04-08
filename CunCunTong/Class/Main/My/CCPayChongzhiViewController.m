//
//  CCPayChongzhiViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCPayChongzhiViewController.h"

@interface CCPayChongzhiViewController ()

@end

@implementation CCPayChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"充值"];
    
    self.view.backgroundColor = kWhiteColor;
    
    [[CCTools sharedInstance] addborderToView:self.select1 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.select2 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.select3 width:1.0 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.weixinPay width:1.0 color:COLOR_cccccc];
    [[CCTools sharedInstance] addborderToView:self.zhifubaoPay width:1.0 color:COLOR_cccccc];
    [[CCTools sharedInstance] addborderToView:self.yinlianPay width:1.0 color:COLOR_cccccc];
    
    
}






@end
