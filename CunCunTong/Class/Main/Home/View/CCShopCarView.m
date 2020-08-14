//
//  CCShopCarView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCShopCarView.h"
#import "CCShopCarListModel.h"
#import "CCShopBottomView.h"
#import "CCShopCarTableViewCell.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "KKButton.h"
@interface CCShopCarView ()<UITableViewDelegate, UITableViewDataSource,KKCCShopCarTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UILabel *totalCutLab;

@end

@implementation CCShopCarView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 121;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = kMainColor;
        titleLab.font = [UIFont systemFontOfSize:14];
        self.totalCutLab = titleLab;
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 31);
        titleLab.backgroundColor = krgb(232,255,254);
        self.tableView.frame = CGRectMake(0, 71, CGRectGetWidth(frame), CGRectGetHeight(frame) - 71-66);
        [self.tableView registerNib:CCShopCarTableViewCell.loadNib forCellReuseIdentifier:@"cell12345"];
        KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"清空购物车" forState:UIControlStateNormal];
        [rightBtn setImage:IMAGE_NAME(@"删除图标") forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(Window_W-90, 41, 80, 20);
        [rightBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

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
    cell.lineView.hidden = NO;
    cell.path = indexPath;
    return cell;
}
- (void)clickPPNumberWithItem:(id)item isAdd:(BOOL)isAdd indexPaht:(NSIndexPath *)path ppnumberButton:(PPNumberButton *)numberButton{
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
            NSString *price =[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_price)];
            NSString *total_cut = [NSString stringWithFormat:@"已优惠%@元",STRING_FROM_0_FLOAT(total_cutfloat)];
            int count = BACKINFO_DIC_2_INT(data, @"count");
            model.count = count;
            model.total_play_price =[NSString stringWithFormat:@"%@",STRING_FROM_0_FLOAT([model.play_price floatValue] * count)];
            NSMutableArray *dataArr = weakSelf.dataArray.mutableCopy;
            if (count == 0) {
                [dataArr removeObjectAtIndex:path.row];
            } else {
                [dataArr replaceObjectAtIndex:path.row withObject:model.modelToJSONObject];
            }
            weakSelf.dataArray = dataArr.copy;

            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat total_price333 = 0;
                CCShopBottomView *alertView = (CCShopBottomView *)[weakSelf.superview.superview viewWithTag:10000];
                if (self.isChexiao) {
                    NSString *string = alertView.priceLab.text;
                    string = [string stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                    total_price333 = [string floatValue];
                    if (isAdd) {
                        total_price333 = total_price333 + [model.play_price floatValue];
                    } else {
                        total_price333 = total_price333 - [model.play_price floatValue];
                    }
                }
                //189-00
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.isChexiao ? [NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(total_price333)] : price];
                if (self.isChexiao) {
                    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f]
                                           range:NSMakeRange(0, 1)];
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                      green:255.0f/255.0f
                                                                                                       blue:255.0f/255.0f
                                                                                                      alpha:1.0f]
                                           range:NSMakeRange(0, 1)];
                    //189-00 text-style1
                    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:19.0f]
                                           range:NSMakeRange(1, STRING_FROM_0_FLOAT(total_price333).length)];
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f
                                                                                                      green:255.0f/255.0f
                                                                                                       blue:255.0f/255.0f
                                                                                                      alpha:1.0f]
                                           range:NSMakeRange(1, STRING_FROM_0_FLOAT(total_price333).length)];
                    alertView.priceLab.attributedText = attributedString;
                } else {
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
                    alertView.priceLab.attributedText = attributedString;
                    weakSelf.totalCutLab.text = total_cut;
                }

//                [alertView.shopCarImage showBadgeWithStyle:WBadgeStyleNumber
//                                                     value:self.isChexiao?[data[@"count"] integerValue]: weakSelf.dataArray.count
//                                                   animationType:WBadgeAnimTypeNone];
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
- (void)botBtnClick:(UIButton *)btn
{
    NSDictionary *params = @{};
    NSString *path =self.isChexiao ? @"/app0/caraddcarts/0/" : @"/app0/mcarts/0/";
    [[STHttpResquest sharedManager] requestWithMethod:DELETE
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            CCShopBottomView *alertView = (CCShopBottomView *)[self.superview.superview viewWithTag:10000];
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
            alertView.priceLab.attributedText = attributedString;
            [alertView.shopCarImage clearBadge];
            [alertView hide];
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
        self.totalCutLab.hidden = YES;
    } else {
        self.totalCutLab.hidden = NO;
        results = _DataDic[@"results"];
    }
    self.dataArray = results;
    if (self.dataArray.count) {
        [self.noDataView removeFromSuperview];
    } else {
        [self addSubview:self.noDataView];
        [self.noDataView masMakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self).mas_offset(71);
            make.width.mas_equalTo(Window_W);
            make.bottom.mas_equalTo(self);
        }];
    }
    self.totalCutLab.text = [NSString stringWithFormat:@"已优惠%@元",STRING_FROM_0_FLOAT([_DataDic[@"total_cut"] floatValue])];
    [self.tableView reloadData];
}

- (KKNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[KKNoDataView alloc] init];
        _noDataView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _noDataView.imageView.layer.masksToBounds = YES;
    }
    return _noDataView;
}



@end
