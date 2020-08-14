//
//  CCSureOrderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSureOrderViewController.h"
#import "CCSureOrderBottomView.h"
#import "CCSureOrder.h"
#import "NKAlertView.h"
#import "BottomAlert3ContentView.h"
#import "CCCententAlertErWeiMaView.h"
#import "CCAddBlankCarViewController.h"
#import "CCOrderListModel.h"
#import "CCSureOrderTableViewCell.h"
#import "CCNowPayViewController.h"
#import "CCCheXiaoOrderModel.h"
@interface CCSureOrderViewController ()
{
    
}
@property (strong, nonatomic) CCSureOrderBottomView *bottomView;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) NSInteger selectPayType;
@property (assign, nonatomic) BOOL isSlect;
@property (strong, nonatomic) UIView *temView;

@property (strong, nonatomic) CCOrderListModel *orderModel;
@property (strong, nonatomic) CCCheXiaoOrderModel *chexiaoorderModel;
@property (nonatomic,copy) NSString *types;  //
@property (strong, nonatomic) NSArray *mcartsArray;   //
@property (nonatomic,copy) NSString *center_sku_id;  //
@property (nonatomic,copy) NSString *count;  //
@end

@implementation CCSureOrderViewController
- (instancetype)initWithTypes:(NSString *)types withmcarts:(NSArray *)mcarts withCenter_sku_id:(NSString *)center_sku_id withCount:(NSString *)count {
    self = [super self];
    if(self){
        self.types = types;
        self.mcartsArray = mcarts;
        self.center_sku_id = center_sku_id;
        self.count = count;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavBarWithTitle:@"确认订单"];
    self.hhhView.frame = CGRectMake(0, 0, Window_W, 85);
    self.tableView.tableHeaderView = self.hhhView;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view).mas_offset(-51);
    }];
    self.bottomView.frame = CGRectMake(0, Window_H-51, Window_W, 51);
    [self.view addSubview:self.bottomView];
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initData];
    [self setupUI];
}
- (void)setupUI {
//    NKAlertView *alert = [[NKAlertView alloc] init];
//    BottomAlert3ContentView *bottomCententView = [[BottomAlert3ContentView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 197)];;
//    XYWeakSelf;
//    bottomCententView.btnClick = ^{
//        CCAddBlankCarViewController *vc = [CCAddBlankCarViewController new];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    };
//    alert.contentView = bottomCententView;
//    alert.type = NKAlertViewTypeBottom;
//    alert.hiddenWhenTapBG = YES;
//
//    [alert show];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"types":self.types,
                             @"mcarts":[self.mcartsArray componentsJoinedByString:@","],
                             @"center_sku_id":self.center_sku_id,
                             @"count":self.count,
    };
    NSString *path =self.isCheXiao ? @"/app0/makecarorder/" : @"/app0/makeordermcarts/";///app0/makecarorder/
    
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            if (self.isCheXiao) {
                NSDictionary *data = dic[@"data"];
                weakSelf.chexiaoorderModel = [CCCheXiaoOrderModel modelWithJSON:data];
                weakSelf.hhhView.nameLab.text = [NSString stringWithFormat:@"收货人:%@",weakSelf.chexiaoorderModel.person_info.name];;
                weakSelf.hhhView.addressLab.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",weakSelf.chexiaoorderModel.person_info.place1,weakSelf.chexiaoorderModel.person_info.place2,weakSelf.chexiaoorderModel.person_info.place3, weakSelf.chexiaoorderModel.person_info.address];
                weakSelf.hhhView.numberLab.text = weakSelf.chexiaoorderModel.person_info.mobile;
                //
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"合计："];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 3)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
                NSString *str =STRING_FROM_0_FLOAT(weakSelf.chexiaoorderModel.total_price);
                NSString *total_price = [NSString stringWithFormat:@"￥%@",str];
                //234-00
                NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:total_price];
                [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f] range:NSMakeRange(0, total_price.length)];
                [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254.0f/255.0f green:98.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:NSMakeRange(0, total_price.length)];
                [attributedString appendAttributedString:attributedString1];
                weakSelf.bottomView.sumLab.attributedText = attributedString;
                [weakSelf.tableView reloadData];
            } else {
                NSDictionary *data = dic[@"data"];
                weakSelf.orderModel = [CCOrderListModel modelWithJSON:data];
                weakSelf.hhhView.nameLab.text = [NSString stringWithFormat:@"收货人:%@",weakSelf.orderModel.name];;
                weakSelf.hhhView.addressLab.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",weakSelf.orderModel.place1,weakSelf.orderModel.place2,weakSelf.orderModel.place3, weakSelf.orderModel.address];
                weakSelf.hhhView.numberLab.text = weakSelf.orderModel.mobile;
                //
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"合计："];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 3)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
                NSString *str =STRING_FROM_0_FLOAT(weakSelf.orderModel.order_total_price);
                NSString *total_price = [NSString stringWithFormat:@"￥%@",str];
                //234-00
                NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:total_price];
                [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f] range:NSMakeRange(0, total_price.length)];
                [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254.0f/255.0f green:98.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:NSMakeRange(0, total_price.length)];
                NSString *old_price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(weakSelf.orderModel.order_total_old_price)];
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:old_price attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
                [attributedString appendAttributedString:attributedString1];
                [attributedString appendAttributedString:attrStr];
                weakSelf.bottomView.sumLab.attributedText = attributedString;
                [weakSelf.tableView reloadData];
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isCheXiao) {
        return 2;
    } else {
        return self.orderModel.results.count + 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isCheXiao ) {
        if (section == 0) {
            return self.chexiaoorderModel.carts.count;
        } else {
            return 2;
        }
    } else {
        if (section == self.orderModel.results.count ) {
            return 2;
        }
        ResultsItem *arr = self.orderModel.results[section];
        return arr.mcarts_set.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isCheXiao) {
        if(indexPath.section == 1) {
             static NSString *CellIdentifier = @"CellIdentifier2";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             if(cell == nil) {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                 cell.backgroundColor = [UIColor whiteColor];
                 cell.textLabel.textColor = COLOR_333333;
                 cell.textLabel.font = [UIFont systemFontOfSize:14];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
             }
             if(indexPath.row == 0) {
                 cell.textLabel.text = [NSString stringWithFormat:@"商品数量"];
                 cell.detailTextLabel.text = STRING_FROM_INTAGER(self.chexiaoorderModel.total_count);
             } else {
                 cell.textLabel.text = [NSString stringWithFormat:@"商品金额"];
                 NSString *total_price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.chexiaoorderModel.total_price)];
                 //78-00
                 NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:total_price];
                 [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
                 [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
                 //78-00 text-style1
                 [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:19.0f] range:NSMakeRange(1, total_price.length-1)];
                 [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, total_price.length-1)];
                 cell.detailTextLabel.attributedText = attributedString2;
             }
             return cell;
        } else {
             CartsItem *model = self.chexiaoorderModel.carts[indexPath.row];
             CCSureOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCSureOrder"];
             cell.nameLab.text = model.goods_name;
             cell.carModel = model;
             cell.numberBtn.hidden = YES;
             return cell;
         }
    } else {
        if(indexPath.section == self.orderModel.results.count) {
             static NSString *CellIdentifier = @"CellIdentifier2";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             if(cell == nil) {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                 cell.backgroundColor = [UIColor whiteColor];
                 cell.textLabel.textColor = COLOR_333333;
                 cell.textLabel.font = [UIFont systemFontOfSize:14];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
             }
             if(indexPath.row == 0) {
                 cell.textLabel.text = [NSString stringWithFormat:@"商品数量"];
                 cell.detailTextLabel.text = STRING_FROM_INTAGER(self.orderModel.mcarts_id_list.count);
             } else {
                 cell.textLabel.text = [NSString stringWithFormat:@"商品金额"];
                 NSString *total_price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.orderModel.order_total_price)];
                 //78-00
                 NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:total_price];
                 [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
                 [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
                 //78-00 text-style1
                 [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:19.0f] range:NSMakeRange(1, total_price.length-1)];
                 [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, total_price.length-1)];
                 cell.detailTextLabel.attributedText = attributedString2;
             }
             return cell;
         }
         ResultsItem *arr = self.orderModel.results[indexPath.section];
         if (indexPath.row == arr.mcarts_set.count) {
             static NSString *CellIdentifier = @"CellIdentifier";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             if(cell == nil) {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                 cell.backgroundColor = [UIColor whiteColor];
                 cell.detailTextLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                 cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
             }
             //2
             NSString *cout =[NSString stringWithFormat:@"共%@件",STRING_FROM_INTAGER(arr.mcarts_set.count)];
             
             NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cout];
             [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12.0f] range:NSMakeRange(0, cout.length)];
             [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] range:NSMakeRange(0, cout.length)];
             //
             NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"小计："];
             [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
             [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
             NSString *total_price = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(arr.goods_total_price)];
             //78-00
             NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:total_price];
             [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f] range:NSMakeRange(0, 1)];
             [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];
             //78-00 text-style1
             [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:19.0f] range:NSMakeRange(1, total_price.length-1)];
             [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:69.0f/255.0f blue:4.0f/255.0f alpha:1.0f] range:NSMakeRange(1, total_price.length-1)];
             [attributedString appendAttributedString:attributedString1];
             [attributedString appendAttributedString:attributedString2];
             cell.detailTextLabel.attributedText = attributedString;
             return cell;
         } else {
             CCSureOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCSureOrder"];
             cell.nameLab.text = arr.goods_name;
             cell.model = arr.mcarts_set[indexPath.row];
             cell.numberBtn.hidden = YES;
             return cell;
         }
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isCheXiao) {
        if (indexPath.section == 1) {
            return 40;
        } else {
            return [CCSureOrderTableViewCell height];
        }
    } else {
        if (indexPath.section == self.orderModel.results.count ) {
            return 40;
        }
        ResultsItem *arr = self.orderModel.results[indexPath.section];
        if (indexPath.row == arr.mcarts_set.count) {
            return 40;
        }
        return [CCSureOrderTableViewCell height];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
 
#pragma mark  -  get
-(CCSureOrderHeadView *)hhhView {
    if (!_hhhView) {
        _hhhView = [[CCSureOrderHeadView alloc] init];
        _hhhView.backgroundColor = kWhiteColor;
    }
    return _hhhView;
}

- (CCSureOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCSureOrderBottomView alloc] init];
        [_bottomView.goPayBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_bottomView.goPayBtn addTarget:self
                                 action:@selector(goPayAction)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (void)goPayAction{
    XYWeakSelf;
    NSDictionary *params = @{};
    if (self.isCheXiao) {
        params = @{};
    } else {
        params =  @{@"order_total_price":STRING_FROM_0_FLOAT(self.orderModel.order_total_price),
                    @"mcarts_id_list":self.orderModel.mcarts_id_list,
                    @"types":@(self.orderModel.types),
                    @"center_sku_id":@(self.orderModel.center_sku_id),
                    @"sku_count":@(self.orderModel.sku_count),
           };
    }
    NSString *path =self.isCheXiao ? @"/app0/makecarorder/" : @"/app0/makeordermcarts/";
    [[STHttpResquest sharedManager]requestWithPUTMethod:POST WithPath:path WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *data = dic[@"data"];
                NSString *orderID = STRING_FROM_INTAGER([data[@"m_total_order_id"]  integerValue]);
                if ([orderID isNotBlank] && ![orderID isEqualToString:@"0"]) {
                    CCNowPayViewController *vc = [CCNowPayViewController new];
                    vc.m_total_order_id = orderID;
                    vc.isCheXiao = weakSelf.isCheXiao;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                } else {
                    NSString *message = dic[@"message"];
                    if ([message isNotBlank]) {
                        [MBManager showBriefAlert:message];
                    }
                }
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NKAlertView *alert = [[NKAlertView alloc] init];
//    alert.contentView = [[CCCententAlertErWeiMaView alloc] initWithFrame:CGRectMake(0, 0, 300, 336)];
//    alert.type = NKAlertViewTypeDef;
//    alert.hiddenWhenTapBG = YES;
//
//    [alert show];
}


@end
