
//
//  CCNowPayViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/6/4.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCNowPayViewController.h"
#import "CCSureOrderBottomView.h"
#import "CCSureOrder.h"
#import "NKAlertView.h"
#import "BottomAlert3ContentView.h"
#import "CCCententAlertErWeiMaView.h"
#import "CCAddBlankCarViewController.h"
#import "CCOrderListModel.h"
#import "CCSureOrderTableViewCell.h"
#import "KKButton.h"
#import "CCYouHuiQuanViewController.h"
#import "CCNowpayOrderModel.h"
#import "CCMyOrderViewController.h"
#import "KKThirdTools.h"
#import "LDSDKManager.h"
#import "LDSDKPayService.h"
#import "LDSDKAuthService.h"
@interface CCNowPayViewController ()
{
    
}
@property (strong, nonatomic) CCSureOrderBottomView *bottomView;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) NSInteger selectPayType;
@property (assign, nonatomic) BOOL isSlect;
@property (strong, nonatomic) UIView *temView;

@property (strong, nonatomic) CCNowpayOrderModel *orderModel;
@property (strong, nonatomic) UILabel *titlePriceLab;
@property (assign, nonatomic) CGFloat   youhuiPrice;    //

@end

@implementation CCNowPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithTitle:@"立即支付"];
    self.titlePriceLab.frame = CGRectMake(0, 0, Window_W, 85);
    self.tableView.tableHeaderView = self.titlePriceLab;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.bottomView.frame = CGRectMake(0, Window_H-51, Window_W, 51);
    [self.view addSubview:self.bottomView];
    self.tableView.backgroundColor = UIColorHex(0xf7f7f7);
    [self initData];
    [self setupUI];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    NSDictionary *params = @{};
    NSString *path =[NSString stringWithFormat:self.isCheXiao ? @"/app0/carorderpay/%@/" : @"/app0/choosecoupon/%@/",_m_total_order_id];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.orderModel = [CCNowpayOrderModel modelWithJSON:data];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"合计："];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 3)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
            NSString *str =STRING_FROM_0_FLOAT(weakSelf.orderModel.order_total_price);
            NSString *total_price = [NSString stringWithFormat:@"￥%@",str];
            //234-00
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:total_price];
            [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f] range:NSMakeRange(0, total_price.length)];
            [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254.0f/255.0f green:98.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:NSMakeRange(0, total_price.length)];
            [attributedString appendAttributedString:attributedString1];
            weakSelf.bottomView.sumLab.attributedText = attributedString;
            weakSelf.titlePriceLab.text = total_price;
            [weakSelf.tableView reloadData];
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
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 1;
    } else if (section ==  1) {
        if (_isCheXiao) {
            return 2;
        }
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
       static NSString *CellIdentifier = @"CellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView removeAllSubviews];
        [self cellAddSubViews:cell.contentView];
        return cell;
    } else {
        static NSString *CellIdentifier = @"CellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = COLOR_333333;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_isCheXiao) {
                if(indexPath.row == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"商品数量"];
                    cell.detailTextLabel.text = STRING_FROM_INTAGER(self.orderModel.count);
                    cell.detailTextLabel.textColor = COLOR_333333;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"商品金额"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.orderModel.order_total_price)];
                    cell.detailTextLabel.textColor = kPriceRedCOLOR;
                }
        } else {
                if (indexPath.row == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"优惠券"];
                    if (self.orderModel.coupon_set.count) {
                        NSString *string = [NSString stringWithFormat:@"(您有%ld张优惠券可用)",self.orderModel.coupon_set.count];
                        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"优惠券%@",string]];
                           [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
                           [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
                           //500-ml text-style1
                        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:10.0f] range:NSMakeRange(3, string.length)];
                        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:155/255.0f green:155.0f/255.0f blue:155.0f/255.0f alpha:1.0f] range:NSMakeRange(3, string.length)];
                        cell.textLabel.attributedText = attributedString2;
                    }
                    cell.detailTextLabel.textColor = kPriceRedCOLOR;
                    if (self.youhuiPrice) {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"-￥%@",STRING_FROM_0_FLOAT(self.youhuiPrice)];
                    }
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                } else if(indexPath.row == 1) {
                    cell.textLabel.text = [NSString stringWithFormat:@"商品数量"];
                    cell.detailTextLabel.text = STRING_FROM_INTAGER(self.orderModel.count);
                    cell.detailTextLabel.textColor = COLOR_333333;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"商品金额"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.orderModel.order_total_price)];
                    cell.detailTextLabel.textColor = kPriceRedCOLOR;
                }
        }

        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        if (self.isOpen) {
            return 318-47;
        } else {
            return 132;
        }
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
 
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 1) {
        CCYouHuiQuanViewController *vc = [[CCYouHuiQuanViewController alloc] initWithCoupon_set:self.orderModel.coupon_set];
        XYWeakSelf;
        vc.blackCoupon_id = ^(NSString * _Nonnull coupon_id) {
            [weakSelf requestYouhui:coupon_id];
        };
        vc.isOrderVc = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)requestYouhui:(NSString *)coupon_id{
    XYWeakSelf;
    NSDictionary *params = @{@"coupon_id":coupon_id,
    };
    NSString *path = [NSString stringWithFormat:@"/app0/choosecoupon/%@/",self.orderModel.order_id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"合计："];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f] range:NSMakeRange(0, 3)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
                NSString *str =STRING_FROM_0_FLOAT([data[@"real_total_price"] floatValue]);
                NSString *total_price = [NSString stringWithFormat:@"￥%@",str];
                //234-00
                NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:total_price];
                [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20.0f] range:NSMakeRange(0, total_price.length)];
                [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254.0f/255.0f green:98.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:NSMakeRange(0, total_price.length)];
                [attributedString appendAttributedString:attributedString1];
                weakSelf.bottomView.sumLab.attributedText = attributedString;
                CGFloat youhui =[data[@"order_total_price"] floatValue]-[data[@"real_total_price"] floatValue];
                weakSelf.youhuiPrice = youhui;
                [weakSelf.tableView reloadData];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
