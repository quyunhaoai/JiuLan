//
//  CCSmallShopViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/8.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCSmallShopViewController.h"
#import "HXCharts.h"
#import "CCInGoodsListViewController.h"
#import "CClittleInfoModel.h"
#import "CCSalesTableModel.h"

#import "LineBarChart.h"

#import "LineData.h"
#import "BarData.h"
#import "LineDataSet.h"
#import "LineChart.h"
@interface CCSmallShopViewController ()<UITableViewDelegate,UITableViewDataSource,SegmentTapViewDelegate>
@property (nonatomic, strong) SegmentTapView *segment;
@property (strong, nonatomic) CCSmallShopHeadView *headView;
@property (nonatomic,strong) CClittleInfoModel *infoModel;  //
@property (nonatomic,strong) CCSalesTableModel *tableModel;
@property (strong, nonatomic) NSArray *ZheXianArray;   //
@property (nonatomic,copy) NSString *types;

@property (nonatomic) LineBarChart * lineBarChart;

@property (nonatomic, strong) BarData * barData1;
@property (nonatomic, strong) BarData * barData2;
@property (nonatomic, strong) BarData * barData3;
@property (nonatomic, strong) BarData * barData4;

@property (nonatomic, strong) LineData * line;
@property (nonatomic, strong) LineChart * lineChart;
@property (strong, nonatomic) NSDictionary * zhexianDic;
@property (strong, nonatomic) NSDictionary * lirunDic;    //
@property (assign, nonatomic) NSInteger selectTypes;    //
@property (assign, nonatomic) BOOL isShowBackEx; //
@end

@implementation CCSmallShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithTitle:@"小店"];
    [(UIButton *)self.navTitleView.leftBtns[0] setHidden:YES];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.headView.frame = CGRectMake(0, 0, Window_W, 230);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    XYWeakSelf;
    self.headView.clcikView = ^(NSInteger tag) {
        CCInGoodsListViewController *vc = [CCInGoodsListViewController new];
        vc.types = STRING_FROM_INTAGER(tag-1000);
        if (tag == 1000) {
            vc.navTitleStr = @"进货商品";
        } else if (tag == 1001) {
            vc.navTitleStr = @"销售商品";
        } else if(tag == 1002) {
            vc.navTitleStr = @"库存商品";
        } else if(tag == 1102){
            vc.navTitleStr = @"临期预警";
        } else if(tag == 1101){
            vc.navTitleStr = @"低库存预警";
        } else if(tag == 1100){
            vc.navTitleStr = @"高库存预警";
        }
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.types= @"0";
    self.selectTypes = 0;
    [self initData];
    [self addTableViewHeadRefresh];
}
- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/littleinfo/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            
            weakSelf.infoModel = [CClittleInfoModel modelWithJSON:data];
            weakSelf.headView.model = weakSelf.infoModel;
            [weakSelf getSalesData];
            [weakSelf.tableView.mj_header endRefreshing];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}
