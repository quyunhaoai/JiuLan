//
//  CCDaySalesViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCDaySalesViewController.h"
#import "CCDaySales.h"
@interface CCDaySalesViewController ()

@end

@implementation CCDaySalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}
- (void)initData {
    self.dataSoureArray = @[[CCDaySales new]].mutableCopy;
}
-(void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"新建加号图标") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"日销售录入" andLeftView:@"" andRightView:@[rightBtn]];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 34);
    }];
    
    
}
- (void)rightBtAction:(UIButton *)btn {
    
}





@end