#pragma mark  -  get
- (UILabel *)titlePriceLab {
    if (!_titlePriceLab) {
        _titlePriceLab = [[UILabel alloc] init];
        _titlePriceLab.textColor = kPriceRedCOLOR;
        _titlePriceLab.font = STFont(30);
        _titlePriceLab.backgroundColor =kWhiteColor;
        _titlePriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titlePriceLab;
}

- (CCSureOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CCSureOrderBottomView alloc] init];
        [_bottomView.goPayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_bottomView.goPayBtn addTarget:self action:@selector(goPlayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (void)goPlayAction {
    XYWeakSelf;
    NSDictionary *params = @{@"coupon_id":@"",
                             @"pay_type":@(self.selectPayType),
    };
    NSString *path =[NSString stringWithFormat:self.isCheXiao ? @"/app0/carorderpay/%@/" : @"/app0/orderpay/%@/",self.orderModel.order_id];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:path
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                NSInteger status = [[dic objectForKey:@"status"] intValue];
                if (status == 1) {//微信支付
                    NSDictionary *info = dic[@"info"];
                    KKWXPayObject *obj = [[KKWXPayObject alloc] init];
                    obj.prepayId = info[@"prepayid"];
                    obj.partnerId = info[@"partnerid"];
                    obj.nonceStr = info[@"noncestr"];
                    obj.package = info[@"package"];
                    obj.sign = info[@"sign"];
                    obj.timeStamp = [info[@"timestamp"] integerValue];
                    [KKThirdTools paymentWithPlatform:KKThirdPlatformWX payInfo:obj complete:^(KKErrorCode resultCode, NSString *resultString) {
                        if (resultCode == 0) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [MBManager showBriefAlert:@"支付成功"];
                                CCMyOrderViewController *vc = [CCMyOrderViewController new];
                                if (weakSelf.isCheXiao) {
                                    vc.type = 1;
                                }
                                [weakSelf.navigationController pushViewController:vc animated:YES];
                            });
                        } else {
                            NSLog(@"----%@----%@",resultCode,resultString);
                        }
                    }];
                } else if (status == 2){ //支付宝支付
                    NSString *orderInfo =[NSString stringWithFormat:@"%@",dic[@"info"]];
//                    orderInfo = [orderInfo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSLog(@"1%@",orderInfo);
                    orderInfo = [orderInfo stringByRemovingPercentEncoding];
                    NSLog(@"2%@",orderInfo);
//                    NSString *propertyName = [[NSString alloc] initWithCString:orderInfo encoding:NSUTF8StringEncoding];
                    id <LDSDKPayService> payService = [[LDSDKManager share] payService:LDSDKPlatformAliPay];
                    
                    [payService payOrder:orderInfo
                                callback:^(id result, NSError *error) {
                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                    if (error) {
                                        NSString *string = [NSString stringWithFormat:@"Code:%zd Result:%@", error.code, error.userInfo[kErrorMessage]];
                                        [MBManager showBriefAlert:string];
                                    } else {
                                        //支付结果信息
                                        /*
                                         * {
                                                memo = "";
                                                result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2019021863246757\",\"auth_app_id\":\"2019021863246757\",\"charset\":\"UTF-8\",\"timestamp\":\"2019-04-02 16:23:31\",\"out_trade_no\":\"040215341515541\",\"total_amount\":\"0.01\",\"trade_no\":\"2019040222001427751034899210\",\"seller_id\":\"2088431140429592\"},\"sign\":\"Cvj8szxrdNHN6I+B76cl6rJsOX1BNz/8MUANiv/rgHm0c53KVCBidqFaX9P6cZAWxDDVHflAt3HN+siEq9xcS44dK5mnFagkaAMsR6CD4CcVqSHb/P5qLShjuvD8QlFEuEZT8pgZlb+03xAPYx4JzbzXMEYdogb6gWRH9v14TNAXoyzTxWj0EdtLKA58Ml5cJMAnIUQGNU48hwXoELem5vLA2AWFzknRDIS/p84kx9L4tKqDG/BLT4AgqN9pjCXAqu4+qMG6k7H6npFeVoNXROIkuKmKTsdO6ESRA5N0YhjAoNrIN3LMFKHcrOiB+gaQoOjoYYu21sFaxfvPNF7i5g==\",\"sign_type\":\"RSA2\"}";
                                                resultStatus = 9000;
                                            }
                                         */
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [MBManager showBriefAlert:@"支付成功"];
                                            CCMyOrderViewController *vc = [CCMyOrderViewController new];
                                            if (strongSelf.isCheXiao) {
                                                vc.type = 1;
                                            }
                                            [strongSelf.navigationController pushViewController:vc animated:YES];
                                        });
                                    }
                                }];
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBManager showBriefAlert:@"支付成功"];
                        CCMyOrderViewController *vc = [CCMyOrderViewController new];
                        if (weakSelf.isCheXiao) {
                            vc.type = 1;
                        }
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    });
                }
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
//    [alert show];
}