- (void)getSalesData {
    XYWeakSelf;
    NSDictionary *params = @{@"types":self.types,
    };
    NSString *path = @"/app0/salesanalysis/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.tableModel = [CCSalesTableModel modelWithJSON:data];
            [weakSelf getprofitanalysis];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)getprofitanalysis {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/profitanalysis/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary  *data = dic[@"data"];
            weakSelf.lirunDic = data;
            [weakSelf getZheXianData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)getZheXianData {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path = @"/app0/profitpercentanalysis/";
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        weakSelf.showErrorView = NO;
        if(status == 0){
            NSDictionary *data = dic[@"data"];
            weakSelf.ZheXianArray = data[@"data"];
            weakSelf.zhexianDic = data;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 0) {
        [self initSegmentInView:cell.contentView];
        UIImageView *areaIcon = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            [view setImage:IMAGE_NAME(@"奖杯图标")];
            view;
        });
        [cell.contentView addSubview:areaIcon];
        [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(13, 13));
            make.top.mas_equalTo(cell.contentView).mas_offset(60);
        }];
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"销量前7商品";
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(areaIcon.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(177, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(60);
        }];
        NSArray *color1 = @[[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f],[UIColor colorWithRed:117.0f/255.0f green:221.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
        [self initChartsInview:cell.contentView barChartX:78 andColors:color1];
        UIView *line = [UIView new];
        line.backgroundColor = UIColorHex(0xf7f7f7);
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(Window_W-40, 1));
            make.top.mas_equalTo(cell.contentView).mas_offset(305);
        }];
        UIImageView *areaIcon1 = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            [view setImage:IMAGE_NAME(@"奖杯图标")];
            view;
        });
        [cell.contentView addSubview:areaIcon1];
        [areaIcon1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(13, 13));
            make.top.mas_equalTo(cell.contentView).mas_offset(325);
        }];
        UILabel *nameLab1 = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"销量后7商品";
            view ;
        });
        [cell.contentView addSubview:nameLab1];
        [nameLab1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(areaIcon.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(177, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(325);
        }];
        NSArray *color2 = @[[UIColor colorWithRed:255.0f/255.0f green:157.0f/255.0f blue:52.0f/255.0f alpha:1.0f],[UIColor colorWithRed:255.0f/255.0f green:214.0f/255.0f blue:171.0f/255.0f alpha:1.0f]];
        [self initChartsIn2view:cell.contentView barChartX:351 andColors:color2];
    }else if (indexPath.section == 1 || indexPath.section == 2) {
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(15);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"利润分析";
            view ;
        });
        [cell.contentView addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(77, 14));
            make.top.mas_equalTo(cell.contentView).mas_offset(15);
        }];

        if (indexPath.section == 2) {
            nameLab.text = @"毛利率分析";
            UILabel *nameLab2 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(12);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.text = @"单位：%";
                view.userInteractionEnabled = YES;
                view ;
            });
            [cell.contentView addSubview:nameLab2];
            [nameLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.contentView).mas_offset(-20);
                make.size.mas_equalTo(CGSizeMake(77, 14));
                make.top.mas_equalTo(cell.contentView).mas_offset(15);
            }];
            [self initChatsZheLineTuInView:cell.contentView];
        } else {
            UILabel *nameLab2 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(12);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentRight;
                view.text = @"查看明细";
                view.userInteractionEnabled = YES;
                view ;
            });
            [cell.contentView addSubview:nameLab2];
            [nameLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.contentView).mas_offset(-32);
                make.size.mas_equalTo(CGSizeMake(77, 14));
                make.top.mas_equalTo(cell.contentView).mas_offset(15);
            }];

            UIImageView *areaIcon = ({
                UIImageView *view = [UIImageView new];
                view.contentMode = 0 ;
                view.layer.masksToBounds = YES ;
                view.userInteractionEnabled = YES ;
                [view setImage:IMAGE_NAME(@"右箭头灰")];
                 
                view;
            });
            [cell.contentView addSubview:areaIcon];
            [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameLab2.mas_right).mas_offset(5);
                make.size.mas_equalTo(CGSizeMake(7, 12));
                make.centerY.mas_equalTo(nameLab2.mas_centerY);
            }];
            UILabel *nameLab3 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(12);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentLeft;
                view.text = @"单位：万元";
                view.userInteractionEnabled = YES;
                view ;
            });
            [cell.contentView addSubview:nameLab3];
            [nameLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.contentView).mas_offset(-20);
                make.size.mas_equalTo(CGSizeMake(77, 14));
                make.top.mas_equalTo(nameLab2.mas_bottom).mas_offset(15);
            }];
            
            UILabel *nameLab4 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(12);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentCenter;
                view.userInteractionEnabled = YES;
                view ;
            });
            [cell.contentView addSubview:nameLab4];
            [nameLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.contentView).mas_offset(-10);
                make.size.mas_equalTo(CGSizeMake(177, 14));
                make.top.mas_equalTo(nameLab2.mas_bottom).mas_offset(15);
            }];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
            NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:@"销售额"];
            [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
            [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
            // 创建图片图片附件
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            attach.image = [UIImage imageWithColor:krgb(146,229,225)];
            attach.bounds = CGRectMake(0, 0, 7, 7);
            NSAttributedString *attachString2 = [NSAttributedString attributedStringWithAttachment:attach];
            //302
            NSString *str1 = @"利润";
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
            [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, str1.length)];
            [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f
                                                                                                 alpha:1.0f] range:NSMakeRange(0, str1.length)];
            NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
            attach2.image = [UIImage imageWithColor:kMainColor];
            attach2.bounds = CGRectMake(0, 0, 7, 7);
            NSAttributedString *attributedString3 = [NSAttributedString attributedStringWithAttachment:attach2];
            NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:@"  "];

            [attributedString appendAttributedString:attributedString3];
            [attributedString appendAttributedString:attributedString5];
            [attributedString appendAttributedString:attributedString4];
            [attributedString appendAttributedString:attributedString5];
            [attributedString appendAttributedString:attachString2];
            [attributedString appendAttributedString:attributedString5];
            [attributedString appendAttributedString:attributedString1];
            nameLab4.attributedText = attributedString;
            UILabel *nameLab5 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(25);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentCenter;
                view.userInteractionEnabled = YES;
                view.numberOfLines = 0;
                view ;
            });
            [cell.contentView addSubview:nameLab5];
            [nameLab5 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(100);
                make.size.mas_equalTo(CGSizeMake(77, 69));
                make.bottom.mas_equalTo(cell.contentView.mas_bottom).mas_offset(-10);
            }];
            NSString *str2 =[NSString stringWithFormat:@"%@\n销售额",STRING_FROM_0_FLOAT([self.lirunDic[@"price_sum_sum"] floatValue])];
            NSMutableAttributedString *attributedString6 = [[NSMutableAttributedString alloc] initWithString:str2];
            [attributedString6 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16.0f] range:NSMakeRange(str2.length-3, 3)];
            nameLab5.attributedText = attributedString6;
            UILabel *nameLab6 = ({
                UILabel *view = [UILabel new];
                view.textColor =COLOR_333333;
                view.font = STFont(25);
                view.lineBreakMode = NSLineBreakByTruncatingTail;
                view.backgroundColor = [UIColor clearColor];
                view.textAlignment = NSTextAlignmentCenter;
                view.userInteractionEnabled = YES;
                view.numberOfLines = 0;
                view ;
            });
            [cell.contentView addSubview:nameLab6];
            [nameLab6 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.contentView).mas_offset(-100);
                make.size.mas_equalTo(CGSizeMake(77, 69));
                make.bottom.mas_equalTo(cell.contentView.mas_bottom).mas_offset(-10);
            }];
            NSString *str3 =[NSString stringWithFormat:@"%@\n利润",STRING_FROM_0_FLOAT([self.lirunDic[@"profit_sum_sum"] floatValue])];
            NSMutableAttributedString *attributedString7 = [[NSMutableAttributedString alloc] initWithString:str3];
            [attributedString7 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16.0f] range:NSMakeRange(str3.length-2, 2)];
            nameLab6.attributedText = attributedString7;
            XYWeakSelf;
            [nameLab2 addTapGestureWithBlock:^(UIView *gestureView) {
                CCInGoodsListViewController *vc = [CCInGoodsListViewController new];
                vc.types =@"103";
                vc.navTitleStr = @"利润统计";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
            [self initChatsTowZHuzhuangTU:cell.contentView];
        }
    }
    return cell;
}

