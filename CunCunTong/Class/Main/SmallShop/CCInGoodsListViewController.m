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
#import "CCShaiXuanAlertView.h"
#import "CCMyGoodsListTableViewCell.h"
#import "CCCommodDetaildViewController.h"
#import "CCOrderSelectView.h"
#import "NKAlertView.h"
#import "CCKucunDetailViewController.h"
#import "CCKuCunGoodsListTableViewCell.h"
#import "CCNearWarnModel.h"
#import "CCKuCunWarnGoodsListTableViewCell.h"
#import "CCReturnGoodsViewController.h"
@interface CCInGoodsListViewController ()<UITextFieldDelegate,KKCommonDelegate>
@property (nonatomic,copy) NSString *catedity1ID;
@property (nonatomic,copy) NSString *catedity3ID;
@property (nonatomic,copy) NSString *catedity2ID;
@property (nonatomic,copy) NSString *pinpaiID;  //
@property (nonatomic,copy) NSString *search;  //

@end

@implementation CCInGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.navTitleStr isNotBlank] ) {
        [self customNavBarWithTitle:self.navTitleStr];
    } else if ([self.types isEqualToString:@"102"]){
        [self customNavBarWithTitle:@"临期预警"];
    } else if ([self.types isEqualToString:@"101"]){
        [self customNavBarWithTitle:@"低库存预警"];
    } else if ([self.types isEqualToString:@"100"]){
        [self customNavBarWithTitle:@"高库存预警"];
    }

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
    if (type == 1) {
        CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
        vc.goodsID = STRING_FROM_INTAGER(model.goods_id);
        [self.navigationController pushViewController:vc animated:YES];
    }else if (type == 3) {
        CCReturnGoodsViewController *vc = [CCReturnGoodsViewController new];
        vc.skuID = STRING_FROM_INTAGER(model.id);
        vc.total_count = model.count;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NKAlertView *alert = [[NKAlertView alloc] init];
        CCOrderSelectView *centerView = [[CCOrderSelectView alloc] initWithFrame:CGRectMake(0, 0, Window_W-80, 257)];
        centerView.model = model;
        XYWeakSelf;
        centerView.sureBlack = ^(NSInteger count, NSInteger sku_id) {
            [weakSelf salessOut:count Center_sku_id:sku_id];
        };
        alert.contentView = centerView;
        alert.type = NKAlertViewTypeDef;
        alert.hiddenWhenTapBG = YES;
        [alert show];
    }
}
- (void)salessOut:(NSInteger )count Center_sku_id:(NSInteger )ID {
    XYWeakSelf;
    NSDictionary *params = @{@"center_sku_id":@(ID),
                             @"count":@(count),
    };
    NSString *path = @"/app0/salessomeone/";
    [[STHttpResquest sharedManager] requestWithPUTMethod:POST
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            [weakSelf.tableView.mj_header beginRefreshing];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
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
    
    NSString *path = @"/app0/skulist/";
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
                             @"types":self.types,
                             @"search":self.search,
    };
    if ([self.types isEqualToString:@"102"]) {//临期预警
        path = @"/app0/childorderbatchnearlist/";
        params = @{@"limit":@(10),
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
    } if ([self.types isEqualToString:@"103"]) {
        path = @"/app0/skuprofitlist/";
        params = @{@"limit":@(10),
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
    } if ([self.types isEqualToString:@"101"]) {
        path = @"/app0/stockwarnlist/";
        params = @{@"limit":@(10),
                     @"offset":@(self.page*10),
                     @"category1_id":self.catedity1ID,
                     @"category2_id":self.catedity2ID,
                     @"category3_id":self.catedity3ID,
                     @"goods_name":@"",
                     @"bar_code":@"",
                     @"specoption":@"",
                     @"brand_id":self.pinpaiID,
                     @"search":self.search,
                   @"types":@(0)
        };
    } if ([self.types isEqualToString:@"100"]) {
        path = @"/app0/stockwarnlist/";
        params = @{@"limit":@(10),
                     @"offset":@(self.page*10),
                     @"category1_id":self.catedity1ID,
                     @"category2_id":self.catedity2ID,
                     @"category3_id":self.catedity3ID,
                     @"goods_name":@"",
                     @"bar_code":@"",
                     @"specoption":@"",
                     @"brand_id":self.pinpaiID,
                     @"search":self.search,
                     @"types":@(1)
        };
    }
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
    if ([self.types isEqualToString:@"102"] ) {//临期预警
        CCKuCunGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCKuCunGoodsList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CCNearWarnModel *model = [CCNearWarnModel modelWithJSON:self.dataSoureArray[indexPath.row]];
        cell.warnModel = model;
        return cell;
    } else if ( [self.types isEqualToString:@"101"]||[self.types isEqualToString:@"100"]){
        CCKuCunWarnGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCKuCunWarnGoodsListTableViewCell"];
        CCNearWarnModel *model = [CCNearWarnModel modelWithJSON:self.dataSoureArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.warnModel = model;
        NSDictionary *dict = self.dataSoureArray[indexPath.row];
        NSArray *arr = dict[@"specoption_set"];
        if (arr.count) {
            NSString *str = arr[0];
               //500-ml
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",arr[0]]];
               [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
               [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
               //500-ml text-style1
            [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, str.length)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, str.length)];
               cell.gugeLab.attributedText = attributedString2;
        }
        return cell;
    } else {
         UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:[CCMyGoodsList modelWithJSON:self.dataSoureArray[indexPath.row]] indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [(CCMyGoodsListTableViewCell *)cell setDelegate:self];
        CCMyGoodsListTableViewCell *cellccc = (CCMyGoodsListTableViewCell *)cell;
        if ([self.types isEqualToString:@"103"]) {
            NSDictionary *dict = self.dataSoureArray[indexPath.row];
            NSDictionary *profit_info = dict[@"profit_info"];
            cellccc.inNumberLab.text =[NSString stringWithFormat:@"%d",[profit_info[@"profit"] intValue]];
            cellccc.buyNumber.text =[NSString stringWithFormat:@"%.0f%@",[profit_info[@"percent"] floatValue],@"%"];
            cellccc.botttomTitleLab.text = @"利润";
            cellccc.bottomTitle2Lab.text = @"毛利率";
        } else if ([self.types isEqualToString:@"2"]) {
            [(CCMyGoodsListTableViewCell *)cell setIsKUCun:YES];
            NSDictionary *dict = self.dataSoureArray[indexPath.row];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"库存数量：%d",[dict[@"count"] intValue]]];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 5)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%d",[dict[@"count"] intValue]].length)];
            cellccc.kucunLab.attributedText = attributedString;
        } else if ([self.types isEqualToString:@"1"]){
            [(CCMyGoodsListTableViewCell *)cell setIsKUCun:NO];
            cellccc.botttomTitleLab.text = @"销售数量";
            cellccc.bottomTitle2Lab.text = @"销售金额";
            NSDictionary *dict = self.dataSoureArray[indexPath.row];
            cellccc.inNumberLab.text =[NSString stringWithFormat:@"%d",[dict[@"count"] intValue]];
            cellccc.buyNumber.text =[NSString stringWithFormat:@"%.0f",[dict[@"count_price"] floatValue]];
        } else {
            [(CCMyGoodsListTableViewCell *)cell setIsKUCun:NO];
            cellccc.botttomTitleLab.text = @"进货数量";
            cellccc.bottomTitle2Lab.text = @"进货金额";
            NSDictionary *dict = self.dataSoureArray[indexPath.row];
            cellccc.inNumberLab.text =[NSString stringWithFormat:@"%d",[dict[@"count"] intValue]];
            cellccc.buyNumber.text =[NSString stringWithFormat:@"%.0f",[dict[@"count_price"] floatValue]];
        }
        return cell;
    }

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
    if ([self.types isEqualToString:@"2"]) {
        CCKucunDetailViewController *vc = [CCKucunDetailViewController new];
        CCMyGoodsList *model = [CCMyGoodsList modelWithJSON:self.dataSoureArray[indexPath.row]];
        vc.goodsID = STRING_FROM_INTAGER(model.id);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
