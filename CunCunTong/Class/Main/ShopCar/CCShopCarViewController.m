//
//  CCShopCarViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/6.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopCarViewController.h"
#import "CCShopCarListModel.h"
#import "CCShopBottomView.h"
#import "CCShopCarTableViewCell.h"
#import "KKButton.h"
#import "CCSureOrderViewController.h"
#import "CCCommodDetaildViewController.h"
@interface CCShopCarViewController ()<KKCCShopCarTableViewCellDelegate>
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UILabel *totalCutLab;
@property (strong, nonatomic) NSMutableDictionary * DataDic;
@property (nonatomic,strong) KKButton *allSelectBtn; // <#name#>
@property (nonatomic,strong) UIButton *sureBtn; // <#name#>
@property (strong, nonatomic) UILabel *sumLab; //

@property (strong, nonatomic) NSMutableArray *selectGoodsArray;

@end

@implementation CCShopCarViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
    [self addTableViewHeadRefresh];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"refreshShopCarInfo" object:nil];
}

- (void)setupUI {
    [self customNavBarWithTitle:@"购物车"];
    if (self.isShowLeftButton) {
        [(UIButton *)self.navTitleView.leftBtns[0] setHidden:NO];
    } else {
        [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(-48);
    }];
    self.tableView.backgroundColor = kWhiteColor;
    [self.tableView registerNib:CCShopCarTableViewCell.loadNib forCellReuseIdentifier:@"cell12345"];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 35)];
    KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 12;
    [rightBtn setTitle:@"清空购物车" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAME(@"删除图标") forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    rightBtn.frame = CGRectMake(Window_W-90, 7.5, 80, 20);
    [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    self.tableView.tableHeaderView = headView;
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"结算(0)" forState:UIControlStateNormal];
        [view setBackgroundColor:kMainColor];
        [view.titleLabel setTextColor:kWhiteColor];
        [view.titleLabel setFont:FONT_14];
        view.tag = 111;
        [view setUserInteractionEnabled:YES];
        [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 19;
        view.layer.masksToBounds = YES;
        view ;
    });
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(91);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(38);
        make.bottom.mas_equalTo(self.view).mas_offset(-5);
    }];
    self.sureBtn = sureBtn;
    KKButton *allButtton = ({
        KKButton *view = [KKButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"全选" forState:UIControlStateNormal];
        [view setImage:IMAGE_NAME(@"未选中图标") forState:UIControlStateNormal];
        [view setImage:IMAGE_NAME(@"选中图标") forState:UIControlStateSelected];
        [view setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_14];
        view.tag = 112;
        [view setUserInteractionEnabled:YES];
        [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    [self.view addSubview:allButtton];
    [allButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(78);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.height.mas_equalTo(43);
        make.bottom.mas_equalTo(self.view).mas_offset(-5);
    }];
    self.allSelectBtn = allButtton;
    [self.allSelectBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight
                                       imageTitleSpace:10];
    UILabel *titleLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });
    [self.view addSubview:titleLab];
    [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(217, 14));
        make.centerY.mas_equalTo(self.sureBtn).mas_offset(0);
    }];
    self.sumLab = titleLab;
    CGFloat total_play_price = 0;
    NSString *str = [NSString stringWithFormat:@"合计:￥%@",STRING_FROM_0_FLOAT(total_play_price)];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计:"]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计:"]];
    titleLab.attributedText = textColor;
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = COLOR_e5e5e5;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-47);
        make.height.mas_equalTo(1);
    }];
    self.baseTableView = self.tableView;
}

