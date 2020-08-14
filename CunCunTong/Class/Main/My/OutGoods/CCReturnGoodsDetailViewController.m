//
//  CCReturnGoodsDetailViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsDetailViewController.h"
#import "CCReturnGoodsDetailHeadView.h"
#import "PYPhotosView.h"

#import "CCBackOrderModel.h"
#import "CCReternGoodsDetailMdoel.h"
#import "CCReturnGoodsViewController.h"
@interface CCReturnGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) CCReturnGoodsDetailHeadView *headView;
@property (strong, nonatomic) CCReternGoodsDetailMdoel *model;
@property (nonatomic,strong) UIButton *sureBtn; //

@end

@implementation CCReturnGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customNavBarWithBlackTitle:@"退货详情"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headView.frame = CGRectMake(0, 0, Window_W, 110);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = kWhiteColor;
    [self initData];
    
    UIButton *sureBtn2 = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"修改退货申请" forState:UIControlStateNormal];
        [view setBackgroundColor:kWhiteColor];
        [view.titleLabel setFont:FONT_14];
        [view setTitleColor:kMainColor forState:UIControlStateNormal];
        [view setUserInteractionEnabled:YES];
        [view addTarget:self action:@selector(commentBtnClick:)
       forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 5;
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = kMainColor.CGColor;
        view.layer.masksToBounds = YES;
        view.hidden = YES;
        view ;
    });
    [self.view addSubview:sureBtn2];
    [sureBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(175);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(34);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-20);
    }];
    self.sureBtn = sureBtn2;
}
- (void)commentBtnClick:(UIButton *)button {
    CCReturnGoodsViewController *vc = [CCReturnGoodsViewController new];
    vc.skuID = STRING_FROM_INTAGER(self.model.ccid);
    vc.total_count = self.model.amount;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = [NSString stringWithFormat:@"/app0/backorderlist/%@/",self.orderID];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.model = [CCReternGoodsDetailMdoel modelWithJSON:data];
            weakSelf.headView.stateImage.image = IMAGE_NAME(@"箱子同意图标");
            NSString *desString = @"";//    状态,0：待审核，1：拒绝，2-3：待出发，4：在路上，5：待提货，6:商品有误，关闭，-1和7：待退款，8：待确认收款，9：已完成
            if (weakSelf.model.status == 0) {
                desString = [NSString stringWithFormat:@"退货申请已提交\n申请时间：%@",weakSelf.model.create_time];;
            } else if (self.model.status == 1){
                if (weakSelf.model.types == 1) {
                    desString = [NSString stringWithFormat:@"平台已拒绝您的退款申请\n拒绝原因\n【商品临期】"];
                } else {
                    desString = [NSString stringWithFormat:@"平台已拒绝您的退款申请\n拒绝原因\n【商品未临期】"];
                }
                weakSelf.headView.stateImage.image = IMAGE_NAME(@"箱子拒绝图标");
//                weakSelf.sureBtn.hidden = NO;
            } else if (self.model.status == 2 ||self.model.status == 3){
                desString =[NSString stringWithFormat:@"平台已同意您的退货申请\n配送员:%@ 电话：%@\n将会联系您上门取件，请保持电话畅通 \n审核时间：%@",weakSelf.model.driver_info.name,weakSelf.model.driver_info.mobile,weakSelf.model.check_time];
            } else if (self.model.status == 4){
                desString =[NSString stringWithFormat:@"平台已同意您的退货申请\n配送员:%@ 电话：%@\n将会联系您上门取件，请保持电话畅通 \n审核时间：%@",weakSelf.model.driver_info.name,weakSelf.model.driver_info.mobile,weakSelf.model.check_time];
            } else if (self.model.status == 5){
                desString =[NSString stringWithFormat:@"平台已同意您的退货申请\n配送员:%@ 电话：%@\n将会联系您上门取件，请保持电话畅通 \n审核时间：%@",weakSelf.model.driver_info.name,weakSelf.model.driver_info.mobile,weakSelf.model.check_time];
            } else if (self.model.status == 6){
                desString =[NSString stringWithFormat:@"商品有误,已关闭"];
            } else if (self.model.status == -1 ||self.model.status == 7){
                desString =[NSString stringWithFormat:@"商家已确认收货\n货款将会在1-3个工作日退回您的账户\n收货时间：%@",weakSelf.model.recive_time];
            } else if (self.model.status == 8){
                desString =[NSString stringWithFormat:@"商家已确认收货\n货款将会在1-3个工作日退回您的账户\n收货时间：%@",weakSelf.model.recive_time];
            } else if (self.model.status == 9){
                desString =[NSString stringWithFormat:@"退款成功\n退款账户：余额\n退款时间：%@",weakSelf.model.pay_time];
            }
            weakSelf.headView.ccctitleLab.text = desString;
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
- (CCReturnGoodsDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[CCReturnGoodsDetailHeadView alloc] init];
    }
    return _headView;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSMutableArray *toaArry = [NSMutableArray arrayWithCapacity:0];
        if (self.model.types == 1) {
            [toaArry addObject:[NSString stringWithFormat:@"退货原因：临期退货"]];
        } else {
            [toaArry addObject:[NSString stringWithFormat:@"退货原因：非临期退货"]];
        }
        [toaArry addObject:[NSString stringWithFormat:@"退货数量：%ld%@",(long)self.model.amount,self.model.play_unit]];
        [toaArry addObject:[NSString stringWithFormat:@"生产日期：%@",_model.product_date]];
        [toaArry addObject:[NSString stringWithFormat:@"退款金额：%@",STRING_FROM_0_FLOAT(self.model.total_play_price)]];
        [toaArry addObject:[NSString stringWithFormat:@"退款说明：%@",self.model.remark]];
        for (int i = 0; i < toaArry.count; i++) {
            UILabel *TextLab = ({
                UILabel *view = [[UILabel alloc] init];
                view.textColor = COLOR_666666;
                view.font = FONT_14;
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 1;
                view ;
            });
            [cell.contentView addSubview:TextLab];
            [TextLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cell.contentView).mas_offset(7+20*i);
                make.left.mas_equalTo(cell.contentView).mas_offset(10);
                make.width.mas_equalTo(Window_W/2);
                make.height.mas_equalTo(17);
            }];
            TextLab.text = toaArry[i];
        }
        UIView *line = [UIView new];
        line.backgroundColor =  [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.08f];;
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(Window_W-20, 1));
            make.top.mas_equalTo(87+17+10);
        }];
        UILabel *titleLab = ({
            UILabel *view = [[UILabel alloc] init];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"凭证：";
            view ;
        });
        [cell.contentView addSubview:titleLab];
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
        }];

        // 2. 创建一个photosView
        PYPhotosView *photosView = [PYPhotosView photosViewWithThumbnailUrls:self.model.order_photo_set originalUrls:@[]];
        // 3. 添加photosView
        [cell.contentView addSubview:photosView];
        [photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-10);
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        }];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"退款信息";
            view ;
        });
        [cell.contentView addSubview:titleLab];
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(10);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor =  [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.08f];;
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(Window_W-20, 1));
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        }];
        UIImageView *iconIamgeView4 = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.layer.masksToBounds = YES ;
            view ;
        });
        [cell.contentView addSubview:iconIamgeView4];
        [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-7);
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.height.width.mas_equalTo(76);
        }];
        [iconIamgeView4 sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:IMAGE_NAME(@"")];
        UILabel *taRendaiFusumTextLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        taRendaiFusumTextLab2.text = self.model.goods_name;
        [cell.contentView addSubview:taRendaiFusumTextLab2];
        [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(iconIamgeView4.mas_top);
        }];
        UILabel *taRendaiFusumTextLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        if (self.model.specoption_set.count) {
            NSMutableString *string = [[NSMutableString alloc] init];
            if (self.model.specoption_set.count == 1) {
                [string appendString:self.model.specoption_set[0]];
            } else {
                [string appendString:self.model.specoption_set[0]];
                for (NSString *item in self.model.specoption_set) {
                    if ([item isEqual:string]) {
                        continue;
                    }
                    [string appendFormat:@",%@",item];
                }
            }
            taRendaiFusumTextLab3.text = string;
        }
        [cell.contentView addSubview:taRendaiFusumTextLab3];
        [taRendaiFusumTextLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab2.mas_bottom).mas_offset(8);
        }];
        UILabel *taRendaiFusumTextLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(16);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view ;
        });
        taRendaiFusumTextLab1.text = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(self.model.play_price)];
        [cell.contentView addSubview:taRendaiFusumTextLab1];
        [taRendaiFusumTextLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.centerY.mas_equalTo(taRendaiFusumTextLab2);
        }];
        UILabel *taRendaiFusumTextLab4 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_999999	;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view ;
        });
        taRendaiFusumTextLab4.text = [NSString stringWithFormat:@"x%ld",self.model.amount];
        [cell.contentView addSubview:taRendaiFusumTextLab4];
        [taRendaiFusumTextLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(taRendaiFusumTextLab1.mas_bottom).mas_offset(5);
        }];
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return 338;
    }
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColorHex(0xf7f7f7);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
