//
//  CCNeedViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNeedViewController.h"

@interface CCNeedViewController ()

@end

@implementation CCNeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"需求上报"];
    [self.photosBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleTop imageTitleSpace:10];
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
