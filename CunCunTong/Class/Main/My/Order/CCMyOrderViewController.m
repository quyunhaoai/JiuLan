//
//  CCMyOrderViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyOrderViewController.h"
#import "CCMyOrderModel.h"
#import "CCOrderDetailViewController.h"
#import "CCReturnGoodsDetailViewController.h"
#import "CCOrderSearchViewController.h"
#import "CCMyOrderModelTableViewCell.h"
#import "KKButton.h"
#import "CCNowPayViewController.h"
#import "CCBackOrderListModel.h"
#import "CCHeadInfoTableViewCell.h"
#import "CCFooterInfoTableViewCell.h"
@interface CCMyOrderViewController ()<SegmentTapViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SegmentTapView *segment;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) KKNoDataView *noDataView;
@property (strong, nonatomic) UISegmentedControl *segCccc;
@property (strong, nonatomic) Goods_order_setItem *model;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) KKButton *allSelectBtn;

@property (assign, nonatomic) BOOL isallSelect;
@property (strong, nonatomic) NSMutableArray *m_total_order_id_listArray;

@end

@implementation CCMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self.segment selectIndex:self.selectIndex+1];
    if (self.type == 1) {
        self.segCccc.selectedSegmentIndex = 1;
        [self.segment removeFromSuperview];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5);
        }];
    } else {
        self.segCccc.selectedSegmentIndex = 0;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5+40);
        }];
    }
    [self addTableViewRefresh];
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    if (self.type == 1) {
        params = @{@"limit":@(10),
                   @"offset":@(self.page*10),
        };
    } else {
        if (self.selectIndex == 0) {
            params = @{@"limit":@(10),
                       @"offset":@(self.page*10),
            };
        } else if (self.selectIndex == 3){
            params = @{@"limit":@(10),
                       @"offset":@(self.page*10),
                       @"status":@"2,5",
            };
        } else {
            NSInteger status = self.selectIndex - 1;
            params = @{@"limit":@(10),
                       @"offset":@(self.page*10),
                       @"status":@(status),
            };
        }
    }
    if (self.selectIndex == 4) {
        NSString *path = @"/app0/backorderlist/" ;
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
                      if (!weakSelf.dataSoureArray.count) {
                          [weakSelf.view addSubview:self.noDataView];
                          [weakSelf.noDataView masMakeConstraints:^(MASConstraintMaker *make) {
                              make.centerX.equalTo(self.view).mas_offset(0);
                              make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5+40);
                              make.width.mas_equalTo(Window_W);
                              make.bottom.mas_equalTo(self.view);
                          }];
                          weakSelf.noDataView.tipText = @"暂时没有相关订单哦~";
                          weakSelf.noDataView.tipImage = IMAGE_NAME(@"无订单缺省页图标");
                          [weakSelf.noDataView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                              make.bottom.mas_equalTo(self.noDataView.mas_centerY).mas_offset(-15);
                              make.size.mas_equalTo(CGSizeMake(146, 125));
                          }];
                      } else {
                          [weakSelf.noDataView removeFromSuperview];
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
    } else {
        NSString *path =self.type == 1 ? @"/app0/mycarorder/" : @"/app0/myorder/";
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
                      if (!weakSelf.dataSoureArray.count) {
                          [weakSelf.view addSubview:self.noDataView];
                          [weakSelf.noDataView masMakeConstraints:^(MASConstraintMaker *make) {
                              make.centerX.equalTo(self.view).mas_offset(0);
                              make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5+40);
                              make.width.mas_equalTo(Window_W);
                              make.bottom.mas_equalTo(self.view);
                          }];
                          weakSelf.noDataView.tipText = @"暂时没有相关订单哦~";
                          weakSelf.noDataView.tipImage = IMAGE_NAME(@"无订单缺省页图标");
                          [weakSelf.noDataView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                              make.bottom.mas_equalTo(self.noDataView.mas_centerY).mas_offset(-15);
                              make.size.mas_equalTo(CGSizeMake(146, 125));
                          }];
                      } else {
                          [weakSelf.noDataView removeFromSuperview];
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
}