- (void)commentBtnClick:(UIButton *)button {
    if (button.tag == 112) {
        button.selected = !button.isSelected;
        NSArray *results = [NSArray array];
        [self.selectGoodsArray removeAllObjects];
        results = self.dataArray;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        if (button.isSelected) {
            CGFloat total_play_price = 0;
            for (NSDictionary *dict in results) {
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                [mutableDict setValue:[NSNumber numberWithBool:YES] forKey:@"isSelect"];
                [array addObject:mutableDict];
                CCShopCarListModel *model = [CCShopCarListModel modelWithJSON:dict];
                [self.selectGoodsArray addObject:model];
                CGFloat price = model.count * [model.play_price floatValue];
                total_play_price = total_play_price + price;
            }
            [self.sureBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",array.count] forState:UIControlStateNormal];
            
            NSString *str = [NSString stringWithFormat:@"合计:￥%@",STRING_FROM_0_FLOAT(total_play_price)];
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:krgb(253,103,51)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:kBlackColor
                              range:[str rangeOfString:@"合计:"]];
            [textColor addAttribute:NSFontAttributeName
                              value:STFont(19)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSFontAttributeName
                              value:FONT_14
                              range:[str rangeOfString:@"合计:"]];
            self.sumLab.attributedText = textColor;
        } else {
           for (NSDictionary *dict in results) {
               NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
               [mutableDict setValue:[NSNumber numberWithBool:NO] forKey:@"isSelect"];
                [array addObject:mutableDict];
            }
            [self.sureBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
            CGFloat total_play_price = 0;
            NSString *str = [NSString stringWithFormat:@"合计:￥%@",STRING_FROM_0_FLOAT(total_play_price)];
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:krgb(253,103,51)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:kBlackColor
                              range:[str rangeOfString:@"合计:"]];
            [textColor addAttribute:NSFontAttributeName
                              value:STFont(19)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSFontAttributeName
                              value:FONT_14
                              range:[str rangeOfString:@"合计:"]];
            self.sumLab.attributedText = textColor;
            [self.selectGoodsArray removeAllObjects];
        }
        self.dataArray = array.copy;
        [self.tableView reloadData];
    } else {
        if (self.selectGoodsArray.count) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (CCShopCarListModel *model in self.selectGoodsArray) {
                [arr addObject:[NSNumber numberWithInteger:model.ccid]];
            }
            CCSureOrderViewController *vc = [[CCSureOrderViewController alloc] initWithTypes:@"0"
                                                                                  withmcarts:arr
                                                                           withCenter_sku_id:@""
                                                                                   withCount:@""];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [MBManager showBriefAlert:@"您还没有选择商品"];
        }

    }
}

- (void)initData {
    [self requestShopCarData];
}
- (void)requestShopCarData {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path = @"/app0/mcarts/?limit=10";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.DataDic = data.mutableCopy;
            if (weakSelf.dataArray.count) {
                weakSelf.showTableBlankView = NO;
            } else {
                weakSelf.showTableBlankView = YES;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.sureBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
            CGFloat total_play_price = 0;
            NSString *str = [NSString stringWithFormat:@"合计:￥%@",STRING_FROM_0_FLOAT(total_play_price)];
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:krgb(253,103,51)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSForegroundColorAttributeName
                              value:kBlackColor
                              range:[str rangeOfString:@"合计:"]];
            [textColor addAttribute:NSFontAttributeName
                              value:STFont(19)
                              range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_play_price)]]];
            [textColor addAttribute:NSFontAttributeName
                              value:FONT_14
                              range:[str rangeOfString:@"合计:"]];
            weakSelf.sumLab.attributedText = textColor;
            [weakSelf.selectGoodsArray removeAllObjects];
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

