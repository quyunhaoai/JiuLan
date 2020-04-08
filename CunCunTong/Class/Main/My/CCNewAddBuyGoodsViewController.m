//
//  CCNewAddBuyGoodsViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNewAddBuyGoodsViewController.h"

@interface CCNewAddBuyGoodsViewController ()

@end

@implementation CCNewAddBuyGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"新增销售录入"];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.selectGoods layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}
- (IBAction)selectGoods:(id)sender {
    
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
