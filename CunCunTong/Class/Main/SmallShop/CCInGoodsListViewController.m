//
//  CCInGoodsListViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCInGoodsListViewController.h"
#import "CCMyGoodsList.h"
#import "CCSearchView.h"
#import "CCShaiXuanGoodsView.h"
#import "NKAlertView.h"
@interface CCInGoodsListViewController ()

@end

@implementation CCInGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"进货商品"];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 45);
    }];
    [self initData];
    [self setupUI];
}
- (void)setupUI {
    CCSearchView *searchView = [CCSearchView new];
    [self.view addSubview:searchView];
    [searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.right.mas_equalTo(self.view).mas_offset(-29);
        make.height.mas_equalTo(44);
    }];
    searchView.backgroundColor = UIColorHex(0xf7f7f7);
    searchView.layer.cornerRadius = 5;
    searchView.contentView.layer.backgroundColor = [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f] CGColor];
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"筛选图标-1")];
         
        view;
    });
    [self.view addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-12);
        make.size.mas_equalTo(CGSizeMake(17, 16));
        make.centerY.mas_equalTo(searchView).mas_offset(5);
    }];
    XYWeakSelf;
    [areaIcon addTapGestureWithBlock:^(UIView *gestureView) {
        [weakSelf showTableView];
    }];
}
- (void)initData {
    self.dataSoureArray = @[[CCMyGoodsList new]].mutableCopy;
}

- (void)showTableView {
        NKAlertView *alert = [[NKAlertView alloc] init];
        alert.contentView = [[CCShaiXuanGoodsView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 122)];
        alert.hiddenWhenTapBG = YES;
        alert.type = NKAlertViewTypeTop;
        [alert show];
}









@end
