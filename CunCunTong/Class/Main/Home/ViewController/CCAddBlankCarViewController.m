
//
//  CCAddBlankCarViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAddBlankCarViewController.h"

@interface CCAddBlankCarViewController ()

@end

@implementation CCAddBlankCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"添加银行卡"];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
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