- (void)setupUI {
    self.view.backgroundColor = UIColorHex(0xf7f7f7);
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"搜索图标白") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"我的订单" andLeftView:@"" andRightView:@[rightBtn]];
    UIView *bgView=[UIView new];
    [self.view addSubview:bgView];
    bgView.backgroundColor = kWhiteColor;
    bgView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, 48+5);
    //创建segmentControl 分段控件
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectZero];
    //添加小按钮
    [segC insertSegmentWithTitle:@"要货订单" atIndex:0 animated:NO];
    [segC insertSegmentWithTitle:@"车销订单" atIndex:1 animated:NO];
    //设置样式
    [segC setTintColor:krgb(36,149,143)];
    self.segCccc = segC;
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segC];
    [segC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT + 15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(33);
    }];
    segC.selectedSegmentIndex = 0;
    [segC ensureiOS12Style];
    [self initSegment];

    self.baseTableView = self.tableView;
    [self.tableView registerClass:CCHeadInfoTableViewCell.class
           forCellReuseIdentifier:@"CCHeadInfoTableViewCell"];
    [self.tableView registerClass:CCFooterInfoTableViewCell.class
           forCellReuseIdentifier:@"CCFooterInfoTableViewCell"];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSoureArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectIndex == 4) {
        return 1+2;
    }
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[section]];
    return model.goods_order_set.count+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CCHeadInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCHeadInfoTableViewCell"];
        if (self.selectIndex == 4) {
            CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[indexPath.section]];
            cell.backModel = model;
        } else {
            CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
            cell.model = model;
        }
        return cell;
    }
    if (self.selectIndex == 4) {
        if (indexPath.row == 2) {
            CCFooterInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCFooterInfoTableViewCell"
                                                                              forIndexPath:indexPath];
            CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[indexPath.section]];
            if (model.status == 8 || model.status == 1 || model.status ==9 || model.status == 6) {
                cell.line1View.hidden = NO;
                if (model.status == 8) {
                    [cell.sureBtn setTitle:@"确认收款" forState:UIControlStateNormal];
                    [cell.sureBtn setBackgroundColor:kWhiteColor];
                    [cell.sureBtn.titleLabel setFont:FONT_14];
                    [cell.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                    cell.sureBtn.tag = indexPath.section;
                    [cell.sureBtn setUserInteractionEnabled:YES];
                    [cell.sureBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.sureBtn.layer.cornerRadius = 5;
                    cell.sureBtn.layer.borderWidth = 0.5;
                    cell.sureBtn.layer.borderColor = kMainColor.CGColor;
                    cell.sureBtn.layer.masksToBounds = YES;
                    cell.sureBtn.hidden = NO;
                }else if(model.status == 1 || model.status == 9 || model.status == 6){
                     [cell.sureBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                     [cell.sureBtn setBackgroundColor:kWhiteColor];
                     [cell.sureBtn.titleLabel setFont:FONT_14];
                     [cell.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                     cell.sureBtn.tag =indexPath.section;
                     [cell.sureBtn setUserInteractionEnabled:YES];
                     [cell.sureBtn addTarget:self action:@selector(commentBtnClick:)
                    forControlEvents:UIControlEventTouchUpInside];
                     cell.sureBtn.layer.cornerRadius = 5;
                     cell.sureBtn.layer.borderWidth = 0.5;
                     cell.sureBtn.layer.borderColor = kMainColor.CGColor;
                     cell.sureBtn.layer.masksToBounds = YES;
                    cell.line1View.hidden = NO;
                    cell.sureBtn.hidden = NO;
                }
            } else {
                cell.line1View.hidden = YES;
                cell.sureBtn2.hidden = YES;
                cell.sureBtn.hidden = YES;
            }
            cell.backModel = model;
            return cell;
        }
        CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[indexPath.section]];
        CCMyOrderModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCMyOrderModel"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgoodsModel = model;
        return cell;
    } else {
        CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
        if (indexPath.row == model.goods_order_set.count+1) {
            CCFooterInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCFooterInfoTableViewCell" forIndexPath:indexPath];
            if (self.selectIndex == 1 || model.status == 0) {
                  [cell.sureBtn2 setTitle:@"取消订单" forState:UIControlStateNormal];
                  [cell.sureBtn2 setBackgroundColor:kWhiteColor];
                  [cell.sureBtn2.titleLabel setFont:FONT_14];
                  [cell.sureBtn2 setTitleColor:COLOR_999999 forState:UIControlStateNormal];
                  cell.sureBtn2.tag =indexPath.section;
                  [cell.sureBtn2 setUserInteractionEnabled:YES];
                  [cell.sureBtn2 addTarget:self action:@selector(commentBtnClick:)
                 forControlEvents:UIControlEventTouchUpInside];
                  cell.sureBtn2.layer.cornerRadius = 5;
                  cell.sureBtn2.layer.borderWidth = 0.5;
                  cell.sureBtn2.layer.borderColor = COLOR_999999.CGColor;
                  cell.sureBtn2.layer.masksToBounds = YES;
                 [cell.sureBtn setTitle:@"立即支付" forState:UIControlStateNormal];
                 [cell.sureBtn setBackgroundColor:kWhiteColor];
                 [cell.sureBtn.titleLabel setFont:FONT_14];
                 [cell.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                 cell.sureBtn.tag =indexPath.section;
                 [cell.sureBtn setUserInteractionEnabled:YES];
                 [cell.sureBtn addTarget:self action:@selector(commentBtnClick:)
                forControlEvents:UIControlEventTouchUpInside];
                 cell.sureBtn.layer.cornerRadius = 5;
                 cell.sureBtn.layer.borderWidth = 0.5;
                 cell.sureBtn.layer.borderColor = kMainColor.CGColor;
                 cell.sureBtn.layer.masksToBounds = YES;
                cell.line1View.hidden = NO;
                cell.sureBtn2.hidden = NO;
                cell.sureBtn.hidden = NO;
            }else if(model.status == 3 || model.status == 4){
                 [cell.sureBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                 [cell.sureBtn setBackgroundColor:kWhiteColor];
                 [cell.sureBtn.titleLabel setFont:FONT_14];
                 [cell.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                 cell.sureBtn.tag =indexPath.section;
                 [cell.sureBtn setUserInteractionEnabled:YES];
                 [cell.sureBtn addTarget:self action:@selector(commentBtnClick:)
                forControlEvents:UIControlEventTouchUpInside];
                 cell.sureBtn.layer.cornerRadius = 5;
                 cell.sureBtn.layer.borderWidth = 0.5;
                 cell.sureBtn.layer.borderColor = kMainColor.CGColor;
                 cell.sureBtn.layer.masksToBounds = YES;
                cell.line1View.hidden = NO;
                cell.sureBtn.hidden = NO;
            }else if(self.selectIndex == 3||model.status == 2 || model.status == 5){
                 [cell.sureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                 [cell.sureBtn setBackgroundColor:kWhiteColor];
                 [cell.sureBtn.titleLabel setFont:FONT_14];
                 [cell.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                 cell.sureBtn.tag =indexPath.section;
                 [cell.sureBtn setUserInteractionEnabled:YES];
                 [cell.sureBtn addTarget:self action:@selector(commentBtnClick:)
                forControlEvents:UIControlEventTouchUpInside];
                 cell.sureBtn.layer.cornerRadius = 5;
                 cell.sureBtn.layer.borderWidth = 0.5;
                 cell.sureBtn.layer.borderColor = kMainColor.CGColor;
                 cell.sureBtn.layer.masksToBounds = YES;
                cell.line1View.hidden = NO;
                cell.sureBtn.hidden = NO;
                cell.sureBtn2.hidden = YES;
            } else {
                cell.line1View.hidden = YES;
                cell.sureBtn2.hidden = YES;
                cell.sureBtn.hidden = YES;
            }
            cell.model = model;
            return cell;
        }
        Goods_order_setItem *item = model.goods_order_set[indexPath.row-1];
        if (item.sku_order_set.count >1) {
            static NSString *CellIdentifier = @"CellIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.backgroundColor = [UIColor whiteColor];
            }
            [cell.contentView removeAllSubviews];
            self.model = item;
            for ( int i = 0; i < item.sku_order_set.count; i++ ) {
                Sku_order_setItem *sku = item.sku_order_set[i];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*98, Window_W-20, 98)];
                view.backgroundColor = kWhiteColor;
                [cell.contentView addSubview:view];
                [self addViewToCell:view andSku:sku index:i];
                if (model.status >= 1 && i == item.sku_order_set.count-1) {
                    UILabel *nameLab = ({
                        UILabel *view = [UILabel new];
                        view.textColor =COLOR_666666;
                        view.font = STFont(12);
                        view.lineBreakMode = NSLineBreakByTruncatingTail;
                        view.backgroundColor = [UIColor clearColor];
                        view.textAlignment = NSTextAlignmentRight;
                        view ;
                    });
                    [cell.contentView addSubview:nameLab];
                    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(view).mas_offset(-10);
                        make.size.mas_equalTo(CGSizeMake(302, 14));
                        make.top.mas_equalTo(cell.contentView.mas_bottom).mas_offset(-24);
                    }];
                    if (item.total_play_price == item.total_old_play_price) {
                        nameLab.text = [NSString stringWithFormat:@"实付款￥%ld",item.total_play_price];
                    } else {
                        nameLab.text = [NSString stringWithFormat:@"总价￥%ld 优惠￥%ld 实付款￥%ld",item.total_old_play_price,item.total_old_play_price-item.total_play_price,item.total_play_price];
                    }
                }
            }
            return cell;
        } else {
            CCMyOrderModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCMyOrderModel"];
            if (_type == 1) {
                cell.skuModel = item.sku_order_set[0];
            } else {
                cell.mainOrderModel = model;
                cell.goodsModel = item;
                cell.skuModel = item.sku_order_set[0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44;
    }
    if (self.selectIndex == 4) {
        CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[indexPath.section]];
        if (indexPath.row == 2) {
            if (model.status == 8 || model.status == 1 || model.status ==9 || model.status == 6) {
                return 120;
            } else {
                return 60;
            }
        }
        return 128;
    }
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
    if (indexPath.row == model.goods_order_set.count+1) {
        if (self.selectIndex == 1 || model.status == 0 || model.status == 3 || model.status == 4 || self.selectIndex == 3 ||model.status == 2 || model.status == 5) {
            return 120;
        }
        return 60;
    }
    Goods_order_setItem *item = model.goods_order_set[indexPath.row-1];
    if (item.sku_order_set.count >1) {
        if (model.status >= 1) {
            return 98*item.sku_order_set.count+34;
        }
        return 98*item.sku_order_set.count;
    } else {
        if (model.status >= 1) {
            return 128;
        } else {
            return 98;
        }
    }
    return 128;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)commentBtnClick:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"立即支付"]) {
        CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[button.tag]];
        CCNowPayViewController *vc = [CCNowPayViewController new];
        vc.m_total_order_id = STRING_FROM_INTAGER(model.ccid);
        [self.navigationController pushViewController:vc
                                             animated:YES];
    } else if ([button.titleLabel.text isEqualToString:@"确认收款"]){
        XYWeakSelf;
        NSDictionary *params = @{
        };

        CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[button.tag]];
        NSString *path =[NSString stringWithFormat:@"/app0/backorderlist/%ld/",model.id];
        [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            weakSelf.showErrorView = NO;
            if(status == 0){
                weakSelf.page = 0;
                [weakSelf.tableView.mj_header beginRefreshing];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            weakSelf.showErrorView = YES;
        }];
    } else if ([button.titleLabel.text isEqualToString:@"取消订单"]){
        CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[button.tag]];
        XYWeakSelf;
        NSDictionary *params = @{
        };
        NSString *path =self.type == 1 ? [NSString stringWithFormat:@"/app0/canclecarorder/%ld/",model.ccid] : [NSString stringWithFormat:@"/app0/cancleorder/%ld/",model.ccid];
        [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            weakSelf.showErrorView = NO;
            if(status == 0){
                 weakSelf.page = 0;
                 [weakSelf.tableView.mj_header beginRefreshing];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            weakSelf.showErrorView = YES;
        }];
    } else if ([button.titleLabel.text isEqualToString:@"删除订单"]){
        XYWeakSelf;
        CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[button.tag]];
        NSDictionary *params = @{
        };
        NSString *path =self.type == 1 ?[NSString stringWithFormat:@"/app0/mycarorder/%ld/",model.ccid]: [NSString stringWithFormat:@"/app0/myorder/%ld/",model.ccid];
        if (self.selectIndex == 4) {
            CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[button.tag]];
            path = [NSString stringWithFormat:@"/app0/backorderlist/%ld/",model.id];
        }
        [[STHttpResquest sharedManager] requestWithPUTMethod:DELETE
                                                    WithPath:path
                                                  WithParams:params
                                            WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
                weakSelf.page = 0;
                [weakSelf.tableView.mj_header beginRefreshing];
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
        }];
    } else {
        button.selected = !button.isSelected;
        if (button.tag == 112) {
            self.isallSelect = button.isSelected;
            [self.tableView reloadData];
            if (self.isallSelect) {
                [self.m_total_order_id_listArray removeAllObjects];
                for (int i = 0; i<self.dataSoureArray.count; i++) {
                  CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[i]];
                    model.SelectButton = YES;
                    [self.dataSoureArray replaceObjectAtIndex:i withObject:model.modelToJSONObject];
                 [self.m_total_order_id_listArray addObject:[NSNumber numberWithInteger:model.ccid]];
                }
            } else {
                [self.m_total_order_id_listArray removeAllObjects];
                for (int i = 0; i<self.dataSoureArray.count; i++) {
                          CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[i]];
                            model.SelectButton = NO;
                            [self.dataSoureArray replaceObjectAtIndex:i withObject:model.modelToJSONObject];
                    }
            }
        } else if ([button.titleLabel.text isEqualToString:@"确认收货"]){
            XYWeakSelf;
            [self.m_total_order_id_listArray removeAllObjects];
            CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[button.tag]];
            [self.m_total_order_id_listArray addObject:[NSNumber numberWithInteger:model.ccid]];
            NSDictionary *params = @{@"m_total_order_id_list":self.m_total_order_id_listArray,
            };
            NSString *path =self.type == 1 ? @"/app0/mycarorder/0/" : @"/app0/myorder/0/";
            [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                        WithPath:path
                                                      WithParams:params
                                                WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSInteger status = [[dic objectForKey:@"errno"] integerValue];
                NSString *msg = [[dic objectForKey:@"errmsg"] description];
                if(status == 0){
                    weakSelf.page = 0;
                    [weakSelf.tableView.mj_header beginRefreshing];
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
            }];
        } else {
            CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[button.tag]];
            model.SelectButton = button.isSelected;
            [self.dataSoureArray replaceObjectAtIndex:button.tag withObject:model.modelToJSONObject];
            if (model.SelectButton) {
                if ([self.m_total_order_id_listArray containsObject:[NSNumber numberWithInteger:model.ccid]]) {
                    [self.m_total_order_id_listArray removeObject:[NSNumber numberWithInteger:model.ccid]];
                }
                [self.m_total_order_id_listArray addObject:[NSNumber numberWithInteger:model.ccid]];
            } else {
                [self.m_total_order_id_listArray removeObject:[NSNumber numberWithInteger:model.ccid]];
            }
        }
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectIndex == 4) {
        CCBackOrderListModel *model = [CCBackOrderListModel modelWithJSON:self.dataSoureArray[indexPath.section]];
        CCReturnGoodsDetailViewController *vc = [CCReturnGoodsDetailViewController new];
        vc.orderID = STRING_FROM_INTAGER(model.id);
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
        CCOrderDetailViewController *VC = [CCOrderDetailViewController new];
        VC.orderID = STRING_FROM_INTAGER(model.ccid);
        if (self.type == 1) {
            VC.ischeXiao = YES;
        } else {
            VC.ischeXiao = NO;
        }
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            // 圆角弧度半径
            CGFloat cornerRadius = 10.f;
            // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
            cell.backgroundColor = UIColor.clearColor;
            
            // 创建一个shapeLayer
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
            // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
            CGMutablePathRef pathRef = CGPathCreateMutable();
            // 获取cell的size
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            
            // CGRectGetMinY：返回对象顶点坐标
            // CGRectGetMaxY：返回对象底点坐标
            // CGRectGetMinX：返回对象左边缘坐标
            // CGRectGetMaxX：返回对象右边缘坐标
            
            // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
            BOOL addLine = NO;
            // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            if (indexPath.row == 0) {
                // 初始起点为cell的左下角坐标
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                // 起始坐标为左下角，设为p1，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                // 初始起点为cell的左上角坐标
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                // 添加cell的rectangle信息到path中（不包括圆角）
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
            layer.path = pathRef;
            backgroundLayer.path = pathRef;
            // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
            CFRelease(pathRef);
            // 按照shape layer的path填充颜色，类似于渲染render
            // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            layer.fillColor = [UIColor whiteColor].CGColor;
            // 添加分隔线图层
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                // 分隔线颜色取自于原来tableview的分隔线颜色
                lineLayer.backgroundColor = kClearColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            
            // view大小与cell一致
            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
            // 添加自定义圆角后的图层到roundView中
            [roundView.layer insertSublayer:layer atIndex:0];
            roundView.backgroundColor = UIColor.clearColor;
            //cell的背景view
            //cell.selectedBackgroundView = roundView;
            cell.backgroundView = roundView;
            
            //以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
            backgroundLayer.fillColor = tableView.separatorColor.CGColor;
            [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
            selectedBackgroundView.backgroundColor = UIColor.clearColor;
            cell.selectedBackgroundView = selectedBackgroundView;
        }
    }
}