- (void)cellAddSubViews:(UIView *)contentView {
     UILabel *titlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"支付方式";
         view ;
     });
     [contentView addSubview:titlelab];
     [titlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.top.mas_equalTo(contentView).mas_offset(10);
     }];
     
     UIView *zhanHuView = [[UIView alloc] init];
     zhanHuView.userInteractionEnabled = YES;
     [contentView addSubview:zhanHuView];
     [zhanHuView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(titlelab.mas_bottom).mas_offset(15);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:zhanHuView width:1.0 color:kMainColor];
     UIImageView *iconIamgeView = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"选中圆点图标 1"];
         view.layer.masksToBounds = YES ;
         view.tag = 1;
         view ;
     });
     [zhanHuView addSubview:iconIamgeView];
     [iconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *zhuanghutitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"账户余额";
         view ;
     });
     [zhanHuView addSubview:zhuanghutitlelab];
    self.temView = zhanHuView;
    XYWeakSelf;
    [zhanHuView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.isSlect = !weakSelf.isSlect;
        if (weakSelf.isSlect) {
            weakSelf.selectPayType = 0;
        }
        [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
    }];
     [zhuanghutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(zhanHuView).mas_offset(0);
     }];
     UILabel *yuEtitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view ;
     });
    yuEtitlelab.text = [NSString stringWithFormat:@"可用余额：￥%ld",(long)self.orderModel.balance];
    CGFloat width = [yuEtitlelab.text widthForFont:STFont(12)];
     [contentView addSubview:yuEtitlelab];
     [yuEtitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(width+10, 14));
         make.top.mas_equalTo(zhanHuView.mas_bottom).mas_offset(10);
     }];
     UIButton *chongzhiBtn = ({
         UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
         [view setTitleColor:kMainColor forState:UIControlStateNormal];
         [view setTitle:@"充值" forState:UIControlStateNormal];
         [view.titleLabel setFont:FONT_15];
         view.tag = 3;
         [view addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
         view ;
     });
     [contentView addSubview:chongzhiBtn];
     [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(yuEtitlelab.mas_right).mas_offset(5);
         make.size.mas_equalTo(CGSizeMake(50, 25));
         make.centerY.mas_equalTo(yuEtitlelab).mas_offset(0);
     }];
     KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
     rightBtn.tag = 11;
     [rightBtn setTitle:@"其他" forState:UIControlStateNormal];
     if (self.isOpen) {
        [rightBtn setImage:IMAGE_NAME(@"上箭头") forState:UIControlStateNormal];
     } else {
        [rightBtn setImage:IMAGE_NAME(@"下箭头") forState:UIControlStateNormal];
     }
     [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [rightBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [contentView addSubview:rightBtn];
     [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(yuEtitlelab.mas_bottom).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(50, 25));
         make.centerX.mas_equalTo(contentView).mas_offset(0);
     }];
     [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    if (!self.isOpen) {
        return;
    }
     UIView *weixinView = [[UIView alloc] init];
     [contentView addSubview:weixinView];
     [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(rightBtn.mas_bottom).mas_offset(10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:weixinView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView1 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
          view.tag = 1;
         view ;
     });
     [weixinView addSubview:iconIamgeView1];
     [iconIamgeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(weixinView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *weixintitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"微信支付";
         view ;
     });
     [weixinView addSubview:weixintitlelab];
     [weixintitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView1.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(weixinView).mas_offset(0);
     }];
    UIImageView *iconIamge1 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleToFill;
        view.image = [UIImage imageNamed:@"微信图标 1"];
        view.layer.masksToBounds = YES ;
         view.tag = 1;
        view ;
    });
    [weixinView addSubview:iconIamge1];
    [iconIamge1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weixinView).mas_offset(0);
        make.right.mas_equalTo(contentView).mas_offset(-21);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(25);
    }];
     [weixinView addTapGestureWithBlock:^(UIView *gestureView) {
         weakSelf.isSlect = !weakSelf.isSlect;
         if (weakSelf.isSlect) {
             weakSelf.selectPayType = 1;
         }
         [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
     }];
     UIView *zhifubaoView = [[UIView alloc] init];
     [contentView addSubview:zhifubaoView];
     [zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(weixinView.mas_bottom).mas_offset(15);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:zhifubaoView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView2 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
          view.tag = 1;
         view ;
     });
     [zhifubaoView addSubview:iconIamgeView2];
     [iconIamgeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *zhifubaotitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"支付宝支付";
         view ;
     });
     [zhifubaoView addSubview:zhifubaotitlelab];
     [zhifubaotitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView2.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
     }];
    UIImageView *iconIamge2 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"支付宝图标"];
        view.layer.masksToBounds = YES ;
         view.tag = 1;
        view ;
    });
    [zhifubaoView addSubview:iconIamge2];
    [iconIamge2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zhifubaoView).mas_offset(0);
        make.right.mas_equalTo(contentView).mas_offset(-21);
        make.height.width.mas_equalTo(18);
    }];
     [zhifubaoView addTapGestureWithBlock:^(UIView *gestureView) {
         weakSelf.isSlect = !weakSelf.isSlect;
         if (weakSelf.isSlect) {
             weakSelf.selectPayType = 2;
         }
         [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
     }];
     UIView *tarendaifuView = [[UIView alloc] init];
     [contentView addSubview:tarendaifuView];
     [tarendaifuView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(zhifubaoView.mas_bottom).mas_offset(10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.right.mas_equalTo(contentView).mas_offset(-10);
         make.height.mas_equalTo(32);
     }];
     [[CCTools sharedInstance] addborderToView:tarendaifuView width:1.0 color:COLOR_e5e5e5];
     UIImageView *iconIamgeView4 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.image = [UIImage imageNamed:@"未选中圆点图标"];
         view.layer.masksToBounds = YES ;
         view.tag = 1;
         view ;
     });
     [tarendaifuView addSubview:iconIamgeView4];
     [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
         make.left.mas_equalTo(contentView).mas_offset(15);
         make.height.width.mas_equalTo(13);
     }];
     UILabel *taRendaiFutitlelab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(12);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.text = @"他人代付";
         view ;
     });
     [tarendaifuView addSubview:taRendaiFutitlelab];
     [taRendaiFutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.centerY.mas_equalTo(tarendaifuView).mas_offset(0);
     }];
    [tarendaifuView addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.isSlect = !weakSelf.isSlect;
        if (weakSelf.isSlect) {
            weakSelf.selectPayType = 4;
        }
        [weakSelf setSelectState:gestureView isSelect:weakSelf.isSlect];
    }];
}

- (void)BtnClick:(UIButton *)button {
    if (button.tag == 3) {
        //充值
    } else {
        //其他
        self.isOpen = !self.isOpen;
        [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)setSelectState:(UIView *)view isSelect:(BOOL) isSelect {
    UIImageView *imageView = [view viewWithTag:1];
    if ([self.temView isEqual:view]) {
        if (isSelect) {
            imageView.image = [UIImage imageNamed:@"选中圆点图标 1"];
            [[CCTools sharedInstance] addborderToView:view width:1.0 color:kMainColor];
        } else {
            imageView.image = [UIImage imageNamed:@"未选中圆点图标"];
            [[CCTools sharedInstance] addborderToView:view width:1.0 color:COLOR_e5e5e5];
        }
    } else {
        UIImageView *imageV = [self.temView viewWithTag:1];
        imageV.image = [UIImage imageNamed:@"未选中圆点图标"];
        [[CCTools sharedInstance] addborderToView:self.temView width:1.0 color:COLOR_e5e5e5];
        
        imageView.image = [UIImage imageNamed:@"选中圆点图标 1"];
        [[CCTools sharedInstance] addborderToView:view width:1.0 color:kMainColor];

        self.temView = view;
    }
}
@end
