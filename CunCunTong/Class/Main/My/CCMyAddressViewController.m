//
//  CCMyAddressViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyAddressViewController.h"
//#import "CCSureOrderHeadView.h"
#import "CCModityAddressViewController.h"
#import "CCModifyArddress.h"
@interface CCMyAddressViewController ()
//@property (strong, nonatomic) CCSureOrderHeadView *hhhView;
@end

@implementation CCMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self customNavBarWithTitle:@"收货地址"];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCModifyArddress new]].mutableCopy;
}
//#pragma mark  -  get
//-(CCSureOrderHeadView *)hhhView {
//    if (!_hhhView) {
//        _hhhView = [[CCSureOrderHeadView alloc] init];
//    }
//    return _hhhView;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
