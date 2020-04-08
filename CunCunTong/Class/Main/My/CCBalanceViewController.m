//
//  CCBalanceViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBalanceViewController.h"
#import "CCBalance.h"
#import "CCPayChongzhiViewController.h"
#import "BRDatePickerView.h"
@interface CCBalanceViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *monryLab;
@property (weak, nonatomic) IBOutlet KKButton *goPayBtn;

@end

@implementation CCBalanceViewController

- (IBAction)payButton:(id)sender {//充值
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    
    [self customNavBarwithTitle:@"余额" andLeftView:@""];
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(197+NAVIGATION_BAR_HEIGHT+48);
    }];

    [self.goPay setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:10];
    [self setupUI];
    [self initData];
}

- (void)setupUI {
    KKButton *forntBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [forntBtn setBackgroundColor:kWhiteColor];
    [forntBtn.titleLabel setFont:FONT_12];
    [forntBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [forntBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    [forntBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    forntBtn.layer.cornerRadius = 10;
    [forntBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    forntBtn.layer.masksToBounds = YES;
    [self.view addSubview:forntBtn];
    
    UILabel *titleLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(51,51,51);
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view ;
        
    });
    titleLab2.text = @"至";
    [self.view addSubview:titleLab2];
    KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:kWhiteColor];
    [backBtn.titleLabel setFont:FONT_12];
    [backBtn setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
    [backBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    [backBtn setImage:IMAGE_NAME(@"downImage_icon") forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 10;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [forntBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
    [titleLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(forntBtn.mas_right).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab2.mas_right).mas_offset(10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+15);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(20);
    }];
    [forntBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    UILabel *titleLab3 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [self.view addSubview:titleLab3];
    [titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+8);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(15);
    }];
    UILabel *titleLab4 = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_11;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.numberOfLines = 1;
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [self.view addSubview:titleLab4];
    [titleLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(197+NAVIGATION_BAR_HEIGHT+8+20);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(15);
    }];
    titleLab3.text = @"支出 ￥ 1000.00";
    titleLab4.text = @"支出 ￥ 1000.00";
}

- (void)initData {
    self.dataSoureArray = @[[CCBalance new],[CCBalance new]].mutableCopy;
    //0-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥0.00"];
    [attributedString addAttribute:NSFontAttributeName value:STFont(26) range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //0-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:STFont(38) range:NSMakeRange(1, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(1, 4)];
    self.monryLab.attributedText = attributedString;
}
- (void)timeSelect:(UIButton *)button {
    NSString *str = [NSString getCurrentTime:@"yyyy-MM-dd"];
    [BRDatePickerView showDatePickerWithTitle:@"请选择" dateType:BRDatePickerModeYMD defaultSelValue:str resultBlock:^(NSString *selectValue) {
        [button setTitle:selectValue forState:UIControlStateNormal];
    }];
    
}
- (IBAction)goChongZhi:(UIButton *)sender {
    
    CCPayChongzhiViewController *vc = [CCPayChongzhiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}













@end
