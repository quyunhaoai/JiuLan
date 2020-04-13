//
//  CCBaseViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCBaseViewController ()

@end
	
@implementation CCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
}

- (void)setupUI {
}
- (void)initData{
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)customSearchNavBar {
    [self.view addSubview:self.searBarView];
    
    [self.searBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
}
- (void)customSearchGoodsNavBar {
    [self.view addSubview:self.searBarView];
    
    [self.searBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.searBarView.backgroundColor = kMainColor;
    [self.searBarView.rightBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
    [self.searBarView.rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searBarView.rightBtn.titleLabel setFont:STFont(17)];
    [self.searBarView.searchBtn setBackgroundColor:kWhiteColor];
    self.searBarView.searchBtn.alpha = 1.0;
    [self.searBarView.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searBarView).mas_offset(32);
        make.size.mas_equalTo(CGSizeMake(Window_W -53-32, 30));
    }];
    [self.searBarView.searchIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searBarView).mas_offset(45);
    }];
    [self.searBarView.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
    }];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backButton setImage:IMAGE_NAME(@"backNav") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"backNav") forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.searBarView addSubview:backButton];
    [backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searBarView).mas_offset(10);
        make.centerY.mas_equalTo(self.searBarView.searchIcon.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(backButton.frame.size);
    }];
    
}
- (void)customNavBarWithTitle:(NSString *)title {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleLabel.text = title;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backButton setImage:IMAGE_NAME(@"backNav") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"backNav") forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
}

- (void)customNavBarWithBlackTitle:(NSString *)title {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.backgroundColor = kWhiteColor;
    self.navTitleView.titleLabel.textColor = kBlackColor;
    self.navTitleView.titleLabel.text = title;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.leftBtns = @[backButton];
}

- (void)customNavBarwithTitle:(NSString *)title andLeftView:(NSString *)imageName {
    [self customNavBarWithTitle:title];
    if (imageName.length>0) {
        for (UIButton *btn in self.navTitleView.leftBtns) {
            [btn removeFromSuperview];
        }
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:imageName forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateNormal];
        [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [backButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
        [backButton sizeToFit];

        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    } else {

    }
}
- (void)customNavBarwithTitle2:(NSString *)title andLeftView:(NSString *)imageName {
    [self customNavBarWithTitle:title];
    self.navTitleView.backgroundColor = krgb(36,149,143);
    self.navTitleView.titleLabel.textColor = kWhiteColor;
    self.navTitleView.splitView.backgroundColor = kClearColor;
    if (imageName.length>0) {
        for (UIButton *btn in self.navTitleView.leftBtns) {
            [btn removeFromSuperview];
        }
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:imageName forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateNormal];
        [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [backButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
        [backButton sizeToFit];

        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navTitleView.leftBtns = @[backButton];
    } else {

    }
}
- (void)customNavBarWithtitle:(NSString *)title andLeftView:(NSString *)imageName andRightView:(NSArray *)array {
    [self customNavBarwithTitle:title andLeftView:imageName];
    self.navTitleView.rightBtns = array;
}

- (void)customNavBarwithTitle:(NSString *)title andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews {
    [self customNavBarWithTitle:title];
    self.navTitleView.leftBtns = leftViews;
    self.navTitleView.rightBtns = rightViews;
}

- (void)customNavBarWithTitleView:(UIView *)titleView andCustomLeftViews:(NSArray *)leftViews andCustomRightViews:(NSArray *)rightViews {
    [self.view addSubview:self.navTitleView];
    [self.navTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.navTitleView.titleView = titleView;
    self.navTitleView.leftBtns = leftViews;
    self.navTitleView.rightBtns = rightViews;
}

- (void)back {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark  -  Get
- (KKSearchBar *)searBarView {
    if (!_searBarView) {
        _searBarView = ({
            KKSearchBar *view = [KKSearchBar new];
            view.backgroundColor = kWhiteColor;
            view ;
            
        });
    }
    return _searBarView;
}
- (KKNavTitleView *)navTitleView{
    if(!_navTitleView){
        _navTitleView = ({
            KKNavTitleView *view = [KKNavTitleView new];
            view.contentOffsetY = STATUS_BAR_HEIGHT >20 ? (STATUS_BAR_HEIGHT-(13.5))/2 : 10 ;
            view.backgroundColor = krgb(36,149,143);
            view ;
        });
    }
    return _navTitleView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}












@end