-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0,
                                                                    NAVIGATION_BAR_HEIGHT + 38+15,
                                                                    Window_W,
                                                                    40)
                                           withDataArray:self.titleArray
                                                withFont:15];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kMainColor;
    [self.view addSubview:self.segment];
}

- (void)rightBtAction:(UIButton *)btn {
    CCOrderSearchViewController *vc = [CCOrderSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)segCChanged:(UISegmentedControl *)seg {
    NSInteger i = seg.selectedSegmentIndex;
    self.type = seg.selectedSegmentIndex;
    NSLog(@"切换了状态 %lu",i);
    self.page = 0;
    self.selectIndex = 0;
    if (i== 1) {//车销
        [self.segment removeFromSuperview];
        self.allSelectBtn.hidden = YES;
        self.sureBtn.hidden = YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5);
        }];
        UIButton *button = self.navTitleView.rightBtns[0];
        button.hidden = YES;
    } else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT+15+33+5+40);
        }];
        self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0,
                                                                        NAVIGATION_BAR_HEIGHT + 38+15,
                                                                        Window_W,
                                                                        40)
                                               withDataArray:self.titleArray
                                                    withFont:15];
        self.segment.backgroundColor = kWhiteColor;
        self.segment.delegate = self;
        self.segment.textSelectedColor = kMainColor;
        self.segment.textNomalColor = COLOR_333333;
        self.segment.lineColor = kMainColor;
        [self.view addSubview:self.segment];
        UIButton *button = self.navTitleView.rightBtns[0];
        button.hidden = NO;
    }
    [self.tableView.mj_header beginRefreshing];
}

