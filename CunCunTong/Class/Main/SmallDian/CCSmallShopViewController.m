//
//  CCSmallShopViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSmallShopViewController.h"

@interface CCSmallShopViewController ()

@end

@implementation CCSmallShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"小店"];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
