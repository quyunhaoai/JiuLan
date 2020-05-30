//
//  CCExpressKDFRViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCExpressKDFRViewController.h"
#import "BaseTableViewCell.h"
@interface CCExpressKDFRViewController ()<GroupShadowTableViewDelegate,GroupShadowTableViewDataSource>
@property (nonatomic, strong) GroupShadowTableView *tableView;
//@property (strong, nonatomic) NSMutableArray *dataSoureArray;
@end

@implementation CCExpressKDFRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.tableView = [[GroupShadowTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.groupShadowDelegate = self;
    self.tableView.groupShadowDataSource = self;
    self.tableView.showSeparator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:BaseTableViewCell.loadNib forCellReuseIdentifier:@"TextModel"];
    self.tableView.backgroundColor = COLOR_e5e5e5;
    [self setupUI];
    self.tableView.contentInset = UIEdgeInsetsMake(241, 0, 0, 0);
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 80)];
    self.tableView.tableHeaderView = head;
}


#pragma mark delegate datasource
- (NSInteger)numberOfSectionsInGroupShadowTableView:(GroupShadowTableView *)tableView {
    return 1;
}

- (NSInteger)groupShadowTableView:(GroupShadowTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)groupShadowTableView:(GroupShadowTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextModel"];
    return cell;
}

- (CGFloat)groupShadowTableView:(GroupShadowTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    if ([modelName isEqualToString:@"TextModel"]) {
        CellClass = NSClassFromString(@"TextModelCell");
    }
    return 130;
}

- (void)groupShadowTableView:(GroupShadowTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
//- (NSMutableArray *)dataSoureArray {
//    if (!_dataSoureArray) {
//        _dataSoureArray = [[NSMutableArray alloc] init];
//    }
//    return _dataSoureArray;
//}



- (void)setupUI {
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setTitle:@"收件" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_14 ;
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });

    UIImageView *headImageViewBg = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"快递分润背景"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    
    [self.tableView addSubview:headImageViewBg];
    [headImageViewBg masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView).mas_offset(-(241+STATUS_BAR_HIGHT));
        make.right.left.mas_equalTo(self.tableView);
        make.height.mas_equalTo(241);
    }];
    rightBtn.frame = CGRectMake(0, 0, 54, 40);
    [self customNavBarWithtitle:@"快递分润" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.backgroundColor = kClearColor;
    self.navTitleView.splitView.backgroundColor = kClearColor;
    
    
    UILabel *titleLab = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(243, 243, 243);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"总分润(元)";
        view ;
    });
    [headImageViewBg addSubview:titleLab];
    [titleLab masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageViewBg).mas_offset(85);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(21);
    }];
    
    UILabel *moneyLab = ({
           UILabel *view = [UILabel new];
           view.textColor = krgb(243, 243, 243);
           view.font = STFont(35);
           view.lineBreakMode = NSLineBreakByTruncatingTail;
           view.backgroundColor = [UIColor clearColor];
           view.textAlignment = NSTextAlignmentCenter;
           view.layer.masksToBounds = YES;
           view.layer.cornerRadius = 1;
           view.text = @"333.00";
           view ;
       });
       [headImageViewBg addSubview:moneyLab];
       [moneyLab masMakeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(15);
           make.right.left.mas_equalTo(self.view);
           make.height.mas_equalTo(25);
       }];
    
    UILabel *tiXianLab = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(243, 243, 243);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"转入 >";
        view ;
    });
    [headImageViewBg addSubview:tiXianLab];
    [tiXianLab masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyLab.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(headImageViewBg).mas_offset(-Window_W/4);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(Window_W/3);
    }];
    
    
    UILabel *subTiXianLab = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(243, 243, 243);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"转入至余额";
        view ;
    });
    [headImageViewBg addSubview:subTiXianLab];
    [subTiXianLab masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tiXianLab.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(headImageViewBg).mas_offset(-Window_W/4);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(Window_W/3);
    }];
    
    UILabel *tiXianLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(243, 243, 243);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"提现 >";
        view ;
    });
    [headImageViewBg addSubview:tiXianLab2];
    [tiXianLab2 masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyLab.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(Window_W/4);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(Window_W/3);
    }];


    UILabel *subtiXianLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(243, 243, 243);
        view.font = FONT_14;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.text = @"费率：0.1%";
        view ;
    });
    [headImageViewBg addSubview:subtiXianLab2];
    [subtiXianLab2 masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tiXianLab2.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(Window_W/4);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(Window_W/3);
    }];

    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = krgb(255, 146, 113);
    [headImageViewBg addSubview:line];
    [line masMakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyLab.mas_bottom).mas_offset(35);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(27);
        make.width.mas_equalTo(1);
    }];
    
//    [self.tableView masUpdateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(241+50);
//    }];
    
}

- (void)rightBtAction:(UIButton *)button {
    
}




















@end