-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    self.selectIndex = index;
    self.page = 0;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark  -  Get
- (NSMutableArray *)m_total_order_id_listArray {
    if (!_m_total_order_id_listArray) {
        _m_total_order_id_listArray = [[NSMutableArray alloc] init];
    }
    return _m_total_order_id_listArray;
}

- (KKNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[KKNoDataView alloc] init];
    }
    return _noDataView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithArray:@[@"全部",
                                                       @"待付款",
                                                       @"待发货",
                                                       @"待收货",
                                                       @"退货中",
        ]];
    }
    return _titleArray;
}

- (void)addViewToCell:(UIView *)contentView andSku:(Sku_order_setItem *)sku index:(int)i{
//    UIView *line = [UIView new];
//    [contentView addSubview:line];
//    line.frame = CGRectMake(0,0 , kScreenWidth-20, 1);
//    line.backgroundColor = COLOR_e5e5e5;
   UIImageView *iconIamgeView4 = ({
         UIImageView *view = [UIImageView new];
         view.userInteractionEnabled = YES;
         view.contentMode = UIViewContentModeScaleAspectFill;
         view.layer.masksToBounds = YES ;
         view ;
     });
     [contentView addSubview:iconIamgeView4 ];
     [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(contentView).mas_offset(0+10);
         make.left.mas_equalTo(contentView).mas_offset(10);
         make.height.width.mas_equalTo(76);
     }];
    [iconIamgeView4 sd_setImageWithURL:[NSURL URLWithString:sku.image]];
    NSLog(@"---%@---",sku.image);
    UILabel *taRendaiFusumTextLab0 = ({
        UILabel *view = [UILabel new];
        view.textColor =kBlackColor;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = self.model.goods_name;
        view ;
    });
    [contentView addSubview:taRendaiFusumTextLab0];
    [taRendaiFusumTextLab0 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(217, 14));
        make.top.mas_equalTo(0+10);
    }];
    UILabel *taRendaiFusumTextLab1 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = sku.specoption;
        view ;
    });
    [contentView addSubview:taRendaiFusumTextLab1];
    [taRendaiFusumTextLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconIamgeView4.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.top.mas_equalTo(taRendaiFusumTextLab0.mas_bottom).mas_offset(8);
    }];
     UILabel *taRendaiFusumTextLab3 = ({
         UILabel *view = [UILabel new];
         view.textColor =kBlackColor;
         view.font = STFont(14);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentRight;
         view.text = [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(sku.play_price)];
         view ;
     });
     [contentView addSubview:taRendaiFusumTextLab3];
     [taRendaiFusumTextLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(contentView.mas_right).mas_offset(-10);
         make.size.mas_equalTo(CGSizeMake(97, 14));
         make.top.mas_equalTo(0+10);
     }];
     UILabel *taRendaiFusumTextLab4 = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(11);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentRight;
         view.text = [NSString stringWithFormat:@"x%ld",sku.amount];
         view ;
     });
     [contentView addSubview:taRendaiFusumTextLab4];
     [taRendaiFusumTextLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(contentView.mas_right).mas_offset(-10);
         make.size.mas_equalTo(CGSizeMake(117, 14));
         make.top.mas_equalTo(taRendaiFusumTextLab3.mas_bottom).mas_offset(8);
     }];
    UILabel *nameLab1 = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_666666;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [contentView addSubview:nameLab1];
    [nameLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentView).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(302, 14));
        make.bottom.mas_equalTo(iconIamgeView4.mas_bottom).mas_offset(0);
    }];
    NSString *str = [NSString stringWithFormat:@"共%ld件 合计：¥%ld",sku.amount,(long)sku.total_play_price];
    NSString *Strw = [NSString stringWithFormat:@"¥%ld",(long)sku.total_play_price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计："]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:Strw]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计："]];
    nameLab1.attributedText = textColor;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView == self.tableView)
//    {
//        UITableView *tableview = (UITableView *)scrollView;
//        CGFloat sectionHeaderHeight = 34;
//        CGFloat sectionFooterHeight = 85;
//        CGFloat offsetY = tableview.contentOffset.y;
//        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//        {
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
//        {
//            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
//        {
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
//        }
//    }
//}

@end
