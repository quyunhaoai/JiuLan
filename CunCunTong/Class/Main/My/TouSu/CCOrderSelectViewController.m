//
//  CCOrderSelectViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.

#import "CCOrderSelectViewController.h"
#import "CCMyOrderModel.h"
#import "CCOrderDetailViewController.h"
#import "CCReturnGoodsDetailViewController.h"
#import "CCOrderSearchViewController.h"
#import "CCSelectGoodsTableViewCell.h"
#import "KKButton.h"
#import "CCNowPayViewController.h"
#import "CCBackOrderListModel.h"
@interface CCOrderSelectViewController ()<SegmentTapViewDelegate,UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) KKNoDataView *noDataView;
@property (strong, nonatomic) UISegmentedControl *segCccc;
@property (strong, nonatomic) Goods_order_setItem *model;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) KKButton *allSelectBtn;

@property (assign, nonatomic) BOOL isallSelect;
@property (strong, nonatomic) NSMutableArray *m_total_order_id_listArray;

@end

@implementation CCOrderSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self customNavBarWithTitle:@"订单选择"];
    [self setupUI];
    [self initData];
    [self.tableView registerNib:CCSelectGoodsTableViewCell.loadNib forCellReuseIdentifier:@"CCSelectGoodsTableViewCell"];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    params = @{@"limit":@(10),
               @"offset":@(self.page*10),
    };
    NSString *path = @"/app0/conplainchooseorder/";
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

- (void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view).mas_offset(-51);
    }];
    self.baseTableView = self.tableView;
    [self addTableViewRefresh];
}

- (IBAction)sureButtonAction:(UIButton *)sender {
    if (self.blackAction) {
        self.blackAction(self.m_total_order_id_listArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSoureArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[section]];
    return model.goods_order_set.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
    Goods_order_setItem *item = model.goods_order_set[indexPath.row];
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
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*98, Window_W, 98)];
            view.backgroundColor = kWhiteColor;
            [cell.contentView addSubview:view];
            [self addViewToCell:view andSku:sku index:i];
        }
        return cell;
    } else {
        CCSelectGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCSelectGoodsTableViewCell"];
        cell.index = indexPath;
        cell.delegate = self;
        cell.goodsModel = item;
        cell.skuModel = item.sku_order_set[0];
        return cell;
    }
}
#pragma mark  -  kkcommDelegate
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item andInView:(UIView *)View andCommonCell:(NSIndexPath *)index{
    UIButton *button = (UIButton *)View;
    Sku_order_setItem *subItem = item;
    if (button.isSelected) {
        [self.m_total_order_id_listArray addObject:[NSNumber numberWithInteger:subItem.ccid]];
    } else {
        [self.m_total_order_id_listArray removeObject:[NSNumber numberWithInteger:subItem.ccid]];
    }
    self.sumlab.text = [NSString stringWithFormat:@"已选择（%ld）",self.m_total_order_id_listArray.count];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[indexPath.section]];
    Goods_order_setItem *item = model.goods_order_set[indexPath.row];
    if (item.sku_order_set.count >1) {
        return 98*item.sku_order_set.count;
    } else {
        return 98;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
     view.backgroundColor = kWhiteColor;
     UILabel *titleLab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_999999;
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view ;
     });
     [view addSubview:titleLab];
     [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(view).mas_offset(10);
         make.size.mas_equalTo(CGSizeMake(217, 14));
         make.centerY.mas_equalTo(view).mas_offset(0);
     }];
     CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[section]];
     titleLab.text = [NSString stringWithFormat:@"订单号：%@",model.order_num];
     return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)commentBtnClick:(UIButton *)button {
    button.selected = !button.isSelected;
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    CCMyOrderModel *model = [CCMyOrderModel modelWithJSON:self.dataSoureArray[path.section]];
    Goods_order_setItem *item = model.goods_order_set[path.row];
    Sku_order_setItem *subItem = item.sku_order_set[button.tag];
    if (button.isSelected) {
        [self.m_total_order_id_listArray addObject:[NSNumber numberWithInteger:subItem.ccid]];
    } else {
        [self.m_total_order_id_listArray removeObject:[NSNumber numberWithInteger:subItem.ccid]];
    }
    self.sumlab.text = [NSString stringWithFormat:@"已选择（%ld）",self.m_total_order_id_listArray.count];
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
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (i) {
   
    [iconIamgeView4 sd_setImageWithURL:[NSURL URLWithString:sku.image]];
//        } else {
//            [iconIamgeView4 setImageWithURL:[NSURL URLWithString:sku.image] placeholder:IMAGE_NAME(@"")];
//        }
//    });
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
     UIButton *sureBtn = ({
         UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
         [view setBackgroundImage:IMAGE_NAME(@"未选中图标") forState:UIControlStateNormal];
         [view setBackgroundImage:IMAGE_NAME(@"选中图标") forState:UIControlStateSelected];
         [view setUserInteractionEnabled:YES];
         view.tag = i;
         [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
         view ;
     });
     [contentView addSubview:sureBtn];
     [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(10);
         make.height.width.mas_equalTo(15);
         make.centerY.mas_equalTo(contentView).mas_offset(0);
     }];
     [taRendaiFusumTextLab0 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(30);
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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 34;
        CGFloat sectionFooterHeight = 85;
        CGFloat offsetY = tableview.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
    }
}

@end
