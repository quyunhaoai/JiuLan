//
//  CCBaseViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseViewController.h"
#import "LWExtendButton.h"
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
    LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
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
- (void)customSearchOrderNavBar {
    [self.view addSubview:self.searBarView];
    
    [self.searBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    self.searBarView.backgroundColor = kWhiteColor;
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
    LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateHighlighted];
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
    LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
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
    LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
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
        LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
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
        LWExtendButton *backButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
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

- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}

- (void)setShowTableBlankView:(BOOL)showTableBlankView {
    _showTableBlankView = showTableBlankView;
    if (_showTableBlankView) {
        if ([self.view.subviews containsObject:self.blankView]) {
            [self.blankView removeFromSuperview];
        }
        self.blankView = [[UIView alloc] init];
        self.blankView.frame = self.baseTableView.frame;
        [self.view addSubview:self.blankView];
        UIImage *loadingImage = [UIImage imageNamed:@"无订单缺省页图标"];
        UIImageView *customBackgournd = [[UIImageView alloc] initWithImage:loadingImage];
        customBackgournd.frame = CGRectMake((Window_W-160)/2, 0, 160, 125);
        customBackgournd.centerY = self.view.centerY - 125 ;
        [self.blankView addSubview:customBackgournd];
        customBackgournd.contentMode = UIViewContentModeScaleAspectFit;
        LWExtendButton *requestButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
        requestButton.frame = customBackgournd.frame;
        [requestButton addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
        [self.blankView addSubview:requestButton];
        UILabel * tipLabel = ({
            UILabel *label = [UILabel new];
            label.textColor = UIColorHex(0x999999);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0 ;
            label.text = @"暂无数据";
            label;
        });
        [self.blankView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(customBackgournd.mas_bottom).mas_offset(5);
            make.width.mas_equalTo(200);
        }];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        self.baseTableView.hidden = YES;
    } else {
        [self.blankView removeFromSuperview];
        [self.errorView removeFromSuperview];
        self.baseTableView.hidden = NO;
    }
}
- (void)setShowErrorView:(BOOL)showErrorView {
    _showErrorView = showErrorView;
    if (_showErrorView ) {
        if ([self.view.subviews containsObject:self.errorView]) {
            [self.errorView removeFromSuperview];
        }
        self.errorView = [[UIView alloc] init];
        self.errorView.frame = self.baseTableView.frame;
        self.errorView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.errorView];
        [self.view sendSubviewToBack:self.errorView];
        UIImage *errorImage = [UIImage imageNamed:@"无网络图标"];//noNetimage
        UIImageView *customBackgournd = [[UIImageView alloc] initWithImage:errorImage];
        customBackgournd.frame = CGRectMake((Window_W-160)/2, 0, 160, 125);
        customBackgournd.centerY = self.errorView.centerY - 65;
        customBackgournd.contentMode = UIViewContentModeScaleAspectFit;
        [self.errorView addSubview:customBackgournd];
        LWExtendButton *requestButton = [LWExtendButton buttonWithType:UIButtonTypeCustom];
        requestButton.frame = customBackgournd.frame;
        [requestButton addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
        [self.errorView addSubview:requestButton];
        UILabel * tipLabel = ({
            UILabel *label = [UILabel new];
            label.textColor = UIColorHex(0x999999);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0 ;
            label.text = @"啊哦 网络开小车";
            label;
        });
        [self.errorView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.errorView.mas_centerX);
            make.top.mas_equalTo(customBackgournd.mas_bottom).mas_offset(5);
            make.width.mas_equalTo(self.errorView).mas_offset(- 2 * 10).priority(998);
        }];
        self.baseTableView.hidden = YES;
    } else {
        [self.blankView removeFromSuperview];
        [self.errorView removeFromSuperview];
        self.baseTableView.hidden = NO;
    }
}







@end
