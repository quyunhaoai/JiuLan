//
//  SH_MllSubclassificationViewController.m
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "SH_MallSubclassificationViewController.h"
#import "SH_MallSubclassificationSelectView.h"
#import "SH_MallSubclassificationViewControllerCell.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "CCEverDayTe.h"
#import "CCEverDayTeTableViewCell.h"
#import "CCShopBottomView.h"
#import "CCServiceMassageView.h"
#import "CCShopCarView.h"
#import "CCSureOrderViewController.h"
@interface SH_MallSubclassificationViewController ()<UITableViewDataSource,UITableViewDelegate,GHDropMenuDelegate,GHDropMenuDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) SH_MallSubclassificationSelectView *mallSelectView;
@property (nonatomic, assign) int                       sortColumn;//0:全部，1:按销量 2:按价格
@property (nonatomic, assign) int                       sortType;//0:正序 1:倒序
@property (strong, nonatomic) CCShopBottomView          *bottomView;
@property (assign, nonatomic) BOOL                       isOpen;
@property (strong, nonatomic) CCServiceMassageView      *massageView;
@property (strong, nonatomic) NSMutableArray            *dataArray;
@end

@implementation SH_MallSubclassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortColumn = 0;
    self.sortType = 0;
    [self requestData];
    [self setUpUI];
    adjustsScrollViewInsets_NO(self.tableView, self);
}

#pragma mark - requestData APIs
- (void)requestData{
}

#pragma mark - setUpUI
- (void)setUpUI {
    [self customSearchGoodsNavBar];
    self.searBarView.placeholderLabel.hidden = YES;
    self.searBarView.searchTextField.hidden = NO;
    self.searBarView.searchTextField.placeholder = @"请输入商品名称";
    [self.searBarView.searchTextField addTarget:self
                                         action:@selector(textFieldChange:)
                               forControlEvents:UIControlEventEditingChanged];
    [self initUI];
}
- (void)textFieldChange:(UITextField *)field {
    
}
- (void)initUI {
    [self.view addSubview:self.mallSelectView];
    [self.view addSubview:self.tableView];
    self.dataArray = @[[CCEverDayTe new]].mutableCopy;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(66);
    }];
    self.isOpen = NO;
    XYWeakSelf;
    _bottomView.clickCallBack = ^(NSInteger tag) {
        if (tag ==2) {
            if (!weakSelf.bottomView.isOpen) {
                CCShopCarView *customContentView = [[CCShopCarView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 554)];
                weakSelf.bottomView.contentView = customContentView;
                weakSelf.bottomView.hiddenWhenTapBG = YES;
                [weakSelf.bottomView show];
                weakSelf.bottomView.isOpen = YES;
            } else {
                [weakSelf.bottomView hide];
                weakSelf.bottomView.isOpen = NO;
            }
        } else if(tag == 1){
            if (!weakSelf.isOpen) {
                weakSelf.isOpen = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 1.0;
                    weakSelf.massageView.hidden = NO;
                } completion:^(BOOL finished) {
                }];
            } else {
                weakSelf.isOpen = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.massageView.alpha = 0;
                    weakSelf.massageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }
        } else {//去结算
            CCSureOrderViewController *vc = [CCSureOrderViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:self.massageView];
    [self.massageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(13);
        make.bottom.mas_equalTo(self.view).mas_offset(-(56+HOME_INDICATOR_HEIGHT));
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(78);
    }];
}
#pragma mark  -  get
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}
- (CCServiceMassageView *)massageView {
    if (!_massageView) {
        _massageView = [[CCServiceMassageView alloc] init];
        _massageView.hidden = YES;
    }
    return _massageView;
}
- (CCShopBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCShopBottomView alloc] initWithFrame:CGRectZero inView:self.view];
    }
    return _bottomView;
}

- (SH_MallSubclassificationSelectView *)mallSelectView{
    XYWeakSelf;
    if (_mallSelectView==nil) {
        _mallSelectView = [[SH_MallSubclassificationSelectView alloc] initWithFrame:CGRectMake(0,
                                                                                               NAVIGATION_BAR_HEIGHT,
                                                                                               Window_W,
                                                                                               RationHeight(48))];
        
        _mallSelectView.selctButtonClickBlock = ^(MallSelectedType selectedType) {
            [weakSelf.dataArray removeAllObjects];
            switch (selectedType) {
                case SelectedTypeComprehensive://综合
                {
                    weakSelf.sortColumn = 0;
                    weakSelf.sortType = 0;
                }
                    break;
                case SelectedTypeSalesVolumeUp://销量升
                {
                    weakSelf.sortColumn = 1;
                    weakSelf.sortType = 1;

                }
                    break;
                case SelectedTypeSalesVolumeDown://销量降
                {
                    weakSelf.sortColumn = 1;
                    weakSelf.sortType = 0;

                }
                    break;
                case SelectedTypePriceUp://价格升
                {
                    weakSelf.sortColumn = 2;
                    weakSelf.sortType = 1;

                }
                    break;
                case SelectedTypePriceDown://价格降
                {
                    weakSelf.sortColumn = 2;
                    weakSelf.sortType = 0;

                }
                    break;
                case MallSelectedTypeShaiXuan://价格降
                {
                    [weakSelf clickItem];
                }
                    break;
                default:
                    break;
            }
            [weakSelf requestData];
        };
    }
    return _mallSelectView;
    
}
- (void)clickItem {
  
    weakself(self);
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc] init];
    configuration.recordSeleted = NO;
    configuration.menuWidth = Window_W-kWidth(105);
    configuration.dropMenuType = GHDropMenuTypeFilter;
    configuration.optionNormalColor = COLOR_333333;
    configuration.optionSeletedColor = kWhiteColor;
    configuration.titleViewBackGroundColor = kRedColor;
    configuration.titleNormalColor = COLOR_333333;
    configuration.titles = [configuration creaFilterDropMenuData];
    GHDropMenu *dropMenu = [GHDropMenu creatDropFilterMenuWidthConfiguration:configuration dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        
    }];
    dropMenu.delegate = self;
//    dropMenu.dataSource = self;
    dropMenu.durationTime = 0.5;
    [dropMenu show];
}
#pragma mark - 代理方法
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
}

- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
}
-(UITableView *)tableView{
    
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   NAVIGATION_BAR_HEIGHT+RationHeight(48),
                                                                   Window_W,
                                                                   Window_H - RationHeight(48) - NAVIGATION_BAR_HEIGHT)
                                                  style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kWhiteColor;
        [_tableView registerNib:CCEverDayTeTableViewCell.loadNib forCellReuseIdentifier:@"CCEverDayTe"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCEverDayTeTableViewCell *cell = [CCEverDayTeTableViewCell cellWithTableView:tableView model:self.dataArray[indexPath.row] indexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - private methods
- (void)rightBtnClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchAction {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