- (void)initChartsInview:(UIView *)view barChartX:(CGFloat )X andColors:(NSArray *)colorArr{
    CGFloat barChartWidth = 7 * 45+21;
    CGFloat barChartHeight = 207;
    
    CGFloat barChartX = (Window_W-barChartWidth-20)/2;
    CGFloat barChartY = X;
    ///渐变色
    HXBarChart *bar = [[HXBarChart alloc] initWithFrame:CGRectMake(barChartX, barChartY, barChartWidth, barChartHeight) withMarkLabelCount:7 withOrientationType:OrientationVertical];
    [view addSubview:bar];
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *colorArrs = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titleArr2 = [NSMutableArray arrayWithCapacity:0];
        int i = 0;
    for (Hot_10Item *item in self.tableModel.hot_10) {
        [titleArr addObject:item.goods_name];
        [valueArr addObject:STRING_FROM_INTAGER(item.count)];
        [colorArrs addObject:colorArr];
        i++;
        [titleArr2 addObject:[NSString stringWithFormat:@"NO.%d",i]];
    }
    bar.titleArray2 = titleArr;
    bar.titleArray = titleArr2;
    bar.valueArray = valueArr;
    bar.colorArray = colorArrs;
    bar.locations = @[@0.15,@0.85];
    bar.markTextColor = COLOR_333333;
    bar.markTextFont = [UIFont systemFontOfSize:10];//4b4e52
    bar.xlineColor = UIColorHex(0xf7f7f7);;
    bar.barWidth = 10;
    bar.margin = 32;
    [bar drawChart];
}
- (void)initChartsIn2view:(UIView *)view barChartX:(CGFloat )X andColors:(NSArray *)colorArr{
    CGFloat barChartWidth = 7 * 45+21;
    CGFloat barChartHeight = 207;
    
    CGFloat barChartX = (Window_W-barChartWidth-20)/2;
    CGFloat barChartY = X;
    ///渐变色
    HXBarChart *bar = [[HXBarChart alloc] initWithFrame:CGRectMake(barChartX, barChartY, barChartWidth, barChartHeight) withMarkLabelCount:7 withOrientationType:OrientationVertical];
    [view addSubview:bar];
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *colorArrs = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titleArr2 = [NSMutableArray arrayWithCapacity:0];
        int i = 0;
    for (Hot_10Item *item in self.tableModel.unhot_10) {
        [titleArr addObject:item.goods_name];
        [valueArr addObject:STRING_FROM_INTAGER(item.count)];
        [colorArrs addObject:colorArr];
        i++;
        [titleArr2 addObject:[NSString stringWithFormat:@"NO.%d",i]];
    }
    bar.titleArray2 = titleArr;
    bar.titleArray = titleArr2;
    bar.valueArray = valueArr;
    bar.colorArray = colorArrs;
    bar.locations = @[@0.15,@0.85];
    bar.markTextColor = COLOR_333333;
    bar.markTextFont = [UIFont systemFontOfSize:10];//4b4e52
    bar.xlineColor = UIColorHex(0xf7f7f7);;
    bar.barWidth = 10;
    bar.margin = 32;
    [bar drawChart];
}
-(void)initSegmentInView:(UIView *)view {
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(10, 10, Window_W-20, 40) withDataArray:@[@"本周",@"本月",@"本季",@"本年"] withFont:15 wihtLineWidth:40];
    self.segment.backgroundColor = kWhiteColor;
    self.segment.delegate = self;
    self.segment.textSelectedColor = kMainColor;
    self.segment.textNomalColor = COLOR_333333;
    self.segment.lineColor = kMainColor;
    [self.segment selectIndex:self.selectTypes+1];
    [view addSubview:self.segment];
}

