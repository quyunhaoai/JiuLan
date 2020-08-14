
//
//  CCTemGoodsSelectViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTemGoodsSelectViewController.h"
#import "CCMyGoodsList.h"
#import "CCSearchView.h"
#import "CCShaiXuanGoodsView.h"
#import "CCShaiXuanAlertView.h"
#import "CCMyGoodsListTableViewCell.h"
#import "CCCommodDetaildViewController.h"
#import "CCOrderSelectView.h"
#import "NKAlertView.h"
#import "CCKucunDetailViewController.h"
#import "CCKuCunGoodsListTableViewCell.h"
#import "CCNearWarnModel.h"
#import "CCKuCunWarnGoodsListTableViewCell.h"
#import "CCKuCunListTableViewCell.h"
#import "CCTemGoodsModel.h"
@interface CCTemGoodsSelectViewController ()<UITextFieldDelegate,KKCommonDelegate>
@property (nonatomic,copy) NSString *catedity1ID;
@property (nonatomic,copy) NSString *catedity3ID;
@property (nonatomic,copy) NSString *catedity2ID;
@property (nonatomic,copy) NSString *pinpaiID;  //
@property (nonatomic,copy) NSString *search;  //

@end

@implementation CCTemGoodsSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"选择商品"];
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    [self.tableView registerNib:CCKuCunGoodsListTableViewCell.loadNib
         forCellReuseIdentifier:@"CCKuCunGoodsList"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 45);
    }];
    self.catedity3ID = @"";
    self.catedity2ID = @"";
    self.catedity1ID = @"";
    self.pinpaiID = @"";
    self.search = @"";
    [self initData];
    [self setupUI];
    [self addTableViewRefresh];
    [self.tableView registerNib:CCKuCunListTableViewCell.loadNib forCellReuseIdentifier:@"CCKuCunListTableViewCell"];
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
    searchView.searchTextField.delegate = self;
    self.baseTableView = self.tableView;
}
#pragma mark  -  kkcommonDelegate

#pragma mark  -  textfiledDelegate
- (void)textfiledChange:(UITextField *)textField {
    self.search = textField.text;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (NSString *)SubStringfrom:(UITextField *)textField andLength:(NSUInteger )length {
    return textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.search = textField.text;
    textField.text = @"";
    self.page = 0;
    [self.dataSoureArray removeAllObjects];
    [self initData];
    return YES;
}
- (void)initData {
    
    NSString *path = @"/app0/nearactionskulist/";
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@(10),
                             @"offset":@(self.page*10),
                             @"category1_id":self.catedity1ID,
                             @"category2_id":self.catedity2ID,
                             @"category3_id":self.catedity3ID,
                             @"goods_name":@"",
                             @"bar_code":@"",
                             @"specoption":@"",
                             @"brand_id":self.pinpaiID,
                             @"search":self.search,
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            NSString *next = data[@"next"];
            NSArray *array = data[@"results"];
            if (weakSelf.page) {
                [weakSelf.dataSoureArray addObjectsFromArray:array];
            } else {
                weakSelf.dataSoureArray = array.mutableCopy;
                if (weakSelf.dataSoureArray.count) {
                    weakSelf.showTableBlankView = NO;
                } else {
                    weakSelf.showTableBlankView = YES;
                }
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if ([next isKindOfClass:[NSNull class]] || next == nil) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }

            [weakSelf.tableView reloadData];
            weakSelf.page ++;
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)showTableView {
    XYWeakSelf;
    CCShaiXuanAlertView *alert = [[CCShaiXuanAlertView alloc] initWithFrame:self.view.frame inView:self.view];
    CCShaiXuanGoodsView *view=  [[CCShaiXuanGoodsView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 122)];
    alert.contentView = view;
    view.blackID = ^(NSString * _Nonnull catedity1ID, NSString * _Nonnull catedity2ID, NSString * _Nonnull catedity3ID, NSString * _Nonnull pinPaiID) {
        weakSelf.catedity3ID = catedity3ID;
        weakSelf.catedity2ID = catedity2ID;
        weakSelf.catedity1ID = catedity1ID;
        if ([pinPaiID isEqualToString:@"999999"]) {
            weakSelf.pinpaiID = @"";
        } else {
            weakSelf.pinpaiID = pinPaiID;
        }
        if ([catedity1ID isEqualToString:@"999999"] || [catedity2ID isEqualToString:@"999999"]) {
            weakSelf.catedity2ID = @"";
            weakSelf.catedity1ID = @"";
            weakSelf.catedity3ID = @"";
        }
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    alert.hiddenWhenTapBG = YES;
    alert.type = NKAlertViewTypeTop;
    [alert show];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCKuCunListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCKuCunListTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CCTemGoodsModel *model = [CCTemGoodsModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    cell.temModel = model;
    cell.unitLab.hidden = NO;
    if ([self.selectName isEqualToString:model.goods_name]) {
        cell.selectImageIcon.hidden = NO;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 141;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCTemGoodsModel *model = [CCTemGoodsModel modelWithJSON:self.dataSoureArray[indexPath.row]];
    if (self.clickSelectGoods) {
        self.clickSelectGoods(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
