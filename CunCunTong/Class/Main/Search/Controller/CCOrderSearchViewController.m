//
//  CCOrderSearchViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderSearchViewController.h"
#import "STSearchHistoryTableViewCell.h"

#import "STSearchTableViewSetionHeaderView.h"
#import "CCEverDayTeViewController.h"
#import "CCMyOrderViewController.h"

@interface CCOrderSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UIButton *rightNavBtn; //  按钮
@property (strong, nonatomic) UITextField *searchTextField;  // 文本框
@property (strong, nonatomic) NSMutableArray *historyArray;  // 历史 数组
@property (nonatomic,copy) NSString *searchRelustStr;
@end

@implementation CCOrderSearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.userInteractionEnabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    [self customNavBarWithSearchTitle:@"" andRightButtonStr:@"" andLeftStr:@""];
    self.tableView.backgroundColor = kWhiteColor;
}

#pragma mark  -  搜索框和左右边按钮
- (void)customNavBarWithSearchTitle:(NSString *)searchTltle andRightButtonStr:(NSString *)rightBtnStr andLeftStr:(NSString *)title{
    //搜索框
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:searchView];
    searchView.userInteractionEnabled = YES;
    searchView.backgroundColor = kWhiteColor;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAME(@"箭头图标黑") forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [backButton setEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitlePadding:15];
    [backButton setTarget:self action:@selector(black:) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    [searchView addSubview:backButton];
    backButton.frame = CGRectMake(6, STATUS_BAR_HEIGHT + 7, 30, 30);
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(-10, 10, 30, 30)];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 16, 16)];
    searchImage.image = ImageNamed(@"搜索");
    [view1 addSubview:searchImage];

    UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, STATUS_BAR_HEIGHT+5, searchView.frame.size.width-40-56, 35)];
    titleTextField.textColor =COLOR_999999;
    titleTextField.font = FONT_16;
    [searchView addSubview:titleTextField];
    titleTextField.text = searchTltle;
    [titleTextField setUserInteractionEnabled:YES];
    titleTextField.leftView = view1;
    //开启leftView总是显示的模式
    titleTextField.leftViewMode=UITextFieldViewModeAlways;
    titleTextField.placeholder = self.searchStr.length>0?self.searchStr : @"搜索我的订单";
    titleTextField.delegate = self;
    titleTextField.placeholderColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] ;
    titleTextField.borderStyle = UITextBorderStyleNone;
    titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    titleTextField.layer.masksToBounds = YES;
    titleTextField.layer.cornerRadius = 17.5;
    titleTextField.layer.borderColor = kMainColor.CGColor;
    titleTextField.layer.borderWidth = 1;
    titleTextField.alpha = 1;
    self.searchTextField = titleTextField;
    [self.searchTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(Window_W - 40 - 12, STATUS_BAR_HEIGHT+3, 40, 40);
    [self.rightNavBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightNavBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.rightNavBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.rightNavBtn.titleLabel.font = FONT_16;
    [self.rightNavBtn setUserInteractionEnabled:YES];
    [searchView addSubview:self.rightNavBtn];
}

- (void)textField1TextChange:(UITextField *)field {
    self.searchRelustStr = field.text;
}

- (void)black:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchTextField resignFirstResponder];
}

- (void)rightBtnClick:(UIButton *)button {
    [self.searchTextField resignFirstResponder];
    [self searchStr:self.searchRelustStr];
}
- (void)searchStr:(NSString *)searchString {
    if (searchString.length>0) {
        [self addItem:searchString];
        if (self.searchStr.length>0) {
            CCEverDayTeViewController *vc = [CCEverDayTeViewController new];
            vc.goods_name = self.searchRelustStr;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            CCMyOrderViewController *vc = [CCMyOrderViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)addItem:(NSString *)text{
    if (![self containsText:text]) {
        [self.historyArray insertObject:text atIndex:0];
    } else {
        [self.historyArray removeObject:text];
        [self.historyArray insertObject:text atIndex:0];
    }
    if (self.historyArray.count > 10) {
        [self.historyArray removeLastObject];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithArray:self.historyArray] forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)containsText:(NSString *)text {
    @autoreleasepool {
        for (int i = 0; i < self.historyArray.count; i ++) {
            if ([self.historyArray[i] isEqualToString:text]) {
                return YES;
            }
        }
    }
    return NO;
}
#pragma mark - tableview delegate dataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   STSearchHistoryTableViewCell *  cell = [STSearchHistoryTableViewCell initializationCellWithTableView:tableView];
    cell.historyArray = self.historyArray;
    XYWeakSelf;
    cell.searchHotCellLabelClickButton = ^(NSArray * _Nonnull arr) {
        [weakSelf searchStr:arr[0]];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    STSearchTableViewSetionHeaderView *headerView = [[STSearchTableViewSetionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
    headerView.itemLabel.text = @"搜索历史";
    [headerView.itemButton addTarget:self action:@selector(deleteItem:) forControlEvents:(UIControlEventTouchUpInside)];
    return headerView;
}

- (void)deleteItem:(UIButton *)button {
    if (self.historyArray.count > 0) {
        [self.historyArray removeAllObjects];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithArray:self.historyArray] forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTextField resignFirstResponder];
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithArray:[kUserDefaults objectForKey:@"history"]];
    }
    return _historyArray;
}


@end
