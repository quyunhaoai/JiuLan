//
//  CCWarningSetViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

//#import "CCWarningSetViewController.h"
//
//@interface CCWarningSetViewController ()
//
//@end
//
//@implementation CCWarningSetViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
//
//  CCInGoodsListViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWarningSetViewController.h"
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
@interface CCWarningSetViewController ()<UITextFieldDelegate,KKCommonDelegate>
@property (nonatomic,copy) NSString *catedity1ID;
@property (nonatomic,copy) NSString *catedity3ID;
@property (nonatomic,copy) NSString *catedity2ID;
@property (nonatomic,copy) NSString *pinpaiID;  // <#name#>
@property (nonatomic,copy) NSString *search;  // <#name#>

@end

@implementation CCWarningSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"库存预警设置"];
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
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    CCMyGoodsList *model = (CCMyGoodsList *)item;
    XYWeakSelf;
    NSDictionary *params = @{@"up_warn":model.up_warn,
                             @"down_warn":model.down_warn,
    };
    NSString *path =[NSString stringWithFormat:@"/app0/stockwarnset/%ld/",(long)model.id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            [weakSelf.tableView.mj_header beginRefreshing];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

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
    
    NSString *path = @"/app0/stockwarnset/";
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
        weakSelf.pinpaiID = pinPaiID;
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
    UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCMyGoodsList modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
    [(CCMyGoodsListTableViewCell *)cell setDelegate:self];
    CCMyGoodsListTableViewCell *cellccc = (CCMyGoodsListTableViewCell *)cell;
    cellccc.changeButton.hidden = NO;
    CCMyGoodsList *model = [CCMyGoodsList modelWithJSON:self.dataSoureArray[indexPath.row]];
    cellccc.textField1.text = model.up_warn;
    cellccc.textField2.text = model.down_warn;
    cellccc.textField2.hidden = NO;
    cellccc.textField1.hidden = NO;
    cellccc.botttomTitleLab.text = @"高库存预警数量";
    cellccc.bottomTitle2Lab.text = @"低库存预警数量";
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 171;
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
}

@end
