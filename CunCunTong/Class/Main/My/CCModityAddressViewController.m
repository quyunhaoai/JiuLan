//
//  CCModityAddressViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCModityAddressViewController.h"

@interface CCModityAddressViewController ()

@end

@implementation CCModityAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"修改地址"];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
