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
    cell.path = indexPath;
    return cell;
}
- (void)clickPPNumberWithItem:(id)item isAdd:(BOOL)isAdd indexPaht:(NSIndexPath *)path ppnumberButton:(PPNumberButton *)numberButton{
    CCShopCarListModel *model = (CCShopCarListModel *)item;
    NSString *total_price =[NSString stringWithFormat:@"%.2f",BACKINFO_DIC_2_FLOAT(self.DataDic, @"total_price")];
    NSString *total_cut = [NSString stringWithFormat:@"%.2f",BACKINFO_DIC_2_FLOAT(self.DataDic, @"total_cut")];
    XYWeakSelf;
    NSDictionary *params = @{@"total_price":total_price,
                             @"total_cut":total_cut,
                             @"point":isAdd ? @(1):@(0),
    };
    NSString *paths =[NSString stringWithFormat:@"/app0/mcarts/%ld/",model.ccid];
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
            NSString *price =[NSString stringWithFormat:@"￥%.2f",total_price];
            NSString *total_cut = [NSString stringWithFormat:@"已优惠%.2f元",total_cutfloat];
            int count = BACKINFO_DIC_2_INT(data, @"count");
            model.count = count;
            model.total_play_price =[NSString stringWithFormat:@"%.2f",[model.play_price floatValue] * count];
            NSMutableArray *dataArr = weakSelf.dataArray.mutableCopy;
            NSLog(@"---%@",model.modelToJSONObject);
            if (count == 0) {
                [dataArr removeObjectAtIndex:path.row];
            } else {
                [dataArr replaceObjectAtIndex:path.row withObject:model.modelToJSONObject];
            }
            weakSelf.dataArray = dataArr.copy;

            dispatch_async(dispatch_get_main_queue(), ^{
                CCShopBottomView *alertView = (CCShopBottomView *)[weakSelf.superview.superview viewWithTag:10000];
                //189-00
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
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
//                if (count == 0) {
                    [weakSelf.tableView reloadData];
//                }
//                numberButton.currentNumber = count;
//                [weakSelf.tableView reloadRowAtIndexPath:path withRowAnimation:UITableViewRowAnimationNone];
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
    NSString *path = @"/app0/mcarts/0/";
    [[STHttpResquest sharedManager] requestWithMethod:DELETE
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            CCShopBottomView *alertView = (CCShopBottomView *)[self.superview.superview viewWithTag:10000];
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
    NSArray *results = _DataDic[@"results"];
    self.dataArray = results;
    self.totalCutLab.text = [NSString stringWithFormat:@"已优惠%.2f元",[_DataDic[@"total_cut"] floatValue]];
    [self.tableView reloadData];
}




@end