#pragma mark  -  TableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 121.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell12345"];
    cell.Model = [CCShopCarListModel modelWithJSON:self.dataArray[indexPath.row]];
    cell.delegate = self;
    cell.selectButton.hidden = NO;
    cell.imageViewLeftConstraints.constant = 41;
    cell.isVC = YES;
    cell.path = indexPath;
    cell.lineView.hidden = NO;
    return cell;
}
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    CCShopCarListModel *model =[CCShopCarListModel modelWithJSON:self.dataArray[indexPath.row]];
    CCCommodDetaildViewController *vc = [CCCommodDetaildViewController new];
    vc.goodsID =STRING_FROM_INTAGER(model.center_goods_id);
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickPPNumberWithItem:(id)item isAdd:(BOOL)isAdd indexPaht:(NSIndexPath *)path ppnumberButton:(PPNumberButton *)numberButton withSelectButtonState:(BOOL)isSelect{
    CCShopCarListModel *model = (CCShopCarListModel *)item;
    NSString *total_price =[NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT(BACKINFO_DIC_2_FLOAT(self.DataDic, @"total_price"))];
    NSString *total_cut = [NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT(BACKINFO_DIC_2_FLOAT(self.DataDic, @"total_cut"))];
    XYWeakSelf;
    NSDictionary *params = @{
    };
    if (self.isChexiao) {
        params = @{@"point":isAdd ? @(1):@(0),
        };
    } else {
        params = @{@"total_price":total_price,
                   @"total_cut":total_cut,
                   @"point":isAdd ? @(1):@(0),
        };
    }
    NSString *paths =self.isChexiao ? [NSString stringWithFormat:@"/app0/caraddcarts/%ld/",model.ccid] : [NSString stringWithFormat:@"/app0/mcarts/%ld/",model.ccid];
    [[STHttpResquest sharedManager] requestWithPUTMethod:PUT
                                                WithPath:paths
                                              WithParams:params
                                        WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSLog(@"%@",dic);
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            CGFloat total_price = BACKINFO_DIC_2_FLOAT(data, @"total_price");
            CGFloat total_cutfloat = BACKINFO_DIC_2_FLOAT(data, @"total_cut");
            [weakSelf.DataDic setValue:[NSNumber numberWithFloat:total_cutfloat] forKey:@"total_cut"];
            [weakSelf.DataDic setValue:[NSNumber numberWithFloat:total_price] forKey:@"total_price"];
            NSString *total_cut = [NSString stringWithFormat:@"已优惠%@元",STRING_FROM_0_FLOAT(total_cutfloat)];
            int count = BACKINFO_DIC_2_INT(data, @"count");
            model.isSelect = isSelect;
            model.count = count;
            model.total_play_price =[NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT([model.play_price floatValue] * count)];
            NSMutableArray *dataArr = weakSelf.dataArray.mutableCopy;
            if (count == 0) {
                [dataArr removeObjectAtIndex:path.row];
                if ([weakSelf.selectGoodsArray containsObject:model]) {
                    [weakSelf.selectGoodsArray removeObject:model];
                }
               dispatch_async(dispatch_get_main_queue(), ^{
                   [weakSelf.sureBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",weakSelf.selectGoodsArray.count]
                                  forState:UIControlStateNormal];
               });
            } else {
                [dataArr replaceObjectAtIndex:path.row withObject:model.modelToJSONObject];
            }
            weakSelf.dataArray = dataArr.copy;
            if (weakSelf.dataArray.count == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.showTableBlankView = YES;
                    [kNotificationCenter postNotificationName:@"requestShopCarData1" object:nil];
                });
            } else {
                weakSelf.showTableBlankView = NO;
            }
            if (!weakSelf.isChexiao) {
                if (!isSelect) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [weakSelf.tableView reloadData];
                        });
                    return;;
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat total_price333 = 0;
                if (self.isChexiao) {
                    NSString *string = weakSelf.sumLab.text;
                    string = [string stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                    string = [string stringByReplacingOccurrencesOfString:@"合计:" withString:@""];
                    total_price333 = [string floatValue];
                    if (isAdd) {
                        total_price333 = total_price333 + [model.play_price floatValue];
                    } else {
                        total_price333 = total_price333 - [model.play_price floatValue];
                    }
                }
                //189-00
                NSString *str = [NSString stringWithFormat:@"合计:￥%@",self.isChexiao ? STRING_FROM_0_FLOAT(total_price333):STRING_FROM_0_FLOAT(total_price)];
                NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
                [textColor addAttribute:NSForegroundColorAttributeName
                                  value:krgb(253,103,51)
                                  range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",self.isChexiao ? STRING_FROM_0_FLOAT(total_price333):STRING_FROM_0_FLOAT(total_price)]]];
                [textColor addAttribute:NSForegroundColorAttributeName
                                  value:kBlackColor
                                  range:[str rangeOfString:@"合计:"]];
                [textColor addAttribute:NSFontAttributeName
                                  value:STFont(19)
                                  range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",self.isChexiao ? STRING_FROM_0_FLOAT(total_price333):STRING_FROM_0_FLOAT(total_price)]]];
                [textColor addAttribute:NSFontAttributeName
                                  value:FONT_14
                                  range:[str rangeOfString:@"合计:"]];
                weakSelf.sumLab.attributedText = textColor;
                weakSelf.totalCutLab.text = total_cut;
                [weakSelf.tableView reloadData];
            });
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
            int count = numberButton.currentNumber;
            if (isAdd) {
                numberButton.currentNumber = count-1;
            } else {
                numberButton.currentNumber = count+1;
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}
- (void)clickPPNumberWithItem:(id)item isAdd:(BOOL)isAdd indexPaht:(NSIndexPath *)path ppnumberButton:(PPNumberButton *)numberButton{
    CCShopCarListModel *model = (CCShopCarListModel *)item;
    CGFloat total_price333 = 0;
    NSString *string = self.sumLab.text;
    string = [string stringByReplacingOccurrencesOfString:@"合计" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    total_price333 = [string floatValue];
    if (isAdd) {
        if (![self.selectGoodsArray containsObject:model]) {
            [self.selectGoodsArray addObject:model];
        }
        total_price333 = total_price333 + ([model.play_price floatValue] * model.count);
    } else {
        total_price333 = total_price333 - ([model.play_price floatValue] * model.count);
        if (total_price333 < 0) {
            total_price333 = 0;
        }
        if ([self.selectGoodsArray containsObject:model]) {
            [self.selectGoodsArray removeObject:model];
        }
    }
    //189-00
    NSString *str = [NSString stringWithFormat:@"合计:￥%@",STRING_FROM_0_FLOAT(total_price333)];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc] initWithString:str];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:krgb(253,103,51)
                      range:[str rangeOfString:[NSString stringWithFormat:@"￥%@", STRING_FROM_0_FLOAT(total_price333)]]];
    [textColor addAttribute:NSForegroundColorAttributeName
                      value:kBlackColor
                      range:[str rangeOfString:@"合计:"]];
    [textColor addAttribute:NSFontAttributeName
                      value:STFont(19)
                      range:[str rangeOfString:[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_price333)]]];
    [textColor addAttribute:NSFontAttributeName
                      value:FONT_14
                      range:[str rangeOfString:@"合计:"]];
    self.sumLab.attributedText = textColor;
    [self.sureBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectGoodsArray.count] forState:UIControlStateNormal];
}