- (void)selectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long )index);
    self.types = STRING_FROM_INTAGER(index);
    self.selectTypes = index;
    [self getSalesData];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 227;
    } else if (indexPath.section == 1){
        return 356;
    } else {
        return 584;
    }
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 5);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        
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
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
}

- (CCSmallShopHeadView *)headView {
    if (!_headView) {
        _headView = [[CCSmallShopHeadView alloc] init];
    }
    return _headView;
}

- (void)initChatsZheLineTuInView:(UIView *)view {
    CGFloat lineChartWidth = self.view.frame.size.width-40;
    CGFloat lineChartHeight = 149;
    CGFloat lineChartX = 6;
    CGFloat lineChartY = 50;
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in self.ZheXianArray) {
        [titleArr addObject:[NSString stringWithFormat:@"%d月",[dict[@"month"] intValue]]];
        [valueArr addObject:[NSNumber numberWithInt:[dict[@"percent"] intValue]]];
    }
    LineData * line = [[LineData alloc] init];
    line.lineWidth = 1;
    line.lineColor = [UIColor colorWithRed:255.0f/255.0f green:206.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    line.dataAry = valueArr;
    line.shapeRadius = 1.5;
    line.stringFont = [UIFont systemFontOfSize:10];
    line.dataFormatter = @"%.f";
    line.stringColor = kMainColor;
    line.lineFillColor = [UIColor colorWithRed:255.0f/255.0f green:206.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    line.gradientFillColors = @[(__bridge id)kClearColor.CGColor, (__bridge id)kClearColor.CGColor];
    line.locations = @[@0.7, @1];
    line.shapeLineWidth = 1;
    _line = line;
    
    LineDataSet * lineSet = [[LineDataSet alloc] init];
    lineSet.insets = UIEdgeInsetsMake(30, 50, 30, 30);
    lineSet.lineAry = @[line];
    lineSet.updateNeedAnimation = YES;
    
    lineSet.gridConfig.lineColor = UIColorHex(0xf7f7f7);
    lineSet.gridConfig.lineWidth = .5f;
    lineSet.gridConfig.axisLineColor = COLOR_e5e5e5;
    lineSet.gridConfig.axisLableColor = COLOR_333333;
    
    lineSet.gridConfig.bottomLableAxis.lables = titleArr;
    lineSet.gridConfig.bottomLableAxis.drawStringAxisCenter = YES;
    lineSet.gridConfig.bottomLableAxis.over = 0;
    
    lineSet.gridConfig.leftNumberAxis.splitCount = 4;
    lineSet.gridConfig.leftNumberAxis.max = @([_zhexianDic[@"max"] intValue]);
    lineSet.gridConfig.leftNumberAxis.min = @([_zhexianDic[@"min"] intValue]);
    lineSet.gridConfig.leftNumberAxis.dataFormatter = @"%.f";
    lineSet.gridConfig.leftNumberAxis.showSplitLine = YES;
    
    LineChart * lineChart = [[LineChart alloc] initWithFrame:CGRectMake(lineChartX, lineChartY, lineChartWidth, lineChartHeight)];
    lineChart.lineDataSet = lineSet;
    [lineChart drawLineChart];
    [view addSubview:lineChart];
    [lineChart startAnimationsWithType:LineAnimationRiseType duration:.5f];
    _lineChart = lineChart;
}
- (void)initChatsTowZHuzhuangTU:(UIView *)view {
    NSMutableArray *price = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *profit = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titlearr = [NSMutableArray arrayWithCapacity:0];
    NSArray *array = self.lirunDic[@"data"];
    for (NSDictionary *dic in array) {
        [price addObject:@([dic[@"price_sum"] intValue])];
        [profit addObject:@([dic[@"profit_sum"] intValue])];
        
        [titlearr addObject:[NSString stringWithFormat:@"%d月",[dic[@"month"] intValue]]];
    }
    _barData1 = [[BarData alloc] init];
    _barData1.dataAry = price;
    _barData1.barWidth = 15;
    _barData1.barFillColor = kMainColor;
    _barData1.dataFormatter = @"%.0f";
    _barData1.stringColor = kMainColor;
    _barData1.stringFont = [UIFont systemFontOfSize:GG_SIZE_CONVERT(11)];
    _barData2 = [[BarData alloc] init];
    _barData2.dataAry = profit;
    _barData2.barWidth = 15;
    _barData2.barFillColor = krgb(146,229,225);
    _barData2.dataFormatter = @"%.0f";
    _barData2.stringColor = kMainColor;
    _barData2.stringFont = [UIFont systemFontOfSize:GG_SIZE_CONVERT(11)];
    LineBarDataSet * lineBarSet = [[LineBarDataSet alloc] init];
    lineBarSet.insets = UIEdgeInsetsMake(30, 40, 30, 40);
    lineBarSet.barAry = @[_barData1, _barData2];
    lineBarSet.updateNeedAnimation = YES;
    lineBarSet.gridConfig.lineColor = UIColorHex(0xf7f7f7);;
    lineBarSet.gridConfig.axisLineColor = COLOR_e5e5e5;
    lineBarSet.gridConfig.axisLableColor = COLOR_333333;
    
    lineBarSet.gridConfig.bottomLableAxis.lables = titlearr;
    lineBarSet.gridConfig.bottomLableAxis.drawStringAxisCenter = YES;
    lineBarSet.gridConfig.bottomLableAxis.showSplitLine = YES;
    lineBarSet.gridConfig.bottomLableAxis.over = 2;
    lineBarSet.gridConfig.bottomLableAxis.showQueryLable = YES;
    
    lineBarSet.gridConfig.leftNumberAxis.splitCount = 4;
    lineBarSet.gridConfig.leftNumberAxis.dataFormatter = @"%.0f";
    lineBarSet.gridConfig.leftNumberAxis.showSplitLine = YES;
    lineBarSet.gridConfig.leftNumberAxis.showQueryLable = YES;

    _lineBarChart = [[LineBarChart alloc] initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width - 40, 200)];
    _lineBarChart.lineBarDataSet = lineBarSet;
    [_lineBarChart drawLineBarChart];
    [view addSubview:_lineBarChart];
    [_lineBarChart startBarAnimationsWithType:0 duration:.8f];
}


@end
