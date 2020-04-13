

//
//  CCSelectGoodsViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSelectGoodsViewController.h"
#import "CCGoodsSelectModel.h"
#import "CCSearchView.h"
@interface CCSelectGoodsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *sumLab;
@end

@implementation CCSelectGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:self.titleStr];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 44);
        make.bottom.mas_equalTo(self.view).mas_offset(-44);
    }];
    [self setupUI];
    [self initData];
}
- (void)setupUI {
    CCSearchView *searchView = [CCSearchView new];
    [self.view addSubview:searchView];
    [searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
}
- (IBAction)selectOver:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initData {
    self.dataSoureArray = @[[CCGoodsSelectModel new]].mutableCopy;
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