- (void)botBtnClick:(UIButton *)btn {
    XYWeakSelf;
    NSDictionary *params = @{};
    NSString *path =self.isChexiao ? @"/app0/caraddcarts/0/" : @"/app0/mcarts/0/";
    [[STHttpResquest sharedManager] requestWithMethod:DELETE
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSString *price = @"￥0.00";
            //189-00
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"￥0.00"];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                   range:NSMakeRange(0, 1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                              green:255.0f/255.0f
                                                                                               blue:255.0f/255.0f
                                                                                              alpha:1.0f]
                                   range:NSMakeRange(0, 1)];
            //189-00 text-style1
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                   range:NSMakeRange(1, price.length-1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                              green:255.0f/255.0f
                                                                                               blue:255.0f/255.0f
                                                                                              alpha:1.0f]
                                   range:NSMakeRange(1, price.length-1)];
            weakSelf.sumLab.attributedText = attributedString;
            [weakSelf.tableView.mj_header beginRefreshing];
            [kNotificationCenter postNotificationName:@"requestShopCarData1" object:nil];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

- (void)setDataDic:(NSMutableDictionary *)DataDic {
    _DataDic = DataDic;
    NSArray *results = [NSArray array];
    if (self.isChexiao) {
        results = _DataDic[@"carts"];
    } else {
        results = _DataDic[@"results"];
    }
    self.dataArray = results;
    self.totalCutLab.text = [NSString stringWithFormat:@"已优惠%@元",STRING_FROM_0_FLOAT([_DataDic[@"total_cut"] floatValue])];
    [self.tableView reloadData];
}

- (NSMutableArray *)selectGoodsArray {
    if (!_selectGoodsArray) {
        _selectGoodsArray = [[NSMutableArray alloc] init];
    }
    return _selectGoodsArray;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"refreshShopCarInfo" object:nil];
}
@end
